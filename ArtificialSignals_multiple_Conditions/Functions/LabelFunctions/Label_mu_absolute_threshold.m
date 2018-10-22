function [label] = Label_mu_absolute_threshold(mu, tr)

label = 0;

mu = mu(1:floor(length(mu)/3));
[max_mu, idx_max] = max(mu);

x = find(mu(idx_max:end) < tr);
if nnz(x) > 0
    label = 1;
end

end

