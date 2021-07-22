%%Non Knock
%% Part1
clear
clc
close all

load class
%MFDFA  
Hq = xlsread('vmd_MFDFA.xlsx','Hq');
tq = xlsread('vmd_MFDFA.xlsx','tq');
hh = xlsread('vmd_MFDFA.xlsx','hh');
Dq = xlsread('vmd_MFDFA.xlsx','Dq');
%ASD
data = xlsread('vmd_ASD.xlsx');
%class
for i = 1:size(Class(:,1),1)
feature(i,1) = str2num(Class(i,1));
end
%'£\','£]','£^','£_','h'
feature(:,2:6) = data;
%'hqmax';
feature(:,7)=hh(:,1);
%'hqmin';
feature(:,8)=hh(:,100);
%'Dqhmax';
feature(:,9)=Dq(:,1);
%'Dqhmin';
feature(:,10)=Dq(:,100);
%'Extq0';
feature(:,11)=(hh(:,50)+hh(:,51))/2;

%TD
tddata = xlsread('vmd_TD.xlsx');
feature(:,12:21)=tddata;

save('vmd_combine.mat','feature')

