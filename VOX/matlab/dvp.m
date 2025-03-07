function dy=dvp(t,y)
% DEsystem for the van der pol oscillator
a1=1.4;
a2=7.4;
k=0.3;
dy(1)=y(2);
dy(2)=(a1 - y(1)^2)*y(2) - y(1) - k*( y(1)-y(3) );
dy(3)=y(4);
dy(4)=(a2 - y(3)^2)*y(4) - y(3) - k*( y(3)-y(1) );
