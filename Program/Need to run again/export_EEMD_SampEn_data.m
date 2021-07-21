%% Import data.
clear all  
close all  
clc 

load rawdata.mat
% eemd decomposition 
% parameters for eemd
Nstd = 0.2;
NE = 100;
K=11;

word = 'descend';
datasize = size(ipdata,1);

for i = 1:datasize
rawsignal = ipdata(i,:);
edata = eemd(rawsignal,Nstd,NE);
ddata = edata';

for M = 1:K
ese(M,:)= abs(SampEn(ddata(M+1,:),2,0.2*std(ddata(M+1,:))));
end
eT= sum(ese)/K;
x1 = 0;
for M = 1:K
if ese(M,:) < eT
x1 = x1+0;
else
x1 = x1 + ddata(M+1,:);
end
end
eemddata(i,1:size(x1,2)) = x1;  
clear x1
clear ese
clear eT
clear rawsignal
clear ddata
end

save('eemddata.mat',eemddata)

load chirp
sound(y,Fs)