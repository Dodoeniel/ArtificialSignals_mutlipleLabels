function [p] = calcPressure(t,fs,random, balancing)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

steepness = 5;
range_max = 5;
max = 40-range_max*balancing/100-random*range_max;
sinusFreq = 10;
p = max-max*exp(-(steepness+random).*t);
t_switch = ceil(fs/steepness);
p(t_switch:end) = p(t_switch:end)-sin(sinusFreq*t(t_switch:end));
end

