function y=k11(nu)
% definition of integrals

global Fs

deltat = 1/Fs;
%cosaexp = exp(nu*deltat);
I2 = (1/(nu*nu))*(cosaexp(nu)*(nu*deltat-1)+1);
y = I2/deltat;
