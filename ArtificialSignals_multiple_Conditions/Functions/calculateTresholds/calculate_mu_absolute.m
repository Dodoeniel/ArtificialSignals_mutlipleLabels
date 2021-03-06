function [mu_tr] = calculate_mu_absolute(mus,balancing)
%CALCULATE_MU_ABSOLUTE Summary of this function goes here
%   Detailed explanation goes here

mu_tr = 0.565;
x = -1;
step = 0.002;

mus = mus(:,1:floor(length(mus(1,:))/3));

while 1
    labels = zeros(length(mus(:,1)),1);
    for i = 1:length(mus(:,1))
        labels(i) = Label_mu_absolute_threshold(mus(i,:),mu_tr);
    end
    x = nnz(labels)/length(labels)*100;
    
    if x < balancing*1.02 && x > balancing * 0.98
        break
    elseif x < balancing
        mu_tr = mu_tr +step;
    elseif x > balancing
        mu_tr = mu_tr - step;
    end
    
end
end

