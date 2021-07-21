clear all  
close all  
clc 

load Rawdata.mat

data1 = ipdata(169,:); 
data2 = ipdata(261,:); 
data3 = ipdata(930,:); 
data4 = ipdata(1190,:); 
data5 = ipdata(1582,:); 
data6 = ipdata(1549,:); 

fs = 48000;
Nstd = 0.2;
NE = 100;
alpha = 1500;        % moderate bandwidth constraint, according to the optimization value.
K = 10;              % number of mode, according to the optimization value.
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
DC = 0;             % no DC part imposed
init = 1;           % initialize omegas uniformly
tol = 1e-10;


n=1;
subplot(3,2,(2*n-1))
plot((0:length(eval(['data',int2str(2*n-1)]))-1)/fs,eval(['data',int2str(2*n-1)]),'k-');
title('{\it s}_1')
xlabel('Time(s)','FontName','Times New Roman','FontSize',24)
ylabel('Amplitude','FontName','Times New Roman','FontSize',24)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',24)
hold on;
subplot(3,2,(2*n))
plot((0:length(eval(['data',int2str(2*n)]))-1)/fs,eval(['data',int2str(2*n)]),'k-');
%title(sprintf('s_%d', n+3))
a=n+3;
title('{\it s}_4')
xlabel('Time(s)','FontName','Times New Roman','FontSize',24)
ylabel('Amplitude','FontName','Times New Roman','FontSize',24)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',24)
hold on;

n=2;
subplot(3,2,(2*n-1))
plot((0:length(eval(['data',int2str(2*n-1)]))-1)/fs,eval(['data',int2str(2*n-1)]),'k-');
title('{\it s}_2')
xlabel('Time(s)','FontName','Times New Roman','FontSize',24)
ylabel('Amplitude','FontName','Times New Roman','FontSize',24)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',24)
hold on;
subplot(3,2,(2*n))
plot((0:length(eval(['data',int2str(2*n)]))-1)/fs,eval(['data',int2str(2*n)]),'k-');
%title(sprintf('s_%d', n+3))
a=n+3;
title('{\it s}_5')
xlabel('Time(s)','FontName','Times New Roman','FontSize',24)
ylabel('Amplitude','FontName','Times New Roman','FontSize',24)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',24)
hold on;

n=3;
subplot(3,2,(2*n-1))
plot((0:length(eval(['data',int2str(2*n-1)]))-1)/fs,eval(['data',int2str(2*n-1)]),'k-');
title('{\it s}_3')
xlabel('Time(s)','FontName','Times New Roman','FontSize',24)
ylabel('Amplitude','FontName','Times New Roman','FontSize',24)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',24)
hold on;
subplot(3,2,(2*n))
plot((0:length(eval(['data',int2str(2*n)]))-1)/fs,eval(['data',int2str(2*n)]),'k-');
%title(sprintf('s_%d', n+3))
a=n+3;
title('{\it s}_6')
xlabel('Time(s)','FontName','Times New Roman','FontSize',24)
ylabel('Amplitude','FontName','Times New Roman','FontSize',24)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',24)
hold on;

suptitle('Non-Knock Signal{                             }Knock Signal')
hold off;

