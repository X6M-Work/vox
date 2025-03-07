% calculate some vocaltract stuff...
function [Bm, Bp, a32, Teta32, A32, rvoc, numcyl, lastj, lastp2,...
   damp, pmr2, ppl2, pmR, pmT, ppR, ppT, zmR,...
   p_out_mouth, Rm] = initract % Input modificated ( was: vowel )

global c Hndl Xi0 radimproutine

%=========================================================================================
% modificated 18.01.2000 by Daniel Riemann
data=get(Hndl.figureNumber, 'UserData');
radius = data.radius;
%area = get(VOWEL,'UserData');
%radius = sqrt(area/pi)/100;
%modelname=['"' vowelname '" MRI data'];
%filename=[vowelname '_01_kk.dat'];
%savename=[vowelname '_calm'];
%savenamef=[vowelname '_calmf'];
%End of modification
%========================================================================================================

% system parameters
%dist=0.396825e-2;				% distance between sample points [m]
dist = data.spacing;
numcyl=length(radius);		% number of cylinders constituting the VT model
lastj=numcyl+1;					% index of last junction (=output end)

% air properties
c0 = c;							% sound speed in air [m/s], GLOBAL!

Fs = round(c0/dist);					% sampling frequency

% derived parameters
dx=c0/Fs;							% path increment [m]
dt=1/Fs;							% time increment [s]

%Xi0=0.005135;					% constant for damping, depending upon air
% viscosity, wall thermal conductivity, constant
% pressure specific heat and the ratio between
% constant pressure and constant volume specific
% heats
damp=1-Xi0;
nuem=zeros(1,numcyl-1);		% reflection coefficient
nuep=zeros(1,numcyl-1);		% refl. coeff. for backwards travelling waves


% cylindrical segments of the VT model

% length of cylinders from left to right [m]
lcyld=ones(1,numcyl);
lcyl=lcyld*dist;
lsum=sum(lcyl);					% total length of vocal tract
n=round(lsum/dx);				% total number of samples
nspc=round(lcyl*n/lsum);		% number of samplepoints within each cylinder

% radius of cylinders from left to right: rl=left radius; rr=right radius [m]
rl=radius;
rr=rl;

for i=2:numcyl
   Bm(i)=(rr(i-1)/rl(i))^2;	% Sout/Sin
end
Bm(1)=1;	% dummy value for division in next line
Bp=1./Bm;

if radimproutine == 1
   % reflection at cylindrical open output end - old routine
   a=-c0/(2*rr(numcyl));
   a32=a;
   b3=a;

   Teta32=[exp(b3*dt)];			% matrix Teta for output end
   TT21=((b3*dt-1)+exp(-b3*dt))/(dt*b3^2);	% 2nd row, 1st col.
   TT22=(1-(1+b3*dt)*exp(-b3*dt))/(dt*b3^2);
   TetaT32=[TT21 TT22];			% matrix	TetaTilde for output end
   A32=Teta32*TetaT32;			% matrix A (1 row, 2 columns) for output end
   Rm = [];

elseif radimproutine == 2
   % reflection at cylindrical open output end - new routine
   ord 	= 18;
   d     = 2*radius(end);
   Fs    = data.Fs;
   fmax  = round(Fs/2);
   x     = 0:50:fmax;
   k     = 2*pi*x/c;
   f     = 1 -	2*besselj(1,k*d)./(k*d) + j*2*mstruv(k*d) ./(k*d);
   f(isnan(f))=0;
   fy    = x/fmax;
   %  my    = abs(f);
   Rm.f 	= abs((f - 1)./(f + 1));
   %	T 		= abs(    2*f./(f + 1));
   %  [b,a] = yulewalk(ord,fy,my);
   %  [A,B,C,D] = tf2ss(b,a);
   [Rm.b,Rm.a] = yulewalk(ord,fy,Rm.f);
   [Rm.A,Rm.B,Rm.C,Rm.D] = tf2ss(Rm.b,Rm.a);
   %  [bT,aT] = yulewalk(ord,fy,T);
   %  [AT,BT,CT,DT] = tf2ss(bT,aT);
   Rm.state = zeros(ord,2);
end

% initialization of structs for pressure calculus inside the waveguide
% smallest index for time indicates latest incoming value
for i=1:numcyl
   lastp2(i)=1+lcyld(i);
   pmr2.junction(i).time=zeros(1,lastp2(i));
   ppl2.junction(i+1).time=zeros(1,lastp2(i));
   lastp(i)=lastp2(i)+1;
   pmR.junction(i+1).time=zeros(1,1);
   pmT.junction(i+1).time=zeros(1,1);
   ppR.junction(i).time=zeros(1,1);
   ppT.junction(i).time=zeros(1,1);
   zmR.junction(i+1).time=zeros(1,2);
end

rvoc = radius(1);
p_out_mouth = 0;
