% Calculation of the springforces, acting on the masses. 
% Each mass is coupled to its nearest neighbours in y-direction. The vocalis-mass
% is also coupled to the boundary (linear spring k2) and the mucosa-
% mass (linear spring k1).
%---------------------------------------------------------------------
% cplforc.m
%
%
%
% input:
%
%		xv			:		x-component of the vocalis-mass-position
%		xm			:		x-component of the mucosa-mass-position
%		zv			:		z-component of the vocalis-mass-position
%		zm			:		z-component of the mucosa-mass-position
%		tvakt		:		active vocalis stress
%
%
%	from params.m
%
%		x0v		:		x-component of the vocalis restposition
%		z0v		:		z-component of the vocalis restposition
%		x0v0		:		x-component of the front-fixing of the vocalis in y-direction
%		x0vmaxmp1		:		x-component of the end-fixing of the vocalis in y-direction
%		x0m0		:		x-component of the front-fixing of the mucosa in y-direction
%		x0mmaxmp1		:		x-component of the end-fixing of the mucosa in y-direction
%		k1x		:		springconstant of the spring
%								between the vocalis-mass and the mucosa-mass
%								in x-direction
%		k1z		:		springconstant of the spring
%								between the vocalis-mass and the mucosa-mass
%								in z-direction
%		k2x		:		springconstant of the spring
%								between the vocalis-mass and the boundary
%								in x-direction
%		k2z		:		springconstant of the spring
%								between the vocalis-mass and the boundary
%								in z-direction
%
%	from inifold.m
%
%		thl		:		thickness of ligamentum
%		thv		:		thickness of vocalismass
%		thm		:		thickness of mucosamass
%		dl			:		depth of ligamentum
%		dv			:		depth of vocalis
%		dm			:		depth of mucosa
%		z0v0		:		z-component of the front-fixing of the vocalis in y-direction
%		z0vmaxmp1		:		z-component of the end-fixing of the vocalis in y-direction
%		z0m0		:		z-component of the front-fixing of the mucosa in y-direction
%		z0mmaxmp1		:		z-component of the end-fixing of the mucosa in y-direction
%		eta_k1x	:		factor of nonlinearity for the vocalis-mucosa-spring k1
%								in x-direction
%		eta_k1	:		factor of nonlinearity for the vocalis-mucosa-spring k1
%								in z-direction
%		eta_k2x	:		factor of nonlinearity for the vocalis-boundary-spring k2
%								in x-direction
%		eta_k2z	:		factor of nonlinearity for the vocalis-boundary-spring k2
%								in z-direction
%
%	from strains.m
%
%		sm			:		strain of mucosamasses
%		sv			:		strain of vocalismasses
%		sl			:		strain of ligamentum (same as sv)
%
%
%
% output:
%
%		fxv		:		x-component of the resulting springforce
%							on the vocalis-mass
%		fxm		:		x-component of the resulting springforce
%							on the mucosa-mass
%		fzv		:		z-component of the resulting springforce
%							on the vocalis-mass
%		fzm		:		z-component of the resulting springforce
%							on the mucosa-mass
%
%
% used files:
%
%		nndist.m		:		calculation of nearest neighbour distances
%		strains.m	:		strains between neighbours (and boundary)
%
%---------------------------------------------------------------------


nndist;
strains;

% tensions between neighbour masses -----------------------------------

tv = tvfac.*(0.4 + 42.3 .* sv - 341.9 .* sv.^2 + 1132 .* sv.^3)*1000; %Pa
tm = tmfac.*(0.5 + 38.3 .* sm - 49.5 .* sm.^2 + 347.6 .* sm.^3)*1000; %Pa


% resulting forces on the masses --------------------------------------

ftm = thm * dm .* tm;
ftv = (-sign(sl) * thl*dl * taul .* log(1-abs(sl)/slmax) + thv * dv * (tv + tvakt));


% couplingforces on the masses from tensions ------------------------------

