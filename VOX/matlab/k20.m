function y=k20(nu)
% definition of integrals

global Fs

deltat = 1/Fs;
I3 = (1/(nu*nu*nu))*(cosaexp(nu)*(nu*deltat*(nu*deltat-2)+2)-2);
k21 = I3/deltat;
I2 = (1/(nu*nu))*(cosaexp(nu)*(nu*deltat-1)+1);
y = I2-k21;
