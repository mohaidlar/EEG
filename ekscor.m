load('databasealpha8.mat');
x=database(1,:);
load('dataujialpha8.mat');
y=database(1,:);
r = xcorr(x,y);