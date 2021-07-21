%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Input argumenets:
%  X_train :                     - N-by-M matrix of training data. 
%                                 N is the number of training
%                               data. M: the dimension of attribute.
%  T_train :                     -observed outputs, recommending labeling as
%                               [0,1,2,...C,]
%  label :                      -labels of all categories.
%  NumberofHiddenNeurons  :     - number of hidden neurons 
%  Activation [optional]  :    - the activation of hidden layer
%  seed [optional]        :    - seed for generating uniformly distributed
%                                synapses for input-to-hidden layer.
%                                different seed may have (+ -)1~2% impact on the testing accuracy. 
% Output arguments: 
%  Model :                - the structure for saving models. contains C*(C-1)/2
%                         classifiers
%  ActiveNodes:           - the mean of active hidden nodes over all
%                          classifiers
% for details please refer to Sparse Bayesian Extreme Learning Machine for
% Multiclassification.
%%%%    Authors:    JIAHUA LUO, CHI-MAN VONG
%%%%    UNIVERSITY OF MACAU, MACAO, CHINA
%%%%    EMAIL:      mb15457@umac.mo; cmvong@umac.mo
%%%%    WEBSITE:    http://www.fst.umac.mo/en/staff/fstcmv.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Model,ActiveNodes] = Sbelm_Classify(X_train, T_train, label, number_class, NumberofHiddenNeurons,Activation,seed)
     if nargin <6
         Activation = 'sigmoid';
     end
     classifiersNo=0;
     cl_num = number_class*(number_class-1)/2;
     ActiveNodes=0;
     totalAct_n=0;
      for i=1: number_class
       for j=i+1: number_class
          Tr = [find(T_train==label(i))',find(T_train==label(j))'];                          %%
          t=T_train(Tr');                    
          X=X_train(Tr',:);
         % [t,X]          
          t(t==label(i))=0;  %setting the main class label as 1
          t(t==label(j))=1; 
          clear Temp;
      
          if nargin<7  % no seed provided
              [pairwisemodel]=PairwiseSbelmClassify(X,t,NumberofHiddenNeurons,Activation);
          else
             [pairwisemodel]=PairwiseSbelmClassify(X,t,NumberofHiddenNeurons,Activation,seed);
          end
 
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
          if isempty(pairwisemodel)
              Model=[];
              return;
          end
          classifiersNo = classifiersNo+1;
          Model(classifiersNo) = pairwisemodel;          
          totalAct_n =totalAct_n+pairwisemodel.L_active;
          clear X t Tr;
       end
      end
      ActiveNodes = totalAct_n/cl_num;
end

% Input arguments: 
% X:         - N-by-M training data just containing two categories'
% t:         - the observed outputs of the two categories labeling as {0,1} 
% seed (optional): -see above description.
% Output argument: 
% model:     - a paiwise model
function [model]=PairwiseSbelmClassify(X,t,NumberofHiddenNeurons,Activation,seed) %seed: option
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxIts=200;
[N, In] = size(X);
%N = size(X,1);
%X
initAlpha	= (1/N)^2;
if nargin<5
   %no seed for generating the hidden layer parameters provided
   [tempH, W_ih, BiasofHiddenNeurons]=Sbelm_Hiddenoutput(X,NumberofHiddenNeurons, Activation);
else 
    [tempH, W_ih, BiasofHiddenNeurons]=Sbelm_Hiddenoutput(X,NumberofHiddenNeurons, Activation,seed);
end
%tempH=SBELM_Hiddenoutput(X,NumberofHiddenNeurons, seed,Activation);
H_train= [tempH ones(N,1)]; 
%estimate the output weights with sparse bayesian learning
%used : the index of active neurons of hidden layer
[W_ho_weights, used, alpha, gamma] = SB_Estimation(H_train,t,initAlpha,maxIts);% 
ActiveNodes_num = size(W_ho_weights,1);
%save model
model=[];
if ActiveNodes_num<1
    return;
end
model.L=NumberofHiddenNeurons;
model.L_active= ActiveNodes_num;
%model.seed = seed;
model.hiddenfunc = Activation;
model.Who = W_ho_weights;
model.Alpha = alpha;
if used(ActiveNodes_num)==(NumberofHiddenNeurons+1) %%%% see if the bias term should be kept
  model.usedHiddenbias = 'y'; 
  model.Wih= W_ih(:,used(1:ActiveNodes_num-1)');
  model.hiddenBias = BiasofHiddenNeurons(used(1:ActiveNodes_num-1));
else       
  model.usedHiddenbias = 'n';
  model.Wih= W_ih(:,used);
  model.hiddenBias = BiasofHiddenNeurons(used);
end
end




