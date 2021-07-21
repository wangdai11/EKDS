clear all  
close all  
clc 

load Rawdata.mat
rawsignal = ipdata(1549,:);

fs = 48000;
alpha = 1500;        % moderate bandwidth constraint, according to the optimization value.
K = 10;              % number of mode, according to the optimization value.
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
DC = 0;             % no DC part imposed
init = 1;           % initialize omegas uniformly
tol = 1e-10;
v = VMD(rawsignal, alpha, tau, K, DC, init, tol);

%setting
fs = 48000; %wav. file record frequency
ts = 1/fs;  

%Plot IMF
figure(1)

j=1;
subplot(5,2,2*j-1)
plot((0:length(v(j,:))-1)/fs,v(j,:),'k-');
title('{\it{a}}) IMF_1')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=2;
subplot(5,2,2*j-1)
plot((0:length(v(j,:))-1)/fs,v(j,:),'k-');
title('{\it{b}}) IMF_2')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=3;
subplot(5,2,2*j-1)
plot((0:length(v(j,:))-1)/fs,v(j,:),'k-');
title('{\it{c}}) IMF_3')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=4;
subplot(5,2,2*j-1)
plot((0:length(v(j,:))-1)/fs,v(j,:),'k-');
title('{\it{d}}) IMF_4')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=5;
subplot(5,2,2*j-1)
plot((0:length(v(j,:))-1)/fs,v(j,:),'k-');
title('{\it{e}}) IMF_5')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)


j=1;
subplot(5,2,2*j)
plot((0:length(v(j+5,:))-1)/fs,v(j+5,:),'k-');
title('{\it{f}}) IMF_6')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)

j=2;
subplot(5,2,2*j)
plot((0:length(v(j+5,:))-1)/fs,v(j+5,:),'k-');
title('{\it{g}}) IMF_7')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
j=3;
subplot(5,2,2*j)
plot((0:length(v(j+5,:))-1)/fs,v(j+5,:),'k-');
title('{\it{h}}) IMF_8')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
j=4;
subplot(5,2,2*j)
plot((0:length(v(j+5,:))-1)/fs,v(j+5,:),'k-');
title('{\it{i}}) IMF_9')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)
j=5;
subplot(5,2,2*j)
plot((0:length(v(j+5,:))-1)/fs,v(j+5,:),'k-');
title('{\it{j}}) IMF_{10}')
xlabel('Time(s)','FontName','Times New Roman','FontSize',20)
ylabel('Amplitude','FontName','Times New Roman','FontSize',20)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',20)