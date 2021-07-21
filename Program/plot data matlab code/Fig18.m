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

Mr = ['-';'-';'-';'-';'-';'-';'-';'-'];
Mmode = 'quick';
text ='MarkerSize';

subplot(1,2,1)
for n = 1:6
X = eval(['edata',int2str(n)]);
p = stblfit(X,'ecf')';
eval(['[Y',int2str(n),'] = linspace(min(X),max(X),length(X)); ']);  
hold on;
eval(['plot(Y',int2str(n),',stblpdf(Y',int2str(n) ,',p(1,1),p(1,2),p(1,3),p(1,4),Mmode),Mr(',int2str(n),'),text,10); ']); 
end
ylabel('PDF','fontsize',15)
xlabel('Amplitude of signal','fontsize',15)
title('EEMD','fontsize',20);



subplot(1,2,2)
for n = 1:6
X = eval(['vdata',int2str(n)]);
p = stblfit(X,'ecf')';
eval(['[Y',int2str(n),'] = linspace(min(X),max(X),length(X)); ']);  
hold on;
eval(['plot(Y',int2str(n),',stblpdf(Y',int2str(n) ,',p(1,1),p(1,2),p(1,3),p(1,4),Mmode),Mr(',int2str(n),'),text,10); ']); 
end
ylabel('PDF','fontsize',15)
xlabel('Amplitude of signal','fontsize',15)
title('VMD','fontsize',20);
