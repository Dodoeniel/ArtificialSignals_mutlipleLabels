function [label] = Label_falling_mu(mu)
%LABEL_FALLING_MU2
%   Detailed explanation goes here

mu = mu(1:floor(length(mu)/3));
[mu_max, idx] = max(mu);


if idx == length(mu)     % if maximum is at half of signal
   label = 0;
elseif idx < floor(length(mu)/3) 
   label = 1;
end

end

