function label = labelData(p,mu,a,v,labels_wanted,fs,threshold)
% caluclates the label of incoming time Series, based on aplied conditions.
% p, mu, a, v: TimeSeries. labels_wanted: 5 dimensional vector of
% conditions needed to be fulfiled to get label 1. Range of each value
% between 0 and 1. fs: sampling frequency. Threshold: Vector of thresholds
% needed to be reached by [integral mu, mu_abs and p_abs].
%

%% calculate whether conditions for labels are fulfilled
labels_all = zeros(1,5);
labels_all(1) = Label_falling_mu(mu);
labels_all(2) = Label_muTime_threshold(mu,fs,threshold(1));
labels_all(3) = Label_mu_absolute_threshold(mu,threshold(2));
labels_all(4) = Label_pressure_threshold(p,threshold(3));
labels_all(5) = Label_falling_a(a, fs);
%labels_all(6) = Label_LinearSpeed_threshold(v, v_tr);

%% match indexes of wanted conditions to fulfiled ones
indexes_wanted = find(labels_wanted);
label = 1;
for i = 1:length(indexes_wanted)
   if labels_all(indexes_wanted(i)) ~= 1
       label = 0;
   end
end

end

