clear all  
close all  
clc 

load 'vmd_nonknock';
nkdata = feature(:,34:45);
clear feature
load 'vmd_knock';
kdata = feature(:,34:45);
clear feature

col = 3;
datanum = 5;
DK1 = 'peak to peak';
DK2 = 'variance';
DK3 = 'standard deviation';
DK4 = 'root-mean-square';
DK5 = 'square-mean-root';
DK6 = 'mean amplitude';
DK7 = 'skewness';
DK8 = 'kurtosis';
DK9 = 'shape factor';
DK10 = 'crest factor';
DK11 = 'impulse factor';
DK12 = 'clearance factor';

%for f = 1:12
%subplot('position',[((f-(ceil(f/col)-1)*col)*0.3-0.25) (0.8-(ceil(f/col)-1)*0.25) 0.25 0.15])
%group = [repmat({'Non-knock'}, size(nkdata,1), 1); repmat({'Knock'}, size(kdata,1), 1)];
%boxplot([nkdata(:,f);kdata(:,f)], group);
%set(gca,'xticklabel',{'Non-knock','Knock'},'fontsize',12);
%title(eval(['DK',int2str(f)]),'fontsize',15)
%end

for f = 1:12
subplot('position',[((f-(ceil(f/col)-1)*col)*0.3-0.25) (0.8-(ceil(f/col)-1)*0.25) 0.25 0.15])
%group = [repmat({'Non-knock'}, size(nkdata,1), 1); repmat({'Knock'}, size(kdata,1), 1)];
%boxplot([nkdata(:,f);kdata(:,f)], group);
%set(gca,'xticklabel',{'Non-knock','Knock'},'fontsize',12);
hold
x(1:size(nkdata,1),:)=1;
scatter(x,nkdata(:,f),'Marker','.');
y(1:size(kdata,1),:)=2;
scatter(y,kdata(:,f),'Marker','.');
xlim([0 3])
set(gca,'xtick',[1:2]);
set(gca,'xticklabel',{'Non-Knock';'Knock'},'fontsize',15);
title(eval(['DK',int2str(f)]),'fontsize',18)
end
