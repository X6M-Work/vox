function dy=d2m(t,y)
par;
a1 = a01 + 2*l*y(1);
a2 = a02 + 2*l*y(3);
p1 = ps * ( 1 - (min(a1,a2)/a1)^2*theta(min(a1,a2)) ) * theta(a1);
% lower mass
dy(1)=y(2);
dy(2)=( l*d1*p1 - ...                                     %driving force
   r1*y(2) - ...                                     %damping force
   k1*y(1) - ...                                     %restoring force
   theta(-a1)*c1*a1/(2*l) -...                       %contact force
   kc*(y(1)-y(3)) )/m1;                              %coupling force
% upper mass
dy(3)=y(4);
dy(4)=( -r2*y(4) - ...                                    %damping force
   k2*y(3) - ...                                     %restoring force
   theta(-a2)*c2*a2/(2*l) -...                       %contact force
   kc*(y(3)-y(1)) )/m2;                              %coupling force
dy=dy';


