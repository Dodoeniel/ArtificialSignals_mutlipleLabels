function label = labelData(p,mu,a,v,labels_wanted,fs,threshold)
%LABELDATA Summary of this function goes here
%   Detailed explanation goes here

labels_all = zeros(1,5);
labels_all(1) = Label_falling_mu(mu);
labels_all(2) = Label_muTime_threshold(mu,fs,threshold(1));
labels_all(3) = Label_mu_absolute_threshold(mu,threshold(2));
labels_all(4) = Label_pressure_threshold(p,threshold(3));
labels_all(5) = Label_falling_a(a, fs);
%labels_all(6) = Label_LinearSpeed_threshold(v, v_tr);

indexes_wanted = find(labels_wanted);
label = 1;
for i = 1:length(indexes_wanted)
   if labels_all(indexes_wanted(i)) ~= 1
       label = 0;
   end
end

end

