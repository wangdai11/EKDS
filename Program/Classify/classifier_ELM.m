clear
clear all
clc

load('eemd_Train.mat') %eemd_ vmd_ raw_
load('eemd_Test.mat')
train_data=eemd_Train; 
test_data=eemd_Test;

NumberofHiddenNeurons=200;
ActivationFunction = 'sig';
Elm_Type = 1;

[TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm(train_data, test_data, Elm_Type, NumberofHiddenNeurons, ActivationFunction);
 
fprintf('TrainingAccuracy : %f   TrainingTime : %f\nTestingAccuracy : %f   TestingTime : %f\n',TrainingAccuracy*100 ,TrainingTime, TestingAccuracy * 100,TestingTime);
    

