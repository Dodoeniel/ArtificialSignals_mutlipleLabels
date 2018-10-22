function [label, integral] = Label_muTime(mu,fs)

label = 0;
integral = 0;
for l = 1:length(mu)
    integral = integral+ mu(l)*fs;
end

threshold = 2.3*10^4;

if integral > threshold
    label = 1;

end

