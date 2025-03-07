function y=k21(nu)
% definition of integrals

global Fs

deltat = 1/Fs;
cosaexp = exp(nu*deltat);
I3 = (1/(nu*nu*nu))*(cosaexp*(nu*deltat*(nu*deltat-2)+2)-2);
y = I3/deltat;