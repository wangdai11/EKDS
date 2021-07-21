clear all  
close all  
clc 

color1 = [':b';':r';':k';':m';':g';':c'];
color2 = ['b';'r';'k';'m';'g';'c'];

param = ['Hq';'tq';'hh';'Dq'];
q=linspace(-5,5,101);
p=0;




load 'eemd_combine';
data1 = feature(find(feature(:,1)==1),[7:11]);
data2 = feature(find(feature(:,1)==2),[7:11]);
clear feature

subplot(2,2,1)
for n = 1:2
eval(['scatter3(data',int2str(n),'(:,1),data',int2str(n),'(:,3),data',int2str(n),'(:,5));']);
hold on;
end

xlabel('h_q_a','fontsize',15);
ylabel('D_q_a','fontsize',15);
zlabel('h_q_0','fontsize',15);
%legend({'10¢XBTDC','25¢XBTDC','35¢XBTDC','40¢XBTDC','45¢XBTDC'},'FontSize',15)
title('EEMD + sample entropy','fontsize',20)

subplot(2,2,3)
for n = 1:2
eval(['scatter3(data',int2str(n),'(:,2),data',int2str(n),'(:,4),data',int2str(n),'(:,5));']);
hold on;
end
xlabel('h_q_b','fontsize',15);
ylabel('D_q_b','fontsize',15);
zlabel('h_q_0','fontsize',15);
%legend({'10¢XBTDC','25¢XBTDC','35¢XBTDC','40¢XBTDC','45¢XBTDC'},'FontSize',15)


load 'vmd_combine';
data1 = feature(find(feature(:,1)==1),[7:11]);
data2 = feature(find(feature(:,1)==2),[7:11]);
clear feature

subplot(2,2,2)
for n = 1:2
eval(['scatter3(data',int2str(n),'(:,1),data',int2str(n),'(:,3),data',int2str(n),'(:,5));']);
hold on;
end

xlabel('h_q_a','fontsize',15);
ylabel('D_q_a','fontsize',15);
zlabel('h_q_0','fontsize',15);
%legend({'10¢XBTDC','25¢XBTDC','35¢XBTDC','40¢XBTDC','45¢XBTDC'},'FontSize',15)
title('OVMD + sample entropy','fontsize',20)

subplot(2,2,4)
for n = 1:2
eval(['scatter3(data',int2str(n),'(:,2),data',int2str(n),'(:,4),data',int2str(n),'(:,5));']);
hold on;
end
xlabel('h_q_b','fontsize',15);
ylabel('D_q_b','fontsize',15);
zlabel('h_q_0','fontsize',15);
legend({'Non-knock','Knock'},'FontSize',15)



