function [C_minus, C_plus, A, B] ...
   = closedhole(i, j, tubes, holes, c)
% closed tone hole
% foratapat[i_,j_] := Block[{hf,df,dt,nu,s,c1,c2}]
% i: index of hole; j: index of true
hf = holes(j,2);
df = holes(j,3);
dt = tubes(i,2);
s  = 0.1*df/hf;
nu = -(2*c*dt*dt)/((s+1)*df*df*hf);
c1 = (s-1)/(s+1);
c2 = c1*nu;
C_plus  = [c1, c2];
C_minus = C_plus;
A = [0, 0; ...
   0, cosaexp(nu)];
B = [1, 			0; ...
   k10(nu), k11(nu)];
