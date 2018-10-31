clc;
clear all;
close all;

%% Create Signal Routine
% author :  Daniel Schoepflin
% date   :  26th September 2018

%% for simplicity all signal lengths shall be equal
fs = 100;               % [Hz]
l = 3;                  % [s]
t = 0:1/fs:l-1/fs;   

%% Define Number of TrainingSamples, Names etc
numTrainSamples = 2; % number Samples for Training
random = rand(numTrainSamples,6);
balancing = [100 50 50 0 0 0];

labels = zeros(numTrainSamples,2);
figure(1)
for i = 1:numTrainSamples
    mu = calcFrictionDataBalanced(t, random(i,1:3), balancing(1:3), fs);
    p = calcPressure(t,fs,random(4), balancing(4));
    %plot(t,mu)
    a = calcDeceleration_balanced(t,p,mu,random(5),balancing(5));
    plot(t,a)
    hold on
end
set(gca,'ytick',[]) 
xlabel('Time', 'Interpreter', 'Latex')