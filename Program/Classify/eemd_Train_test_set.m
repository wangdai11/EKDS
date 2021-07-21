clear
clear all
clc

load 'eemd_combine';

%{
1 = class
2 = ASD-Alpha	
3 = ASD-Beta
4 = ASD-Gamma
5 = ASD-Delta
6 = ASD-h
7 = MFDFA-hq_a
8 = MFDFA-hq_b
9 = MFDFA-Dq_a
10 = MFDFA-Dq_b
11 = MFDFA-hq_0
12 = TDSA-ymean
13 = TDSA-ystd
14 = TDSA-yrms
15 = TDSA-ypeak
16 = TDSA-yskew
17 = TDSA-ykurt
18 = TDSA-ycrf
19 = TDSA-yclf
20 = TDSA-ysf
21 = TDSA-yif
%}

%feature such as [1 2:6] means that using ASD features.
nkdata = feature(find(feature(:,1)==1),[1  2:6 ]);
kdata = feature(find(feature(:,1)==2),[1  2:6 ]);
clear feature

[TN1, FN ] = size(nkdata);
[TN2, FN ] = size(kdata);

data = [nkdata;kdata];
data(:, 2:FN)=PreProcessData(data(:, 2:FN));  %scale the data set to [-1,1]  

clear nkdata
clear kdata

nkdata = data(1:TN1,:);
kdata = data(TN1+1:TN1+TN2,:);

rand('seed',1);
rndOnes1 =  (rand(1,TN1)>=0.5)'; %generate 0,1,1,0,1,..  
rndOnes2 =  (rand(1,TN2)>=0.5)'; %generate 0,1,1,0,1,..  

eemd_Train = [nkdata(rndOnes1,:);kdata(rndOnes2,:)];
eemd_Test = [nkdata(~(rndOnes1),:);kdata(~(rndOnes2),:)];
save('eemd_Train.mat','eemd_Train')
save('eemd_Test.mat','eemd_Test')
