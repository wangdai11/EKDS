%% Import data.
clear all  
close all  
clc 

load rawdata.mat
% VMD decomposition 
% parameters for VMD
alpha = 1500;        % moderate bandwidth constraint, according to the optimization value.
K = 10;              % number of mode, according to the optimization value.
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
DC = 0;             % no DC part imposed
init = 1;           % initialize omegas uniformly
tol = 1e-10;

word = 'descend';
datasize = size(ipdata,1);

for i = 1:datasize
rawsignal = ipdata(i,:);
ddata = VMD(rawsignal, alpha, tau, K, DC, init, tol); 
for M = 1:K
vse(M,:)= abs(SampEn(ddata(M,:),2,0.2*std(ddata(M,:))));
end
vT= sum(vse)/K;
x1 = 0;
for M = 1:K
if vse(M,:) < vT
x1 = x1+0;
else
x1 = x1 + ddata(M,:);
end
end
vmddata(i,1:size(x1,2)) = x1;    
clear x1
clear vse
clear vT
clear rawsignal
clear ddata
end

save('vmddata.mat',vmddata)

load chirp
sound(y,Fs)