clear
clear all
clc

load 'vmd_Train.mat' %eemd_ vmd_ raw_
load 'vmd_Test.mat'
train_data=vmd_Train; 
test_data=vmd_Test;

lowerHiddenNums=200;
step=10;
upperHiddenNums=200;
lowerSeed=1;
upperSeed=5;
classifier='SBELM';
Activation = 'sigmoid';

n_folds = size(train_data,2);

[TN,TM]=size(train_data);

  %start = cputime;
  %[cvAccu, Accu_std,properHiddenNeuronsNum,ActiveNodes,bestSeed,label,number_class]=Sbelm_train_cv(train_data, n_folds, lowerHiddenNums, step,upperHiddenNums,lowerSeed,upperSeed,Activation,classifier);
   %fprintf('Trained: %.2f,  %.2f,  %d,  %.f,  %d\n',cvAccu, Accu_std,properHiddenNeuronsNum,ActiveNodes,bestSeed);
 %[Model,ActiveNodes] = Sbelm_Classify(train_data(:,2:TM), train_data(:,1), label, number_class, properHiddenNeuronsNum,Activation,bestSeed);      
[Model,ActiveNodes] = Sbelm_Classify(train_data(:,2:TM), train_data(:,1), [1;2], 2, 200,Activation,5);      
%   multiclass probability estimated by pairwise coupling
%   [Prob,TestingAccu,execute_time]=Sbelm_Predict(test_data(:,2:TM),test_data(:,1), label, Model,number_class,classifier);  
[Prob,TestingAccu,execute_time]=Sbelm_Predict(test_data(:,2:TM),test_data(:,1), [1;2], Model,2,classifier);  
   fprintf('predicted: %.2f, %.2f, %.2f\n',TestingAccu,ActiveNodes,execute_time); 
   

