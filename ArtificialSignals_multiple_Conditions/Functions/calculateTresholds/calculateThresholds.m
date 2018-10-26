function [int_tr, mu_tr, p_tr] = calculateThresholds(random, balancing,t, fs)
%CALCULATETHRESHOLDS Summary of this function goes here
%   Detailed explanation goes here

numSamples = length(random(:,1));
mus = zeros(numSamples, length(t));
ps = zeros(numSamples, length(t));

for i = 1:numSamples
    mus(i,:) = calcFrictionDataBalanced(t, random(i,1:3), balancing, fs);
    ps(i,:) = calcPressure(t,fs,random(i,4),balancing(4));    
end

int_tr = calculateIntegralThreshold(mus, balancing(2), fs);
mu_tr = calculate_mu_absolute(mus, balancing(3));
p_tr = calculate_p_absolute(ps, balancing(4));

end

