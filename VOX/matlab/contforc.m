% Forces, that act on the masses if the glottis is closed at these masses. 
% The contactforces are not linear.
%---------------------------------------------------------------------
% contforc.m
%
%
% input:
%
%
%	from params.m
%
%		kcxv		:		(linear) spring-constant of the contactspring (vocalis)
%		kcxm		:		(linear) spring-constant of the contactspring (mucosa)
%		kczv		:		(linear) spring-constant of the contactspring between
%								mucosa and vocalis
%		kczm		:		same as kczv
%
%	from inifold.m
%
%		eta_kcxv	:		nonlinearity-factor of the contactspring (vocalis)
%		eta_kcxm	:		nonlinearity-factor of the contactspring (mucosa)
%		eta_kczv	:		nonlinearity-factor of the contactspring between
%								mucosa and vocalis
%		eta_kczm	:		same as eta_kczv
%		wc			:		closing width of glottal slit
%
%
% output:
%
%		fcxv		:		contactforce on the vocalis-mass
%		fcxm		:		contactforce on the mucosa-mass
%		fczv		:		contactforce on the vocalismass caused by the mucosamass
%		fczm		:		contactforce on the mucosamass caused by the vocalismass
%
%
%-------------------------------------------------------------------
for  j = 1:2
   for i = 1:MAXM
      if vc(i) == 0
         fcxv(j,i) = 0;
      else
         fcxv(j,i) =  kcxv * (wc-wv(j,i)) + eta_kcxv(1,j) * (wc-wv(j,i).^3);
      end
      if mc(i) == 0
         fcxm(j,i) = 0;
      else
         fcxm(j,i) =  kcxm * (wc-wm(j,i)) + eta_kcxm(1,j) * (wc-wm(j,i).^3);
      end
   end
end
for j = 1:2
   for i = 1:MAXM
      fczv(j,i) = contz(j,i) * kczv * ((zm(j,i) - zv(j,i) - (thm+thv)/2) + eta_kczv(1,j) * (zm(j,i) - zv(j,i) - (thm+thv)/2).^3);
      fczm(j,i) = contz(j,i) * kczm * ((zv(j,i) - zm(j,i) + (thv+thm)/2) + eta_kczm(1,j) * (zv(j,i) - zm(j,i) + (thv+thm)/2).^3);
   end
end