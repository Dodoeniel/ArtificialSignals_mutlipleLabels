function [mu] = calcFrictionDataBalanced(v, random, balancing, fs)
%CALCFRICTIONDATA Calculates the Friction Data for Artificial Brake Model
%   Based on the input argument v a stribeck curve is calculated
%   representing the friction data. The random argument will distort the
%   stribeck curve to achieve different signals and the balancing argument
%   balance distorts the curve such that based on how high the balancing
%   argument is, balance in % outputs will suffice the condition that at
%   some point dm/dv < 0


% https://de.mathworks.com/help/physmod/simscape/ref/translationalfriction.html
mu_tr = 0.384;
range_peak = 0.25;
% height of the peak
peak = 1/0.8*mu_tr - range_peak*balancing(3)/100+range_peak*random(3); 

t_peak = 0.25+random(1)*0.15;     % at which time shall the peak occur

lowest = 0.8*peak; % lowest point in the Stribeck curve

%% viscous friction factor
range_f = 0.01;
f = 0.0225-balancing(2)/100*range_f+range_f*random(2);

%% remainin calculation factor
vSt = sqrt(t_peak);
vCoul = t_peak/10;

%% calculate Stribeck curve
% v = t in this calculation
mu_complete=sqrt(2)*(peak-lowest).*exp(-(v/vSt).^2).*v/vSt+lowest.*tanh(v/vCoul)+f*v;

%% 
index_peak = floor(t_peak*fs)-4;
mu = zeros(1,length(mu_complete));
if random(1) < balancing(1)/100 % then condition true --> normal Stribeck
    mu = mu_complete;
else
    mu(1:index_peak) = mu_complete(1:index_peak);
    mu(index_peak+1:end) = mu_complete(index_peak+1)*ones(1,length(mu(index_peak+1:end)))+f*v(1:length(index_peak+1:end));
end


    
    

end

