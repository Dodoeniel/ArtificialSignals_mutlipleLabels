function [v,a,mu,p] = Create1MVTimeSeries(t,fs,random, name, count, flag, balancing, labelDepth, path, fid1, tresholds)
%CREATE1MVTIMESERIES Outputs a multi-variate Time Series. Inputs are
% a time vector, frequency, Random: a five-dimensional vector of random values
% between 0 and 1. Count: count of which Sample it is. Flag: 1 -->
% Training, 2 --> Testing, 3 --> Validation. Balancing: 5 dimensional
% vector, with values between 0 and 100, indicating balancing of label
% conditions. Label Depth: Which label conditions have to be true to get
% label 1. Path: Path on which to save data. fid1: Id of file on which to
% store Name of Sample. Thresholds: Three dimensional vector corresponding
% to the label condition thresholds (integral mu, mu_abs, p_abs).
% author: Daniel Schoepflin
% date : 26th September 2018

%% calculation of individual time series
% random value assignments: dmu/dv<0, integral mu, mu_tr, p_tr, a
mu = calcFrictionDataBalanced(t,random(1:3),balancing(1:3), fs);  % calculated with time not speed!
p = calcPressure(t,fs,random(4),balancing(4));             
a = calcDeceleration_balanced(t,p,mu,random(5), balancing(5));
v = calcLinearSpeed(t,a,fs)';

%% calculation of labels
% label is a scalar, either 0 or 1
label = labelData(p,mu,a,v,labelDepth,fs,tresholds);

%% writing of values to csv file
% the data will have the name RunName_Training_count.csv
% labels are written in the same file, called LabelsTraining.csv etc
if flag == 1    %% flag 1 TrainingData
    csvwrite([path name '/' name '_Training' '_' int2str(count) '.csv'],[v' a' mu' p']);
    str = [name '_Training_' int2str(count) '.csv' '\n'];
    fprintf(fid1, str);
    dlmwrite(['AutomaticCreationOfSignals/CreatedSignals/' name '/LabelsTraining.csv'],label,'-append');
elseif flag == 2 %% flag 2 TestingData
    csvwrite([path name '/' name '_Test' '_' int2str(count) '.csv'],[v' a' mu' p']);
    str = [name '_Test_' int2str(count) '.csv' '\n'];
    fprintf(fid1, str);
    dlmwrite(['AutomaticCreationOfSignals/CreatedSignals/' name '/LabelsTest.csv'],label,'-append');
elseif flag == 3 %% flag 3 Validation Data   
    csvwrite([path name '/' name '_Validation' '_' int2str(count) '.csv'],[v' a' mu' p']);
    str = [name '_Validation_' int2str(count) '.csv' '\n'];
    fprintf(fid1, str);
    dlmwrite(['AutomaticCreationOfSignals/CreatedSignals/' name '/LabelsValidation.csv'],label,'-append');
end


end

