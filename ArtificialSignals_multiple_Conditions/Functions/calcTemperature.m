function [T] = calcTemperature(t,v,fs)
%CALCTEMPERATURE Summary of this function goes here
%   Detailed explanation goes here


W = zeros(length(t),1);
W(1) = 0;
for i = 2:length(t)
   W(i) = W(i-1)+1/fs*((v(i-1))-(v(i)));
end

T = 160/W(end)*W;
end

