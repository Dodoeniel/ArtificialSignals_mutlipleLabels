function [a] = calcDeceleration_balanced(t,p,mu,random,balancing)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

c_pV = 38.9;
c_pH = 13.8;
r=0.3710; %  Reifenradius m
mu_const = 0.5;
m = 2565;           % [kg]
Ak_rr = sqrt(c_pV^2+c_pH^2)./(p*mu_const*2);
cp = 2.*Ak_rr.*mu.*p;
cp(1) = 0;
a = cp*2/(m*r).*p;

label_mu = Label_falling_mu(mu);

%% indexes for balancing
i_begin = floor(length(t)/6);
i_end = floor(length(t));
amplitude = 0.1*mean(a);
if label_mu == 0 && random < balancing/100 % mu Stribeck but da/dt<0 still true
    a(i_begin:i_end) = a(i_begin:i_end)+ amplitude.*sin(-1*pi*1/(t(i_begin)-t(i_end))*t(1:i_end-i_begin+1)-pi);
elseif label_mu == 1 && random > balancing/100 %% discard changes in mu
    cp = 2.*Ak_rr.*mean(mu).*p;
    cp(1) = 0;
    a = cp*2/(m*r).*p;
end

end

