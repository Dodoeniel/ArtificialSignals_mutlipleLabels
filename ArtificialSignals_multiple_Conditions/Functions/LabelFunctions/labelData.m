function label = labelData(p,mu,a,v,T,labels_wanted,fs)
%LABELDATA Summary of this function goes here
%   Detailed explanation goes here

labels_all = zeros(1,4);
labels_all(1) = Label_falling_mu(mu,fs);
labels_all(2) = Label_muTime(mu,fs);
labels_all(3) = Label_mu_absolute(mu);
labels_all(4) = Label_pressure(p);

indexes_all = find(labels_all);
indexes_wanted = find(labels_wanted);
label = 1;
for i = 1:length(indexes_wanted)
   if labels_all(indexes_wanted(i)) ~= 1
       label = 0;
   end
end

end

