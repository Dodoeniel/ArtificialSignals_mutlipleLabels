clc
clear all
close all

%% signal properties
fs = 100;               % [Hz]
l = 5;                  % [s]
t = 0:1/fs:l-1/fs;   

%% balancing vector
balancing = [50 50 50 50];

%% create Signals
numSamples = 1000;
random_array = rand(numSamples,6);

mus = zeros(numSamples, length(t));
ps = zeros(numSamples, length(t));

for l = 1:numSamples
   mus(l,:) = calcFrictionDataBalanced(t, random_array(l,1:3), balancing(1:3),fs);
   ps(l,:) = calcPressure(t,fs, random_array(l,4), balancing(4));
end
%% calculate Label thresholds 


mu_int = calculateIntegralThreshold(mus, balancing(2), fs);
mu_tr = calculate_mu_absolute(mus, balancing(3));
p_tr = calculate_p_absolute(ps, balancing(4));

%% calculate Labels
labels_all = zeros(numSamples,4);

for l = 1:numSamples
    labels_all(l,1) = Label_falling_mu(mus(l,:),fs);
    labels_all(l,2) = Label_muTime_threshold(mus(l,:),fs, mu_int);
    labels_all(l,3) = Label_mu_absolute_threshold(mus(l,:),mu_tr);
    labels_all(l,4) = Label_pressure_threshold(ps(l,:), p_tr);
end

muTime = nnz(labels_all(:,2));
mu_absolute = nnz(labels_all(:,3));
pressure = nnz(labels_all(:,4));

positive_labels = zeros(1,3);
negative_labels = zeros(1,3);

for l = 1:numSamples
    if labels_all(l,1) == 0
        negative_labels = negative_labels + labels_all(l,2:4);
    else
        positive_labels = positive_labels + labels_all(l,2:4);
    end
end

labels1 = nnz(labels_all(:,1));
labels0 = numSamples-labels1;

%positive_labels = positive_labels./labels1*100;
%negative_labels = negative_labels./labels0*100;
figure(1)
bar(positive_labels)
ylabel('Percent of ')
