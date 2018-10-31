function [label] = Label_mu_absolute_threshold(mu, tr)
%LABEL_MU_ABSOLUTE_THRESHOLD: gives label condition for absolute value of
%friction coefficient
% Based on the Threshold a local minimum between Stribeck Curve and rising
% values from viscous coefficient is searched. If this is lower than the
% threshold, condition is considered to be positive.


label = 0;

%% slice friction vector
mu = mu(1:floor(length(mu)/3));
% find maximum value
[max_mu, idx_max] = max(mu);

% find local minimum between maximum and end of vector. If there exists a
% minimum, label = 1.
x = find(mu(idx_max:end) < tr);
if nnz(x) > 0
    label = 1;
end

end

