function [label] = Label_mu_absolute_threshold(mu, tr)

label = 0;

mu = mu(1:floor(length(mu)/3));
[max_mu, idx_max] = max(mu);
for i = idx_max+1:length(mu)
   if mu(i) < tr
       label = 1;
   end
end

end

