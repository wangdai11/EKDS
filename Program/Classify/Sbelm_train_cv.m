%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Input arguments:
%  Train_data                         - Training data. format: label: attribute1 :attribute2:....
%  n_folds                            - n-fold cross validation
%  LowerHidden_N [optional]:          - the lower number of hidden neurons for
%                                      selecting best N 
%  UpperNeuron_N [optional]:          - same as LowerHidden_N
%  HiddenStep  [optional] :            LowerHidden_N: HiddenStep:UpperNeuron_N
%  LowerSeed:UpperSeed  [optional]:    -select best seed within [LowerSeed,UpperSeed] with step=1 for generating uniformly
%                                          distributed synapses input-to-hidden layer
% Activation[optional]:               -the activation function of hidden layer    
% classifier[optional]:               -the classifier to be trained
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Output arguments:
% cvAccu                -the best validation accuracy 
% Accu_std              -the standar deviation of n_folds validation accuracies 
% properHiddenNeuronsNum - the determined number of hidden neurons   
% bestSeed               -the determined seed by cv
% label                  -C-by-1 matrix, containing the label of each
%                         category
% number_class           -number of categories 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% As SBELM tends to be insensitive to number of hidden neurons and achieve
% best performance at small number,therefore, users can narrow the gap of
% [LowerHidden_N,UpperNeuron_N] to accerlate the cv process. Also, the seed for generating different
% inout-to-hidden layer weights may have -2% to 2% impact on the accuracy.
% users can further narrow the gap trial of seed. e.g[1:1:5]. or keep it
% fixed.
%For detailed analysis, pls refer to paper
% "Sparse Bayesian Extreme Learning Machine for Multi-classification" by
% Jiahua Luo, Chi-man Vong.
%%%%    Authors:    JIAHUA LUO, CHI-MAN VONG
%%%%    UNIVERSITY OF MACAU, MACAO, CHINA
%%%%    EMAIL:      mb15457@umac.mo; cmvong@umac.mo
%%%%    WEBSITE:    http://www.fst.umac.mo/en/staff/fstcmv.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [cvAccu,Accu_std,properHiddenNeuronsNum,ProperActives_hnum,bestSeed,label,number_class]=Sbelm_train_cv(train_data, n_folds, LowerHidden_N, HiddenStep, UpperNeuron_N,LowerSeed,UpperSeed,Activation, classifier)
%%%%%%%%%%%%%%%%%%initialization
if nargin<8
  classifier = 'SBELM';
end
if ~exist('Activation','var')
  Activation='sigmoid';
end
if nargin<3   %setting default parameters
    LowerHidden_N=10;
    HiddenStep=20;
    UpperNeuron_N=210;
    LowerSeed=1;
    UpperSeed=5;
end

