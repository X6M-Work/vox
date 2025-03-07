function [C_minus, C_plus, A, B] ...
   = openhole(i, j, tubes, holes, c)
% open tone hole
% foratobert[i_,j_] := Block[{hf,df,dt,ke,a,b1,b2,tau,kf,nu01,nu02,nu1,nu2}]
% i: index of hole; j: index of true
hf = holes(j,2);
df = holes(j,3);
dt = tubes(i,2);
ke = 727.14;
a  = ke/df;
b1 = (df*df)/(2*dt*dt+df*df);
b2 = 1-2*b1;
tau = (2*hf)/c;
nu01 = -2-b2*a*tau;
nu02 = sqrt(nu01*nu01-8*b1);
nu1 = (a/2)*(nu01+nu02);
nu2 = (a/2)*(nu01-nu02);
kf = (2*b1*a*a*(1-b1))/(nu1-nu2);
C_plus  = [-b1, -(kf*exp(-(nu1*tau))), kf*exp(-(nu2*tau))];
C_minus = C_plus;
A = [0, 0, 					  0; ...
   0, cosaexp(nu1), 0; ...
   0, 0,						cosaexp(nu2)];
B = [1, 				0; ...
   k10(nu1), k11(nu1); ...
   k10(nu2), k11(nu2)];
