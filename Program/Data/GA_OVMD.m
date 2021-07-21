clear all  
close all  
clc  

ub = [20 10000];                       % Upper boundary of input
lb = [2 100];                       % Lower boundary of input
IntCon = [1,2];

[x,fval] = ga(@fitnessMESEV,2,[],[],[],[],lb,ub,[],IntCon,[]);

