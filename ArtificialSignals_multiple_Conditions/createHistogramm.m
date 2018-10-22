clc
clear all
close all

%% signal properties
fs = 100;               % [Hz]
l = 5;                  % [s]
t = 0:1/fs:l-1/fs;   

%% 

%% Define Nnumber of TrainingSamples, Names etc
numSamples = 1000; % number Samples
balancing = [50 50 50 50 50 50]; % distribution of condition balancing
random_array = rand(numSamples,6);

labels_all = zeros(numSamples,4);
figure(1)
for i = 1:numSamples
    r = random_array(i,:);
    mu = calcFrictionDataBalanced(t,r(1:3),balancing(1:3),fs);  % calculated with time not speed!
    p = calcPressure(t,fs,r(4),balancing(4));             
    a = calcDeccelleration(t,p,mu,r(6), balancing(6));
    v = calcLinearSpeed(t,a,fs,r(5), balancing(5))';
    T = calcTemperature(t,v,fs)';
    
    labels_all(i,1) = Label_falling_mu(mu,fs);
    labels_all(i,2) = Label_muTime(mu,fs);
    labels_all(i,3) = Label_mu_absolute(mu);
    labels_all(i,4) = Label_pressure(p);
    
    plot(t,mu)
    hold on
    
    
end
muTime = nnz(labels_all(:,2))
mu_absolute = nnz(labels_all(:,3))
pressure = nnz(labels_all(:,4))

dist1 = zeros(1,3);
dist0 = zeros(1,3);
for l = 1:numSamples
    
    if labels_all(l,1) == 0
        dist0 = dist0 + labels_all(l,2:4);
    else
        dist1 = dist1 + labels_all(l,2:4);
    end
    
end
labels0 = nnz(labels_all(:,1));
labels1 = numSamples-labels0;
dist1 = dist1./labels1*100;
dist0 = dist0./labels0*100;
figure(2)
bar(dist1)
ylabel('Percent of ')
