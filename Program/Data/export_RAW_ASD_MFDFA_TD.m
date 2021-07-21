clear all  
close all  
clc 

load rawdata.mat

% MFDFA parameter
param = ['Hq';'tq';'hh';'Dq'];
scmin=16;
scmax=1024;
scres=19;
exponents=linspace(log2(scmin),log2(scmax),scres);
scale=round(2.^exponents);
q=linspace(-5,5,101);
m=1;

datasize = size(ipdata,1);

for sheet = 1:datasize
x = ipdata(sheet,:);
%MFDFA
[Hq1a,tq1a,h1a,Dq1a,Fq1a]=MFDFA1(x,scale,q,m,0);
THq1a(sheet,:) = Hq1a;
Ttq1a(sheet,:) = tq1a;
Th1a(sheet,:) = h1a;
TDq1a(sheet,:) = Dq1a;
%ASD
p1 = stblfit(x,'ecf',statset('Display','iter'));
Y1 = linspace(min(x),max(x),length(x));
h1 = stblpdf(Y1,p1(1,1),p1(2,1),p1(3,1),p1(4,1),'quick');
p1(5,1) = max(h1);
rlt1(sheet,:) = p1(:,1)';
%TD
x1 = 0;
sample =size(x,2);

%Mean;
feature(sheet,1) = mean(x);
%STD;
feature(sheet,2) = std(x);
%RMS;
feature(sheet,3) = rms(x);
%PEAK;
feature(sheet,4)=max(abs(x));
%Skewness;
feature(sheet,5) = skewness(x);
%Kurtosis;
feature(sheet,6) = kurtosis(x);
%Crest factor;
feature(sheet,7) = max(abs(x))/rms(x);
%Clearance factor;
feature(sheet,8)= max(abs(x))/((sum( sqrt(abs(x)))/sample) ^2);
%Shape factor;
feature(sheet,9) = rms(x)/mean(abs(x));
%Impulse factor;
feature(sheet,10) = max(abs(x))/mean(abs(x));
end


xlswrite('raw_ASD.xlsx',rlt1);
xlswrite('raw_MFDFA.xlsx',THq1a,param(1,1:2));
xlswrite('raw_MFDFA.xlsx',Ttq1a,param(2,1:2));
xlswrite('raw_MFDFA.xlsx',Th1a,param(3,1:2));
xlswrite('raw_MFDFA.xlsx',TDq1a,param(4,1:2));
xlswrite('raw_TD.xlsx',feature);

load chirp
sound(y,Fs)
