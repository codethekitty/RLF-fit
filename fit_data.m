clear;clc

% get data
data=readtable('RLFs_processedData_27b.csv');
x=data(strcmp(data.condition,'ly6'),:).dB;
y=data(strcmp(data.condition,'ly6'),:).FiringRate;
% x=data(strcmp(data.condition,'ly8'),:).dB;
% y=data(strcmp(data.condition,'ly8'),:).FiringRate;

% find max
ym=max(y);
im=floor(median(find(y==ym)));
xm=x(im); %rate maximum

% separate into two functions
f1=[x(1:im),y(1:im)];
f2=[x(im:end),y(im:end)];

% fit f2 (lower monotonic section) with L5P

i=f2(:,1);
j=f2(:,2);
plot(i,j,'o')
hold on
[cf,G]=L5P(i,j,[0,0.1,10,ym*1.5,0.1],[0,0.1,10,ym,0.1],[50,5,90,ym*2,3]);
plot(i,cf(i))

% fit f1 (upper inhibitory section), but fix the starting point
max_fit=max(cf(i));

i=f1(:,1);
j=f1(:,2);
plot(i,j,'o')
hold on
[cf,G]=L5P(i,j,[0,-0.1,10,max_fit,0.1],[0,-20,10,max_fit,0.1],[100,-0.1,90,max_fit,1000]);
plot(i,cf(i))





