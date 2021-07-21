clear all  
close all  
clc 

load Rawdata.mat
rawsignal = ipdata(1549,:);

fs = 48000;
Nstd = 0.2;
NE = 100;
e = eemd(rawsignal,Nstd,NE);
e = e';

%setting
fs = 48000; %wav. file record frequency
ts = 1/fs;  

%Plot IMF time domain
j=1;
subplot(6,2,2*j-1)
plot((0:length(e(j+1,:))-1)/fs,e(j+1,:),'k-');
title('{\it{a}}) IMF_1')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=2;
subplot(6,2,2*j-1)
plot((0:length(e(j+1,:))-1)/fs,e(j+1,:),'k-');
title('{\it{b}}) IMF_2')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=3;
subplot(6,2,2*j-1)
plot((0:length(e(j+1,:))-1)/fs,e(j+1,:),'k-');
title('{\it{c}}) IMF_3')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=4;
subplot(6,2,2*j-1)
plot((0:length(e(j+1,:))-1)/fs,e(j+1,:),'k-');
title('{\it{d}}) IMF_4')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=5;
subplot(6,2,2*j-1)
plot((0:length(e(j+1,:))-1)/fs,e(j+1,:),'k-');
title('{\it{e}}) IMF_5')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=6;
subplot(6,2,2*j-1)
plot((0:length(e(j+1,:))-1)/fs,e(j+1,:),'k-');
title('{\it{f}}) IMF_6')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=1;
subplot(6,2,2*j)
plot((0:length(e(j+1+6,:))-1)/fs,e(j+1+6,:),'k-');
title('{\it{g}}) IMF_7')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=2;
subplot(6,2,2*j)
plot((0:length(e(j+1+6,:))-1)/fs,e(j+1+6,:),'k-');
title('{\it{h}}) IMF_8')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=3;
subplot(6,2,2*j)
plot((0:length(e(j+1+6,:))-1)/fs,e(j+1+6,:),'k-');
title('{\it{i}}) IMF_9')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=4;
subplot(6,2,2*j)
plot((0:length(e(j+1+6,:))-1)/fs,e(j+1+6,:),'k-');
title('{\it{j}}) IMF_{10}')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=5;
subplot(6,2,2*j)
plot((0:length(e(j+1+6,:))-1)/fs,e(j+1+6,:),'k-');
title('{\it{k}}) IMF_{11}')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)



j = 12;
subplot(6,2,j)
plot((0:length(e(j+1,:))-1)/fs,e(j+1,:),'k-');
title(sprintf('Residual signal'))
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

