clear all  
close all  
clc 

load eemddata.mat
eemddata=ipdata;
edata1 = eemddata(27,:); 
edata2 = eemddata(672,:); 
edata3 = eemddata(1400,:); 
edata4 = eemddata(230,:); 
edata5 = eemddata(1218,:); 
edata6 = eemddata(1707,:); 
clear eemddata
load vmddata.mat
vmddata=ipdata;
vdata1 = vmddata(27,:); 
vdata2 = vmddata(672,:); 
vdata3 = vmddata(1400,:); 
vdata4 = vmddata(230,:); 
vdata5 = vmddata(1218,:); 
vdata6 = vmddata(1707,:);
clear vmddata

% MFDFA parameter
scmin=16;
scmax=1024;
scres=19;
exponents=linspace(log2(scmin),log2(scmax),scres);
scale=round(2.^exponents);
q=linspace(-5,5,101);
m=1;

for n = 1:6
eval(['[eHq',int2str(n),',etq',int2str(n),',ehh',int2str(n),',eDq',int2str(n),',eFq',int2str(n),'] = MFDFA(e',int2str(n),',scale,q,m,0);']);
eval(['[vHq',int2str(n),',vtq',int2str(n),',vhh',int2str(n),',vDq',int2str(n),',vFq',int2str(n),'] = MFDFA1(v',int2str(n),',scale,q,m,0);']);
end

subplot(1,2,1)
for n = 1:datanum
hold on;
eval(['plot(ehh',int2str(n),',eDq',int2str(n),');']);   
end
xlabel('h_q','fontsize',15);
ylabel('D_q','fontsize',15);
title('EEMD','fontsize',20);

subplot(1,2,2)
for n = 1:datanum
hold on;
eval(['plot(vhh',int2str(n),',vDq',int2str(n),');']);   
end
xlabel('h_q','fontsize',15);
ylabel('D_q','fontsize',15);
title('OVMD','fontsize',20);