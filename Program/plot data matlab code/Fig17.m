clear all  
close all  
clc 

Nstd = 0.2;
NE = 100;
alpha = 1500;        % moderate bandwidth constraint, according to the optimization value.
K = 10;              % number of mode, according to the optimization value.
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
DC = 0;             % no DC part imposed
init = 1;           % initialize omegas uniformly
tol = 1e-7;

harmImpact0 = (1:15)*342.3;
harmImpact1 = (0:5)*342.3+87.25;
harmImpact2 = (0:5)*342.3+174.5;
harmImpact3 = (0:5)*342.3+255;

load Rawdata.mat   


fs = 48000; %wav. file record frequency
ts = 1/fs;  


data1 = ipdata(1549,:); 

n=1;
eval(['rawsignal = data',int2str(n),'( ~ isnan(data',int2str(n),'));']); 
e = eemd(rawsignal,Nstd,NE); 
e = e';

v = VMD(rawsignal, alpha, tau, K, DC, init, tol);
%SIGDEN = cmddenoise(rawsignal,'db3',15);

for M = 1:K
vcc=corrcoef(rawsignal,v(M,:));
vccr(M,:) = vcc(1,2);
end
vT1= sum(vccr)/K;
vdata = 0;
for M = 1:K
if vccr(M,:) < vT1
vdata = vdata+0;
else
vdata = vdata + v(M,:);
end
end
eval(['vmdsignal1',int2str(n),'= vdata;']);  

for N = 1:11
ecc=corrcoef(rawsignal,e(N+1,:));
eccr(N,:) = ecc(1,2);
end
eT1= sum(eccr)/11;

edata = 0;
for N = 1:11
if eccr(N,:) < eT1
edata = edata+0;
else
edata = edata + e(N+1,:);
end
end
eval(['eemdsignal1',int2str(n),'= edata;']); 

for M = 1:K
ver(M,:)=sum(abs(v(M,:).^2))/sum(abs(rawsignal).^2);
end
vT2= sum(ver)/K;
vdata = 0;
for M = 1:K
if ver(M,:) < vT2
vdata = vdata+0;
else
vdata = vdata + v(M,:);
end
end
eval(['vmdsignal2',int2str(n),'= vdata;']);  

for N = 1:11
eer(N,:) =sum(abs(e(N+1,:).^2))/sum(abs(rawsignal).^2);
end
eT2= sum(eer)/11;
edata = 0;
for N= 1:11
if eer(N,:) < eT2
edata = edata+0;
else
edata = edata + e(N+1,:);
end
end
eval(['eemdsignal2',int2str(n),'= edata;']); 

for M = 1:K
vse(M,:)= SampEn(v(M,:),2,0.2*std(v(M,:)));
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
eval(['vmdsignal3',int2str(n),'= vdata;']);  

for N = 1:11
ese(N,:) = SampEn(e(N+1,:),2,0.2*std(e(N+1,:)));
end
eT3= sum(ese)/11;
edata = 0;
for N= 1:11
if ese(N,:) < eT3
edata = edata+0;
else
edata = edata + e(N+1,:);
end
end
eval(['eemdsignal3',int2str(n),'= edata;']); 

rawsignal = data1( ~ isnan(data1)); 

harmImpact0 = (1:15)*342.3;
harmImpact1 = (0:5)*342.3+87.25;
harmImpact2 = (0:5)*342.3+174.5;
harmImpact3 = (0:5)*342.3+255;

subplot(3,2,1)
plot((0:length(rawsignal)-1)/fs,rawsignal,'k-');
title('{\it{a}}) Raw data')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)


subplot(3,2,2)
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

subplot(3,2,3)
plot((0:length(edata)-1)/fs,edata,'k-');
title('{\it{c}}) EEMD + sample entropy')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)



subplot(3,2,4)
[ES,F,ENV,T] = envspectrum(eemdsignal31 ,48000 );
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
xlabel('Frequency(Hz)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)


subplot(3,2,5)
plot((0:length(vdata)-1)/fs,vdata,'k-');
title('{\it{c}}) OVME + sample entropy')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)



subplot(3,2,6)
[ES,F,ENV,T] = envspectrum(vmdsignal31 ,48000 );
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
%[Yf, f] = FFTAnalysis(eemdsignal31 , ts );
%plot(f, Yf);
title('{\it{f}}) Envelope spectrum')
xlabel('Frequency(Hz)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)