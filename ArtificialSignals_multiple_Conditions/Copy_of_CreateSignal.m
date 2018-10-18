clc;
clear all;
close all;

%% Create Signal Routine
% author :  Daniel Schoepflin
% date   :  26th September 2018

%% for simplicity all signal lengths shall be equal
fs = 100;               % [Hz]
l = 5;                  % [s]
t = 0:1/fs:l-1/fs;   

%% Define Nnumber of TrainingSamples, Names etc
numTrainSamples = 100; % number Samples for Training
random = rand(numTrainSamples,4);
balancing = [50 100 100 50];

figure(1)
a= zeros(numTrainSamples,1);
b= zeros(numTrainSamples,1);
c= zeros(numTrainSamples,1);
d= zeros(numTrainSamples,1);
integral = 0;
for i = 1:numTrainSamples
   mu = calcFrictionDataBalanced(t,random(i,1:3), balancing(1:3), fs);
   a(i) = Label_falling_mu(mu,fs);
   c(i) = Label_mu_absolute(mu,fs);
   plot(t,mu)
   hold on
end
nnz(a)
nnz(b)
nnz(c)
figure(2)
for i = 1:numTrainSamples
    p = calcPressure(t,fs,random(i,4), balancing(4));
    d(i) = Label_pressure(p);
    plot(t,p)
    hold on
end
nnz(d)