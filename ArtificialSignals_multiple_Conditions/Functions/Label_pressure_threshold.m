function [label] = Label_pressure_threshold(p, p_tr)
%LABEL_PRESSURE Summary of this function goes here
%   Detailed explanation goes here

p = p(floor(length(p)/2):end);

label = 0;

if rms(p) < p_tr
    label = 1;
end

end

