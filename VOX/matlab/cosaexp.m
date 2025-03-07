function y=cosaexp(nu)
% definition of integrals

global Fs

deltat = 1/Fs;
y = exp(nu*deltat);