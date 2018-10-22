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

%% Define Number of TrainingSamples, Names etc
numTrainSamples = 1000; % number Samples for Training
random = rand(numTrainSamples,4);
balancing = [100 80 0];

mus = zeros(numTrainSamples,length(t));
for l = 1:numTrainSamples
   mus(l,:) = calcFrictionDataBalanced(t,random(l,1:3),balancing,fs);
end

tr = calculateIntegralThreshold(mus, balancing(2), fs);

labels = zeros(numTrainSamples,1);
for l = 1:numTrainSamples 
   labels(l) = Label_muTime_threshold(mus(l,:),fs, tr);
end
nnz(labels)

