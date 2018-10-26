function [label, integral] = Label_muTime_threshold(mu,fs,threshold)

label = 0;
integral = 0;
for l = 1:length(mu)
    integral = integral+ mu(l)*fs;
end


if integral >= threshold
    label = 1;

end

