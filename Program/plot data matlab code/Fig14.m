clear all  
close all  
clc 

tau = 0;            % noise-tolerance (no strict fidelity enforcement)
DC = 0;             % no DC part imposed
init = 1;           % initialize omegas uniformly
tol = 1e-7;

load Rawdata.mat   
fs = 48000; %wav. file record frequency
ts = 1/fs;  


data1 = ipdata(1549,:);

n=1;
eval(['rawsignal = data',int2str(n),'( ~ isnan(data',int2str(n),'));']); 

rawsignal = data1( ~ isnan(data1)); 

harmImpact0 = (1:15)*342.3;
harmImpact1 = (0:5)*342.3+87.25;
harmImpact2 = (0:5)*342.3+174.5;
harmImpact3 = (0:5)*342.3+255;

%%
figure(1)
subplot(6,2,1)
plot((0:length(rawsignal )-1)/fs,rawsignal,'k-');
title('{\it{a}}) Raw data')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
subplot(6,2,2)
[ES,F,ENV,T] = envspectrum(rawsignal ,48000 );
plot(F, ES,'k-');
xlim([0 2000])
[X0,Y0] = meshgrid(harmImpact0,ylim*1.5);
[X1,Y1] = meshgrid(harmImpact1,ylim*1.5);
[X2,Y2] = meshgrid(harmImpact2,ylim*1.5);
[X3,Y3] = meshgrid(harmImpact3,ylim*1.5);
hold on
plot(X0,Y0,':r')
plot(X1,Y1,':b')
plot(X2,Y2,':g')
plot(X3,Y3,':m')
%[Yf, f] = FFTAnalysis(rawsignal , ts );
%plot(f, Yf);

hold on;
text(harmImpact1(1)-30,0.0004,'{\it{f}}_0','color','b','FontName','Times New Roman','FontSize',12)
text(harmImpact2(1)-30,0.00045,'{\it{f}}_1','color','g','FontName','Times New Roman','FontSize',12)
text(harmImpact3(1)-30,0.0004,'{\it{f}}_2','color','m','FontName','Times New Roman','FontSize',12)
text(harmImpact0(1)-30,0.00045,'{\it{f}}_3','color','r','FontName','Times New Roman','FontSize',12)
text(harmImpact1(2)-30,0.0004,'2{\it{f}}_0','color','b','FontName','Times New Roman','FontSize',12)
text(harmImpact2(2)-30,0.00045,'2{\it{f}}_1','color','g','FontName','Times New Roman','FontSize',12)
text(harmImpact3(2)-30,0.0004,'2{\it{f}}_2','color','m','FontName','Times New Roman','FontSize',12)
text(harmImpact0(2)-30,0.00045,'2{\it{f}}_3','color','r','FontName','Times New Roman','FontSize',12)
text(harmImpact1(3)-40,0.0004,'3{\it{f}}_0','color','b','FontName','Times New Roman','FontSize',12)
text(harmImpact2(3)-40,0.00045,'3{\it{f}}_1','color','g','FontName','Times New Roman','FontSize',12)
text(harmImpact3(3)-40,0.0004,'3{\it{f}}_2','color','m','FontName','Times New Roman','FontSize',12)
text(harmImpact0(3)-40,0.00045,'3{\it{f}}_3','color','r','FontName','Times New Roman','FontSize',12)
text(harmImpact1(4)-40,0.0004,'4{\it{f}}_0','color','b','FontName','Times New Roman','FontSize',12)
text(harmImpact2(4)-40,0.00045,'4{\it{f}}_1','color','g','FontName','Times New Roman','FontSize',12)
text(harmImpact3(4)-40,0.0004,'4{\it{f}}_2','color','m','FontName','Times New Roman','FontSize',12)
text(harmImpact0(4)-40,0.00045,'4{\it{f}}_3','color','r','FontName','Times New Roman','FontSize',12)
text(harmImpact1(5)-40,0.0004,'5{\it{f}}_0','color','b','FontName','Times New Roman','FontSize',12)
text(harmImpact2(5)-40,0.00045,'5{\it{f}}_1','color','g','FontName','Times New Roman','FontSize',12)
text(harmImpact3(5)-40,0.0004,'5{\it{f}}_2','color','m','FontName','Times New Roman','FontSize',12)
text(harmImpact0(5)-40,0.00045,'5{\it{f}}_3','color','r','FontName','Times New Roman','FontSize',12)
text(harmImpact1(6)-40,0.0004,'6{\it{f}}_0','color','b','FontName','Times New Roman','FontSize',12)
text(harmImpact2(6)-40,0.00045,'6{\it{f}}_1','color','g','FontName','Times New Roman','FontSize',12)
text(harmImpact3(6)-40,0.0004,'6{\it{f}}_2','color','m','FontName','Times New Roman','FontSize',12)


