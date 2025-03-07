
% calculation of the aerodynamic forces on the vocalis-mass and the
% mucosa-mass.
%-------------------------------------------------------------------
% aerforc.m
%
% input:
%
%	from press.m
%
%		ps		:		total subglottal pressure
%		pv		:		pressure on the vocalismasses
%		pm		:		pressure on the vocalismasses
%
%	from inifold.m
%
%		thv	    :		thickness of the vocalismasses
%		thm	    :		thickness of the mucosamasses
%		dv		:		depth of vocalismasses
%		dm		:		depth of mucosamasses
%		a		:		length of one mass
%
%	from glotpar.m
%
%		wv		:		width of glottal slit at vocalis section
%		wm		:		width of glottal slit at mucosa section
%
%
% output:
%
%		fexv		:		x-component of the aerodynamic force on the vocalis-masses
%		fexm		:		x-component of the aerodynamic force on the mucosa-masses
%		fezv		:		z-component of the aerodynamic force on the vocalis-masses
%		fezm		:		z-component of the aerodynamic force on the mucosa-masses
%
%-------------------------------------------------------------------
for i = 1:2
   for j = 1:MAXM
      fexv(i,j) = pv(j) * thv * a;
      fexm(i,j) = pm(j) * thm * a;
   end
end

if abs(fexv) > 100
   warning('TEST')
end

if wm>(wv+dv)
   for i = 1:2
      for j=1:MAXM
         fezv(i,j) = ps * dv * a  - (pm * dv * a);
      end
   end
else
   for i = 1:2
      for j = 1:MAXM
         fezv(i,j) = ps * dv * a  - (wm(i,j)-wv(i,j)) *pm(j) * (wm(i,j)-wv(i,j)) * a;
      end
   end
end

if wv > (wm+dm)
   for i = 1:2
      for j=1:MAXM
         fezm(i,j) = dm * pv(j) * a - pin * dm * a;
      end
   end
else
   for i = 1:2
      for j = 1:MAXM
         fezm(i,j) = (wm(i,j)-wv(i,j)) * pv(j) * (wv(i,j)-wm(i,j)) * a - pin * dm * a;
      end
   end
end

testfexv1(n,1:MAXM) = fexv(1,:);
testfexv2(n,1:MAXM) = fexv(2,:);
testfexm1(n,1:MAXM) = fexm(1,:);
testfexm2(n,1:MAXM) = fexm(2,:);
testfezv1(n,1:MAXM) = fezv(1,:);
testfezv2(n,1:MAXM) = fezv(2,:);
testfezm1(n,1:MAXM) = fezm(1,:);
testfezm2(n,1:MAXM) = fezm(2,:);
