function [label] = Label_pressure(p)
%LABEL_PRESSURE Summary of this function goes here
%   Detailed explanation goes here

p = p(floor(length(p)/2):end);
p_tr = 35;

label = 0;

if rms(p) < p_tr
    label = 1;
end

end

