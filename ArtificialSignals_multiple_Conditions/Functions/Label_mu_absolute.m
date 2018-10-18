function [label] = Label_mu_absolute(mu)

label = 0;
mu_tr = 0.384;

mu = mu(1:floor(length(mu)/3));
[max_mu, idx_max] = max(mu);
for i = idx_max+1:length(mu)
   if mu(i) < mu_tr
       label = 1;
   end
end

end

