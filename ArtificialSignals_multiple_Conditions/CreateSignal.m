clc;
clear all;
close all;

%% Create Signal Routine
% author :  Daniel Schoepflin
% date   :  26th September 2018

%% for simplicity all signal lengths shall beo equal
fs = 1000;             % [Hz]
l = 5;                  % [s]
t = 0:1/fs:l-1/fs;   

%% Define Nnumber of TrainingSamples, Names etc
numTrainSamples = 400; % number Samples for Training
numValidationSamples = floor(numTrainSamples/4); % number Validation Samples
numTestSamples = 4; % number Samples for Testing
balancing = [50 50 50 50 50]; % distribution of condition balancing
labelDepth = [1 0 0 0 0]; % which  lables should be inclouded

TestRunName = 'TestRun_2018_10_16';


path = 'AutomaticCreationOfSignals/CreatedSignals/';
mkdir(['AutomaticCreationOfSignals/CreatedSignals/' TestRunName])
%% 
random = rand(numTrainSamples,6);
tresholds = calculateThresholds(random, balancing, t, fs);
fid1 = fopen([path TestRunName '/NamesTraining.csv'],'w'); 
for i = 1:numTrainSamples
    % flag 1 = Training Samples
    Create1MVTimeSeries(t,fs,random(i,:),TestRunName,i,1, balancing, labelDepth, path, fid1, tresholds);
    
end
fclose(fid1);


random = rand(numTestSamples,6);
fid1 = fopen([path TestRunName '/NamesTest.csv'],'w'); 
for i = 1:numTestSamples
    % flag 2 = Test Samples
    Create1MVTimeSeries(t,fs,random(i,:),TestRunName,i,2, balancing, labelDepth, path, fid1, tresholds);
    
end
fclose(fid1);


random = rand(numValidationSamples,6);
fid1 = fopen([path TestRunName '/NamesValidation.csv'],'w'); 
for i = 1:numValidationSamples
    % flag 3 = Validation Samples
    Create1MVTimeSeries(t,fs,random(i,:),TestRunName,i,3, balancing, labelDepth, path, fid1, tresholds);
    
end
fclose(fid1);