if MAXM > 1
   for i = 1:2
      fyxv(i,1) = ftv(i,1) * (x0v0(i,1) - xv(i,1)) / rv(i,1) ...
         + ftv(i,2) * (xv(i,2) - xv(i,1)) / rv(i,2);
      fyxm(i,1) = ftm(i,1) * (x0m0(i,1) - xm(i,1)) / rm(i,1) ...
         + ftm(i,2) * (xm(i,2) - xm(i,1)) / rm(i,2);
      fyzv(i,1) = ftv(i,1) * (z0v0(1,i) - zv(i,1)) / rv(i,1) ...
         + ftv(i,2) * (zv(i,2) - zv(i,1)) / rv(i,2);
      fyzm(i,1) = ftm(i,1) * (z0m0(1,i) - zm(i,1)) / rm(i,1) ...
         + ftm(i,2) * (zm(i,2) - zm(i,1)) / rm(i,2);

   end
   for j = 1:2
      for i = 2:MAXM-1
         fyxv(j,i) = ftv(j,i) * (xv(j,i-1) - xv(j,i)) / rv(j,i) ...
            + ftv(j,i+1) * (xv(j,i+1) - xv(j,i)) / rv(j,i+1);
         fyxm(j,i) = ftm(j,i) * (xm(j,i-1) - xm(j,i)) / rm(j,i) ...
            + ftm(j,i+1) * (xm(j,i+1) - xm(j,i)) / rm(j,i+1);
         fyzv(j,i) = ftv(j,i) * (zv(j,i-1) - zv(j,i)) / rv(j,i) ...
            + ftv(j,i+1) * (zv(j,i+1) - zv(j,i)) / rv(j,i+1);
         fyzm(j,i) = ftm(j,i) * (zm(j,i-1) - zm(j,i)) / rm(j,i) ...
            + ftm(j,i+1) * (zm(j,i+1) - zm(j,i)) / rm(j,i+1);
      end
   end
   for i = 1:2
      fyxv(i,MAXM) = ftv(i,MAXM) * (xv(i,MAXM-1) - xv(i,MAXM)) / rv(i,MAXM) ...
         + ftv(i,MAXM+1) * (x0vmaxmp1(i,1) - xv(i,MAXM)) / rv(i,MAXM+1);
      fyxm(i,MAXM) = ftm(i,MAXM) * (xm(i,MAXM-1) - xm(i,MAXM)) / rm(i,MAXM) ...
         + ftm(i,MAXM+1) * (x0mmaxmp1(i,1) - xm(i,MAXM)) / rm(i,MAXM+1);
      fyzv(i,MAXM) = ftv(i,MAXM) * (zv(i,MAXM-1) - zv(i,MAXM)) / rv(i,MAXM) ...
         + ftv(i,MAXM+1) * (z0vmaxmp1(1,i) - zv(i,MAXM)) / rv(i,MAXM+1);
      fyzm(i,MAXM) = ftm(i,MAXM) * (zm(i,MAXM-1) - zm(i,MAXM)) / rm(i,MAXM) ...
         + ftm(i,MAXM+1) * (z0mmaxmp1(1,i) - zm(i,MAXM)) / rm(i,MAXM+1);
   end
else
   fyxv(:,1) = ftv(:,1) * (x0v0 - xv(:,1)) / rv(:,1) ...
      + ftv(:,2) * (x0vmaxmp1 - xv(:,1)) / rv(:,2);
   fyxm(:,1) = ftm(:,1) * (x0m0 - xm(:,1)) / rm(:,1) ...
      + ftm(:,2) * (x0mmaxmp1 - xm(:,1)) / rm(:,2);
   fyzv(:,1) = ftv(:,1) * (z0v0 - zv(:,1)) / rv(:,1) ...
      + ftv(:,2) * (z0vmaxmp1 - zv(:,1)) / rv(:,2);
   fyzm(:,1) = ftm(:,1) * (z0m0 - zm(:,1)) / rm(:,1) ...
      + ftm(:,2) * (z0vmaxmp1 - zm(:,1)) / rm(:,2);

   % 	fyxv(1) = 0;
   % 	fyxm(1) = 0;
   % 	fyzv(1) = 0;
   % 	fyzm(1) = 0;


end

testfyxv1(n,1:MAXM) = fyxv(1,:);
testfyxv2(n,1:MAXM) = fyxv(2,:);
testfyxm1(n,1:MAXM) = fyxm(1,:);
testfyxm2(n,1:MAXM) = fyxm(2,:);
testfyzv1(n,1:MAXM) = fyzv(1,:);
testfyzv2(n,1:MAXM) = fyzv(2,:);
testfyzm1(n,1:MAXM) = fyzm(1,:);
testfyzm2(n,1:MAXM) = fyzm(2,:);

% coupling force from spring k1 ----------------------------------------
% TODO: is here a need for the spring stiffness vector?

f1xv = k1x * ((xm-xvm) + eta_k1x(1,1) * (xm-xvm).^3);
f1xm = k1x * ((xvm-xm) + eta_k1x(1,1) * (xvm-xm).^3);
f1zv = k1z * ((zm-(zv+(thv+thm)/2)) + eta_k1z(1,1) * (zm-(zv+(thv+thm)/2)).^3);
f1zm = k1z * (((zv+(thv+thm)/2)-zm) + eta_k1z(1,1) * ((zv+(thv+thm)/2)-zm).^3);


% coupling force from spring k2 ----------------------------------------

f2xv = k2x * ((x0v-xv) + eta_k2x(1,1) * (x0v-xv).^3);
f2zv = k2z * ((z0v-zv) + eta_k2x(1,1) * (z0v-zv).^3);

% resulting forces on the masses ---------------------------------------

fxv = fyxv + f1xv + f2xv;
fxm = fyxm + f1xm;
fzv = fyzv + f1zv + f2zv;
fzm = fyzm + f1zm;
