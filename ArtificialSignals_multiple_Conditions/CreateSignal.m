clc;
clear all;
close all;

%% Main Function for creation of a multivariate time series
% This script creates a set of multivariate time series to simulate
% operational parameters of a brake system. Alongside the data files, 
% labels based on multiple conditions are calculated.
% author :  Daniel Schoepflin
% date   :  26th September 2018

%% Define Sampling rate and length of signal
fs = 1000;             % Sampling Rate in [Hz]. !> 10Hz
l = 5;                 % Signal length in [s]
t = 0:1/fs:l-1/fs;     % time vector

%% Define Number of Training- Validation and Test Samples and Name
numTrainSamples = 400; % number Samples for Training
numValidationSamples = floor(numTrainSamples/4); % number Validation Samples
numTestSamples = 4; % number Samples for Testing
runName = 'TestRun_2018_10_16'; % Name of Run

%% label settings
% define which conditions for labeling of data should be included
% [dmu/dt < 0, integral mu , mu < mu_abs, p < p_abs, da/dt < 0]
labelDepth = [1 0 0 0 0]; 

% define which percentage of corresponding label condition should result
% in positive label when calculating time series
balancing = [50 50 50 50 50 50]; 

%% define relative path in which signals shoud be stored

path = 'AutomaticCreationOfSignals/CreatedSignals/';
mkdir(['AutomaticCreationOfSignals/CreatedSignals/' runName])

%% calculate Training sets 
% first thresholds for label conditions are calculated based on balancing
tresholds = calculateThresholds(random, balancing, t, fs);

% for each Sample the function Create1MVTimeSeries is called, which outputs
% a Multivariate Time Series

% random numbers for calculation of Training Samples
random = rand(numTrainSamples,6); 
% Names of the Training Samples
fid1 = fopen([path runName '/NamesTraining.csv'],'w'); 
for i = 1:numTrainSamples
    % flag 1 = Training Samples
    flag = 1;
    Create1MVTimeSeries(t,fs,random(i,:),runName,i,flag, balancing, labelDepth, path, fid1);    
end
fclose(fid1);

% random numbers for calculation of Test Samples
random = rand(numTestSamples,6);
% Names of the Test Samples
fid1 = fopen([path runName '/NamesTest.csv'],'w'); 
for i = 1:numTestSamples
    % flag 2 = Test Samples
    flag = 2;
    Create1MVTimeSeries(t,fs,random(i,:),runName,i,flag, balancing, labelDepth, path, fid1);
end
fclose(fid1);

% random numbers for calculation of Validation Samples
random = rand(numValidationSamples,6);
% Names of the Validation Samples
fid1 = fopen([path runName '/NamesValidation.csv'],'w'); 
for i = 1:numValidationSamples
    % flag 3 = Validation Samples
    flag = 3;
    Create1MVTimeSeries(t,fs,random(i,:),runName,i,flag, balancing, labelDepth, path, fid1);
end
fclose(fid1);
