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
balancing = [100 100 10 90];

ps = zeros(numTrainSamples,length(t));
for l = 1:numTrainSamples
   ps(l,:) = calcPressure(t,fs,random(l,4),balancing(4)); 
end

tr = calculate_p_absolute(ps, balancing(4));

labels = zeros(numTrainSamples,1);
for l = 1:numTrainSamples 
   labels(l) = Label_pressure_threshold(ps(l,:), tr);
end
nnz(labels)

