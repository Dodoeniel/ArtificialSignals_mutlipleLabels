function [v,a,mu,p,T] = Create1MVTimeSeries(t,fs,random, name, count, flag, balancing, labelDepth, path, fid1)
%CREATE1MVTIMESERIES Outputs a multi-variate Time Series
%   author: Daniel Schoepflin
%   date : 26th September 2018

%% calculation of individual time series
% random value assignments: dmu/dv<0, integral mu, mu_tr, p_tr, v_tr, a
mu = calcFrictionDataBalanced(t,random(1:3),balancing(1:3),fs);  % calculated with time not speed!
p = calcPressure(t,fs,random(4),balancing(4));             
a = calcDeccelleration(t,p,mu,random(6), balancing(6));
v = calcLinearSpeed(t,a,fs,random(5), balancing(5))';
T = calcTemperature(t,v,fs)';

%% calculation of labels
label = labelData(p,mu,a,v,T,labelDepth,fs);

%% writing of values to csv 
if flag == 1    %% flag 1 TrainingData
    
    csvwrite([path name '/' name '_Training' '_' int2str(count) '.csv'],[v' a' mu' p' T']);
    str = [name '_Training_' int2str(count) '.csv' '\n'];
    fprintf(fid1, str);
    dlmwrite(['AutomaticCreationOfSignals/CreatedSignals/' name '/LabelsTraining.csv'],label,'-append');

elseif flag == 2 %% flag 2 TestingData
    
    csvwrite([path name '/' name '_Test' '_' int2str(count) '.csv'],[v' a' mu' p' T']);
    str = [name '_Test_' int2str(count) '.csv' '\n'];
    fprintf(fid1, str);
    dlmwrite(['AutomaticCreationOfSignals/CreatedSignals/' name '/LabelsTest.csv'],label,'-append');

elseif flag == 3 %% flag 3 Validation Data
    
    csvwrite([path name '/' name '_Validation' '_' int2str(count) '.csv'],[v' a' mu' p' T']);
    str = [name '_Validation_' int2str(count) '.csv' '\n'];
    fprintf(fid1, str);
    dlmwrite(['AutomaticCreationOfSignals/CreatedSignals/' name '/LabelsValidation.csv'],label,'-append');

end

% figure(2)
% subplot(5,1,1)
% plot(t,v);
% title('Velocity')
% 
% subplot(5,1,2)
% plot(t,a);
% title('Deccelleration')
% 
% subplot(5,1,3)
% plot(t,mu);
% title('Friction')
% 
% subplot(5,1,4)
% plot(t,p);
% title('Pressure')
% 
% subplot(5,1,5)
% plot(t,T);
% title('Temperature')

end