title('{\it{b}}) Envelope spectrum')
xlabel('Frequency(Hz)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

alpha = 1500;        % moderate bandwidth constraint, according to the optimization value.
K = 10;              % number of mode, according to the optimization value.
v = VMD(rawsignal, alpha, tau, K, DC, init, tol);
for M = 1:K
vse(M,:)= abs(SampEn(v(M,:),2,0.2*std(v(M,:))));
end
vT3= sum(vse)/K;
vdata = 0;
for M = 1:K
if vse(M,:) < vT3
vdata = vdata+0;
else
vdata = vdata + v(M,:);
end
end
vmdsignal= vdata;
clear vse
subplot(6,2,3)
plot((0:length(vmdsignal )-1)/fs,vmdsignal,'k-');

title('{\it{c}}) VMD + sample entropy')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
subplot(6,2,4)
[ES,F,ENV,T] = envspectrum(vmdsignal ,48000 );
plot(F, ES,'k-');
xlim([0 2000])
[X0,Y0] = meshgrid(harmImpact0,ylim*1.5);
[X1,Y1] = meshgrid(harmImpact1,ylim*1.5);
[X2,Y2] = meshgrid(harmImpact2,ylim*1.5);
[X3,Y3] = meshgrid(harmImpact3,ylim*1.5);
hold on
plot(X0,Y0,':r')
plot(X1,Y1,':b')
plot(X2,Y2,':g')
plot(X3,Y3,':m')
title('{\it{d}}) Envelope spectrum')
text(1000,0.0003,'K=10,\alpha=1500','FontName','Times New Roman','FontSize',20)

xlabel('Frequency(Hz)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)


%
alpha = 5000;        % moderate bandwidth constraint, according to the optimization value.
K = 10;              % number of mode, according to the optimization value.
v = VMD(rawsignal, alpha, tau, K, DC, init, tol);
for M = 1:K
vse(M,:)= abs(SampEn(v(M,:),2,0.2*std(v(M,:))));
end
vT3= sum(vse)/K;
vdata = 0;
for M = 1:K
if vse(M,:) < vT3
vdata = vdata+0;
else
vdata = vdata + v(M,:);
end
end
vmdsignal= vdata;
clear vse
subplot(6,2,5)
plot((0:length(vmdsignal )-1)/fs,vmdsignal,'k-');

title('{\it{e}}) VMD + sample entropy')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
subplot(6,2,6)
[ES,F,ENV,T] = envspectrum(vmdsignal ,48000 );
plot(F, ES,'k-');
xlim([0 2000])
[X0,Y0] = meshgrid(harmImpact0,ylim*1.5);
[X1,Y1] = meshgrid(harmImpact1,ylim*1.5);
[X2,Y2] = meshgrid(harmImpact2,ylim*1.5);
[X3,Y3] = meshgrid(harmImpact3,ylim*1.5);
hold on
plot(X0,Y0,':r')
plot(X1,Y1,':b')
plot(X2,Y2,':g')
plot(X3,Y3,':m')
title('{\it{f}}) Envelope spectrum')
text(1000,0.00015,'K=10,\alpha=5000','FontName','Times New Roman','FontSize',20)
xlabel('Frequency(Hz)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

hold on;

alpha = 10000;        % moderate bandwidth constraint, according to the optimization value.
K = 10;              % number of mode, according to the optimization value.
v = VMD(rawsignal, alpha, tau, K, DC, init, tol);
for M = 1:K
vse(M,:)= abs(SampEn(v(M,:),2,0.2*std(v(M,:))));
end
vT3= sum(vse)/K;
vdata = 0;
for M = 1:K
if vse(M,:) < vT3
vdata = vdata+0;
else
vdata = vdata + v(M,:);
end
end
vmdsignal= vdata;
clear vse
subplot(6,2,7)
plot((0:length(vmdsignal )-1)/fs,vmdsignal,'k-');

title('{\it{g}}) VMD + sample entropy')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
subplot(6,2,8)
[ES,F,ENV,T] = envspectrum(vmdsignal ,48000 );
plot(F, ES,'k-');
xlim([0 2000])
[X0,Y0] = meshgrid(harmImpact0,ylim*1.5);
[X1,Y1] = meshgrid(harmImpact1,ylim*1.5);
[X2,Y2] = meshgrid(harmImpact2,ylim*1.5);
[X3,Y3] = meshgrid(harmImpact3,ylim*1.5);
hold on
plot(X0,Y0,':r')
plot(X1,Y1,':b')
plot(X2,Y2,':g')
plot(X3,Y3,':m')
title('{\it{h}}) Envelope spectrum')
text(1000,0.00015,'K=10,\alpha=10000','FontName','Times New Roman','FontSize',20)
xlabel('Frequency(Hz)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
%
alpha = 1500;        % moderate bandwidth constraint, according to the optimization value.
K = 5;              % number of mode, according to the optimization value.
v = VMD(rawsignal, alpha, tau, K, DC, init, tol);
for M = 1:K
vse(M,:)= abs(SampEn(v(M,:),2,0.2*std(v(M,:))));
end
vT3= sum(vse)/K;
vdata = 0;
for M = 1:K
if vse(M,:) < vT3
vdata = vdata+0;
else
vdata = vdata + v(M,:);
end
end
vmdsignal= vdata;
clear vse
subplot(6,2,9)
plot((0:length(vmdsignal )-1)/fs,vmdsignal,'k-');

title('{\it{i}}) VMD + sample entropy')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
subplot(6,2,10)
[ES,F,ENV,T] = envspectrum(vmdsignal ,48000 );
plot(F, ES,'k-');
xlim([0 2000])
[X0,Y0] = meshgrid(harmImpact0,ylim*1.5);
[X1,Y1] = meshgrid(harmImpact1,ylim*1.5);
[X2,Y2] = meshgrid(harmImpact2,ylim*1.5);
[X3,Y3] = meshgrid(harmImpact3,ylim*1.5);
hold on
plot(X0,Y0,':r')
plot(X1,Y1,':b')
plot(X2,Y2,':g')
plot(X3,Y3,':m')
title('{\it{j}}) Envelope spectrum')
text(1000,0.0002,'K=5,\alpha=1500','FontName','Times New Roman','FontSize',20)
xlabel('Frequency(Hz)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
%
alpha = 1500;        % moderate bandwidth constraint, according to the optimization value.
K = 20;              % number of mode, according to the optimization value.
v = VMD(rawsignal, alpha, tau, K, DC, init, tol);
for M = 1:K
vse(M,:)= abs(SampEn(v(M,:),2,0.2*std(v(M,:))));
end
vT3= sum(vse)/K;
vdata = 0;
for M = 1:K
if vse(M,:) < vT3
vdata = vdata+0;
else
vdata = vdata + v(M,:);
end
end
vmdsignal= vdata;
clear vse
subplot(6,2,11)
plot((0:length(vmdsignal )-1)/fs,vmdsignal,'k-');

title('{\it{k}}) VMD + sample entropy')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
subplot(6,2,12)
[ES,F,ENV,T] = envspectrum(vmdsignal ,48000 );
plot(F, ES,'k-');
xlim([0 2000])
[X0,Y0] = meshgrid(harmImpact0,ylim*1.5);
[X1,Y1] = meshgrid(harmImpact1,ylim*1.5);
[X2,Y2] = meshgrid(harmImpact2,ylim*1.5);
[X3,Y3] = meshgrid(harmImpact3,ylim*1.5);
hold on
plot(X0,Y0,':r')
plot(X1,Y1,':b')
plot(X2,Y2,':g')
plot(X3,Y3,':m')
title('{\it{l}}) Envelope spectrum')
text(1000,0.0001,'K=20,\alpha=15000','FontName','Times New Roman','FontSize',20)
xlabel('Frequency(Hz)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
