function [label, integral] = Label_muTime_threshold(mu,fs,threshold)
% LABEL_MUTIME_THRESHOLD: outputs label of friction integral condition.
%   If integral of friction coefficient (mu) surpasses the threshold,
%   condition is considered to be positive and 1 is outputed.
label = 0;
integral = 0;

%% calculate integral
for l = 1:length(mu)
    integral = integral+ mu(l)*fs;
end

%% compare value
if integral >= threshold
    label = 1;

end