Accu_std = 0;
bestSeed = -10000;
Model = [];
cvAccu =0;
properHiddenNeuronsNum = 0;
highestOutAcc = zeros(n_folds,1);
ProperActives_hnum = zeros(n_folds,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TestingAccuracys =zeros(n_folds,1); 
Actives_hnum = zeros(n_folds,1); 

%UpperHiddenN = 2000;
% train_data=load(TrainingData_File);

 [TN,TM] = size(train_data);
   train_data = sortrows(train_data,1);    
   label=zeros(2,1);                               % saving labels
    label(1)=train_data(1,1);
    cl_instances = zeros(2,1);                    %t
    j=1;
    cl_instances(1)=1;
    for i = 2:TN
        if train_data(i,1) ~= label(j)
            j=j+1;
            label(j) = train_data(i,1);
            cl_instances(j)=1;
        else
            cl_instances(j)=cl_instances(j)+1;  %the number of instances in each class
        end
    end
    number_class=j; 
    %set the n_folds at least equal to the smallest class's instances
    %number
    if min(cl_instances)<n_folds
        n_folds = min(cl_instances);
    end
    numOfDataInFoldsPerClass=zeros(number_class,1);
    rndIndices=zeros(TN,1);   
    %repermutate instances within each category.
    for k=1:number_class
      numOfDataInFoldsPerClass(k)=floor(cl_instances(k)/n_folds); % floor 
      rand('seed',1);
      ra=randperm(cl_instances(k));
      if k==1
          begin =0;
          endf=cl_instances(k);
      else
          begin =endf;%cl_instances(k-1);
          endf=begin+cl_instances(k);
          ra=begin+ra;
      end
      for j=1:cl_instances(k)
          rndIndices(begin+j)=ra(j);
      end
    end

  TempData = zeros(size(train_data));
   for j=1:TN
    %rndIndices(j)
    TempData(j,:) = train_data(rndIndices(j), :); %randomly permutation
   end
   clear train_data;
   train_data = TempData; 
   
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Add a loop for searching best parameters  
%  NumberofHiddenNeurons = 0;  
   Cindex = 0; 
 for NumberofHiddenNeurons=LowerHidden_N:HiddenStep: UpperNeuron_N %%%%%%test some samples of hidden layer
 for seed=LowerSeed:UpperSeed
   start = cputime;    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   %generate cross validation data set %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %n_folds-1 propotion of each class's instances are grouped as trainging
   %data set, the rest 1 propotion is for testing 
   for c=1:n_folds    
        rndIndices = ones(TN,1);
        for k=1:number_class
            if k==1
              Cindex =0;
            else
               Cindex= Cindex+cl_instances(k-1);
            end
            begin=Cindex+(c-1)*numOfDataInFoldsPerClass(k);
            if c<n_folds
                    endf=begin+numOfDataInFoldsPerClass(k);
            else  %c==n_folds
                  endf=Cindex+ cl_instances(k);%-(n_folds-1)*numOfDataInFoldsPerClass(k) );
            end
           for n=begin+1:endf
              rndIndices(n)=0;%zeros(endf-begin+1);
           end
        end
        Training_set=train_data(rndIndices==1,:); 
        Testing_set =train_data(rndIndices==0,:);
        s1 = size(Testing_set,1);
        s2= size(Training_set,1);
        if (s1+s2)~=TN
            fprintf('the number of cross validation set is not equal to the whole data set\n');
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ttest=Testing_set(:,1);  %testing set
        Xtest=Testing_set(:,2:TM);
        T_train= Training_set(:,1);
        X_train= Training_set(:,2:TM);
%        clear Training_set;
       clear Testing_set Training_set;
     %training sbelm 
   if  strcmp(classifier,'SBELM') ~=0 || strcmp(classifier,'BELM')~=0
      if strcmp(classifier,'SBELM')
        [Model,ActiveNodes] = Sbelm_Classify(X_train, T_train, label, number_class, NumberofHiddenNeurons,Activation,seed);      
      else %BELM
         [Model,ActiveNodes] = BELM_Classification(X_train, T_train, label, number_class, NumberofHiddenNeurons,Activation,seed); 
      end
       if isempty(Model)
          fprintf('one pair of (Hidden_num, seed) failed during the training phase\n');
          continue;
      end
      [Prob,TestingAccu, time]=Sbelm_Predict(Xtest,ttest, label, Model,number_class,classifier);  
   end

      TestingAccuracys(c)= TestingAccu;
      Actives_hnum(c) = ActiveNodes;
      clear ttest Xtest T_train X_train;
   end
 %TestingAccuracys
  outAccu = TestingAccuracys;  %cross validation average accuray and its standard deviation
  avg = mean(outAccu);
 % fprintf('cv=%.2f,  cv_std=%.2f, NumberofHiddenNeurons= %d, seed= %d, time=%d\n',avg,std(outAccu),NumberofHiddenNeurons,seed,(cputime-start));
  if cvAccu<avg
    cvAccu =avg;
    properHiddenNeuronsNum = NumberofHiddenNeurons;
    Accu_std = std(outAccu);
    ProperActives_hnum = mean(Actives_hnum);   %calculate the average number of active nodes:  Actives_hnum
    bestSeed = seed;
  end
  end
 end
end
    
    
    
    

 