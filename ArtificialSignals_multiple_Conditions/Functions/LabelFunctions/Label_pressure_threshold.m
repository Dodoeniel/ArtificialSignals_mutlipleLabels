function [label] = Label_pressure_threshold(p, p_tr)
%LABEL_PRESSURE calculates Label condition for pressure
%   Based on incoming threshold p_tr a value 1 is outputed, if the
%   condition is fulfiled. Otherwise 0. An rms value has to be lower than
%   the pressure

%% truncate pressure to half ot its size. 
p = p(floor(length(p)/2):end);
label = 0;

% calculate rms value. If it is lower than the threshold label is considered
% to be true
if rms(p) < p_tr
    label = 1;
end

end

