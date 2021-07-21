% Input arguments: 
% Xtest:  -A N-by-M matrix of testing dataset. N is the number of instances. M: the dimension of each attribute or the number of input nodes for SBELM  
% ttest:  - the respective labels of Xtest.
% label:  -the set of labels (C-by-1) of each category.  
% allmode: -the C*(C-1)/2 classifiers trained by pariwise SBELM
% number_class: -the number of categories 
% classifier: the SBELM model or BELM. Default value denotes SBELM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output arguments:
% Prob:  -A N-by-C matrix, the predicted probabilities of the testing points  
% TestingAccuracies: -the accuracy of testing dataset.
%For detailed analysis, pls refer to paper
% "Sparse Bayesian Extreme Learning Machine for Multi-classification" by
% Jiahua Luo, Chi-man Vong.
%%%%    Authors:    JIAHUA LUO, CHI-MAN VONG
%%%%    UNIVERSITY OF MACAU, MACAO, CHINA
%%%%    EMAIL:      mb15457@umac.mo; cmvong@umac.mo
%%%%    WEBSITE:    http://www.fst.umac.mo/en/staff/fstcmv.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Prob,TestingAccuracies,execute_time]=Sbelm_Predict(Xtest,ttest,label, allmodel,number_class,classifier)
if isempty(allmodel)
    fprintf('the trained model is empty in the Sbelm_predict function\n');
    return;
end
SBELM=1;
BELM=0;
if strcmp(classifier,'SBELM')~=0
    SBELM = 1;
elseif strcmp(classifier,'BELM')~=0
    SBELM=0;
    BELM= 1;
end
ClassifierNum = size(allmodel,2);  %count the number of pairwise classifiers
[N,M] = size(Xtest);
testNRs = zeros(N,ClassifierNum);  %
clNo=1;
start_time = tic;
 for i=1: number_class
   for j=i+1: number_class
      model = allmodel(1,clNo);
 if SBELM || BELM
    InputWeight=model.Wih; %
    BiasofHiddenNeurons=model.hiddenBias;
    tempH=Xtest*InputWeight;
    for n=1:N
     tempH(n,:)= tempH(n,:)+BiasofHiddenNeurons';
    end
   Omega = Sbelm_HiddenActivation(tempH, model.hiddenfunc);  %hidden activation
   if strcmp(model.usedHiddenbias,'y')
     Omega = [Omega,ones(N,1)];
   end
 end
   OutputWeight = model.Who;
   y_output	= Omega*OutputWeight;
   y_output=1./(1+exp(-y_output));
   testNRs(:,clNo) = y_output;   
   clNo=clNo+1;
    clear model InputWeight BiasofHiddenNeurons tempHb y_output Omega OutputWeight;
   end 
 end
   %multiclass probability estimated by pairwise coupling
   r=zeros(number_class, number_class);
   Prob = zeros(N,number_class);
   TestingAccuracies=0;  %statistics accuracy
%  if number_class>2
   for n=1: N
     if number_class>2 %multiclass
       m=1;
       r=zeros(number_class, number_class);
       for i=1:number_class
         for j=i+1: number_class
             r(j,i)=testNRs(n,m);  %the pairwise probability matrix
             r(i,j)=1-r(j,i);
             m= m+1;
         end 
       end
       [p]=Sbelm_multiclass_probability(number_class,  r); %estimate the overall posterior probability    
       [C,I] = max(p);
        Prob(n,:) = p;
     else %binary class
        if testNRs(n)>0.5
            I = 2;
        else
            I = 1;            
        end
       Prob(n,1) = 1-testNRs(n);
       Prob(n,2) = testNRs(n);
     end
     if ttest(n)==label(I)   %accuracy
       TestingAccuracies = TestingAccuracies+1;
     end   
   end
   execute_time = toc(start_time);
   TestingAccuracies= TestingAccuracies/N*100; 
