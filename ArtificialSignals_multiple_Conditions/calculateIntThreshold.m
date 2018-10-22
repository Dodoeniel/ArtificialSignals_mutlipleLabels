
fs = 100;
v = 1:1/fs:5;
t_peak = 0.25;
peak = 0.48;
lowest = peak*0.8;
vSt = sqrt(t_peak);
vCoul = t_peak/10;
f = 0.02;
mu =sqrt(2)*(peak-lowest).*exp(-(v/vSt).^2).*v/vSt+lowest.*tanh(v/vCoul)+f*v;

integral = 0;
for i = 1:length(mu)
   integral = integral + mu(i)*fs; 
end
integral