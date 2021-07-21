% The approximation of gauss from Laplace, to find the center model of Gauss and covariance with 
% the Newton-Raphson method 'iterative reweighted least-squares (IRLS)',
% for theoretical inference, pls refer to our paper "Sparse Bayesian Extreme Learning
% Machine for Multi-classification" by Jiahua Luo, Chi-Man Vong.etc
% This program is modified from the work of Micheal  Tipping(http://www.miketipping.com/sparsebayes.htm).
% Input arguments:
% PHI:       -the hidden output matrix of SBELM
% t:         -the expected output
% W         - the estimated weights from last iteraton
% Alpha     -the estimated Alpha from last iteration
% its       -the number of maximum iteration for IRLS
% output arguments:
% W         -the new updated w
% diagSigOfHessian:        -the diagonal matrix of inversed Hessian matrix
%                          for updating the new Alpha
% isFailed:      - the flag of whether the hessian matrix is singual or
%                  ill-conditonal
%%%%    Authors:    JIAHUA LUO, CHI-MAN VONG
%%%%    UNIVERSITY OF MACAU, MACAO, CHINA
%%%%    EMAIL:      mb15457@umac.mo; cmvong@umac.mo
%%%%    WEBSITE:    http://www.fst.umac.mo/en/staff/fstcmv.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [W, diagSigOfHessian,isFailed] = SB_PosteriorMode(PHI,t,W,Alpha,its)
% This is the per-parameter gradient-norm threshold for termination
GRATITUDE_STOP	= 1e-6;
% Limit to resolution of search step
LAMBDA_MIN	= 2^(-8);
diagSigOfHessian = [];
isFailed=false; %indicator: if training fails
[N L]	= size(PHI);
M 	= length(W);
A	= diag(Alpha);
errs	= 0;
Decision_Value	= PHI*W;
Pred_y	= sigmoid(Decision_Value);
t	= logical(t);
% Compute initial value of log posterior (as an error)
data_term	= -(sum(log(Pred_y(t))) + sum(log(1-Pred_y(~t))))/N;
regulariser	= (Alpha'*(W.^2))/(2*N);
err_new		=  data_term + regulariser;
for i=1:its
  B	= Pred_y.*(1-Pred_y);
  PHIV	= PHI .* (B * ones(1,L));
  e	= (t-Pred_y);
% Compute gradient vector and Hessian matrix
%-----------------------------------------------------------------------------------------------------------------------  
% g = -alpha.*w;  % sequentially update Hessian matrix and gradient. when implemented in c++/java, use this method 
% Hessian = A;
%   for k=1:N
%       g = g+PHI(k,:)'*(t(k)-y(k));
%       Hessian = Hessian+y(k)*(1-y(k))*PHI(k,:)'*PHI(k,:);
%   end
%--------------------------------------------------------------------------
  g		= PHI'*e - Alpha.*W;
  Hessian	= (PHIV'*PHI + A);
  condHess	= rcond(Hessian); % judge if the hessian matrix is ill-conditioned
  if condHess<eps   
   if i==1
      %W = [];
      isFailed=true;
      return;
   else % calculate the diagSig with the Cholesky factorization of last iteration 
     break;
   end
  end
  errs	= err_new;  %
  % See if converged
  if i>=2 & norm(g)/M<GRATITUDE_STOP
    %errs	= errs(1:i);
    break
  end
try
  chol_HessU		= chol(Hessian);
catch
   if i==1
      %W=[];
      isFailed=true;
      return;
   else
     break;
   end
end
  delta_w	= chol_HessU\(chol_HessU'\ g);
  lambda	= 1;
  while lambda>LAMBDA_MIN
    W_new	= W + lambda*delta_w;
    Decision_Value	= PHI*W_new;
    Pred_y	= sigmoid(Decision_Value);
    if any(Pred_y(t)==0) | any(Pred_y(~t)==1)
      err_new	= inf;
    else
      data_term		= -(sum(log(Pred_y(t))) + sum(log(1-Pred_y(~t))))/N;
      regulariser	= (Alpha'*(W_new.^2))/(2*N);
      err_new		=  data_term + regulariser;
    end
    if err_new>errs %reduce the step length of lambda
      lambda	= lambda/2;
    else
      W		= W_new;
      lambda	= 0;
      break;
    end
  end
  % Stop iteration, it can't not find more minimum   
  if lambda
    break;
  end
end
% Compute the diagnal elements of inverse of hessian matrix for updating
% new alpha.
chol_inv_HessU	= inv(chol_HessU); %U;%
diagSigOfHessian = diag(chol_inv_HessU.^2);%sum(chol_inv_HessU.^2,2);          
end
%Gamma		= 1 - usedAlpha.*diagSigOfHessian;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Support function: sigmoid
function y = sigmoid(x)
y = 1./(1+exp(-x));
end