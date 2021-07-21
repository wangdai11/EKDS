clear
clear all
clc

load 'vmd_Train.mat'%eemd_ vmd_ raw_
load 'vmd_Test.mat'
train_data=vmd_Train; 
test_data=vmd_Test;



[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy,TY] = elm_kernel(train_data, test_data, 1, 1, 'RBF_kernel',1);

 fprintf('TrainingAccuracy : %f   TrainingTime : %f\nTestingAccuracy : %f   TestingTime : %f\n',TrainingAccuracy*100,TrainingTime,TestingAccuracy*100,TestingTime);