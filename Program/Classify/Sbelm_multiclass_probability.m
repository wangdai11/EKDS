%algorithm implemented refered from the paper:Probability Estimates for
%Multi-class classification by Pairwise Coupling by Wu, Lin and Weng. The
%second proposed method
% this program was a modification from libsvm c++ version
% input arguments: 
%   -k:   the number of class
%   -r:   the C-by-C matrix of outputs of all binary classifiers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Output argument:
% p: the predicted probability distribution over all categories for an
% instance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p]=Sbelm_multiclass_probability( k,  r)           %algorithm 2, pariwise coupling for multiclassification which is what i need
  max_iter = 100;%max(100,k);
    if max_iter<k
       max_iter=k;
    end
    Q=zeros(k,k);
    Qp=zeros(k,1);
	pQp=0;
    eps=0.005/k;
	p=zeros(k,1);
	for t=1:k   %initialization
		p(t)=1.0/k;  % Valid if k = 1
		Q(t,t)=0;
		for j=1:t-1
			Q(t,t)=Q(t,t)+r(j,t)*r(j,t);
			Q(t,j)=Q(j,t);
        end
		for j=t+1:k
			Q(t,t)=Q(t,t)+r(j,t)*r(j,t);
			Q(t,j)=-r(j,t)*r(t,j);
        end
    end
	for iter=1:max_iter
	 % stopping condition, recalculate QP,pQP for numerical accuracy
		pQp =0;
		for t=1:k 
			Qp(t)=0;
			for j=1:k
				Qp(t)=Qp(t)+Q(t,j)*p(j);
            end
			pQp = pQp+p(t)*Qp(t);
        end
		max_error=0;
		for t=1:k
			error = abs(Qp(t)-pQp);
			if error>max_error
				max_error=error;
            end
        end
		if max_error<eps
            break;
        end
		for t=1:k
			diff = (-Qp(t)+pQp)/Q(t,t);
			p(t)=p(t)+diff;
			pQp=(pQp+diff*(diff*Q(t,t)+2*Qp(t)))/(1+diff)/(1+diff);
			for j=1:k
				Qp(j)=(Qp(j)+diff*Q(t,j))/(1+diff);
				p(j)= p(j)/(1+diff);
            end
        end
    end
	if iter>=max_iter
		fprintf('Exceeds max_iter in multiclass_prob\n');
    end
	clear Q;
	clear Qp;
end
