function [label] = Label_falling_a(a,fs)
%LABEL_FALLING_MU2
%   Detailed explanation goes here

%% starting indices
i_start = floor(length(a)/5);
a = a(i_start:end);
p_sinus = 10/(2*pi);
step = floor(p_sinus*fs/2);
max_step = floor(length(a)/step);
label = 0;
rms_old = rms(a(1:step));
for i = 2:max_step-1
    rms_i = rms(a(i*step:(i+1)*step));
    if rms_i < rms_old
       label = 1; 
    end
    rms_old = rms_i;
end

end

