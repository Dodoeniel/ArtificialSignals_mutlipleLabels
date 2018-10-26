function [tr] = calculateIntegralThreshold(mu, balancing, fs)
%CALCULATEINTEGRALTHRESHHOLD Summary of this function goes here
%   Detailed explanation goes here


tr = 3.5 * 10^6;
x = -1;
step = 5*10^4;
%while ~(x < balancing/100*1.1) && ~(x > balancing/100*0.9)
count = 0;
history = 0;
while 1
    
    count = count +1; 
    if x < balancing 
        tr = tr - step;
    else 
        tr = tr + step;
    end
    labels = zeros(length(mu(:,1)));
    for l = 1:length(mu(:,1))
       labels(l) =  Label_muTime_threshold(mu(l,:),fs,tr);
    end
    x = nnz(labels)/length(labels)*100;
    
    if abs(x-history) == history && abs(x-history) ~= 0 && step > 10^2
        step = step/100;
    end
    if x < balancing*1.1 && x > balancing * 0.8
        break
    elseif count > 500 && x < balancing*1.2 && x > balancing * 0.7
        break
    end
end

end

