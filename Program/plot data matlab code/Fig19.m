
clear all  
close all  
clc 

color1 = [':r';':k';':b';':m';':g';':c'];
color2 = ['r';'k';'b';'m';'g';'c'];

load 'eemd_combine';
data1 = feature(find(feature(:,1)==1),[2:6]);
data2 = feature(find(feature(:,1)==2),[2:6]);
clear feature

subplot(2,2,1)
for n = 1:2
eval(['scatter3(data',int2str(n),'(:,1),data',int2str(n),'(:,3),data',int2str(n),'(:,5));']);
hold on;
end
%£\ £] £^ £_ h
xlabel('£\','fontsize',15);
ylabel('£^','fontsize',15);
zlabel('h','fontsize',15);
%legend({'10¢XBTDC','25¢XBTDC','35¢XBTDC','40¢XBTDC','45¢XBTDC'},'FontSize',15)
title('EEMD + sample entropy','fontsize',20)

subplot(2,2,3)
for n = 1:2
eval(['scatter3(data',int2str(n),'(:,2),data',int2str(n),'(:,4),data',int2str(n),'(:,5));']);
hold on;
end
%£\ £] £^ £_ h
xlabel('£]','fontsize',15);
ylabel('£_','fontsize',15);
zlabel('h','fontsize',15);
%legend({'10¢XBTDC','25¢XBTDC','35¢XBTDC','40¢XBTDC','45¢XBTDC'},'FontSize',15)
title('EEMD + sample entropy','fontsize',20)


load 'vmd_combine';
data1 = feature(find(feature(:,1)==1),[2:6]);
data2 = feature(find(feature(:,1)==2),[2:6]);
clear feature

subplot(2,2,2)
for n = 1:2
eval(['scatter3(data',int2str(n),'(:,1),data',int2str(n),'(:,3),data',int2str(n),'(:,5));']);
hold on;
end
%£\ £] £^ £_ h
xlabel('£\','fontsize',15);
ylabel('£^','fontsize',15);
zlabel('h','fontsize',15);
%legend({'non-knock','knock'},'FontSize',15)
title('OVMD + sample entropy','fontsize',20)

subplot(2,2,4)
for n = 1:2
eval(['scatter3(data',int2str(n),'(:,2),data',int2str(n),'(:,4),data',int2str(n),'(:,5));']);
hold on;
end
%£\ £] £^ £_ h
xlabel('£]','fontsize',15);
ylabel('£_','fontsize',15);
zlabel('h','fontsize',15);
legend({'Non-knock','Knock'},'FontSize',15)
title('OVMD + sample entropy','fontsize',20)