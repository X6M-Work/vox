function y=k10(nu)
% definition of integrals

global Fs

deltat = 1/Fs;
I1 = (1/nu)*(cosaexp(nu)-1);
I2 = (1/(nu*nu))*(cosaexp(nu)*(nu*deltat-1)+1);
k11 = I2/deltat;
y = I1-k11;
