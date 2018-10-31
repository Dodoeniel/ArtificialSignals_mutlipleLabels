function [label] = Label_falling_mu(mu)
%LABEL_FALLING_MU2: Outputs Label Condition of falling friction coefficient
%   Search for local minimum between Stribeck Maximum and rising viscous
%   friction coefficient. If it exists, condition is considered to be
%   fulfiled.

mu = mu(1:floor(length(mu)/3));
[mu_max, idx] = max(mu);

label = 0;
if idx == length(mu)     % if maximum is at half of signal
   label = 0;
elseif idx < floor(length(mu)/3) 
   label = 1;
end

end

