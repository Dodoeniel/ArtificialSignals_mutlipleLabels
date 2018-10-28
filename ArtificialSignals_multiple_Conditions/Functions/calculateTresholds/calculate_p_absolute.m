function [p_tr] = calculate_p_absolute(ps,balancing)
%CALCULATE_MU_ABSOLUTE Summary of this function goes here
%   Detailed explanation goes here

p_tr = 35;
x = -1;
step = 0.1;

ps = ps(:,floor(length(ps(1,:))/2):end);

while 1
    labels = zeros(length(ps(:,1)),1);
    for i = 1:length(ps(:,1))
        labels(i) = Label_pressure_threshold(ps(i,:),p_tr);
    end
    x = nnz(labels)/length(labels)*100;
    
    if x < balancing*1.05 && x > balancing * 0.98
        break
    elseif x < balancing
        p_tr = p_tr +step;
    elseif x > balancing
        p_tr = p_tr - step;
    end
    
end
end

