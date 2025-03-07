% time discrete calculation of new mass position from differential equations of
% movement
%-------------------------------------------------------------------------
%deq16m.m
%
%
%
% input:
%
%	from inifold.m
%
%		T				:			Timestep
%
%	from cplforc.m
%
%		fxv			:		x-component of the resulting springforce
%									on the vocalis-mass
%		fxm			:		x-component of the resulting springforce
%									on the mucosa-mass
%		fzv			:		x-component of the resulting springforce
%									on the vocalis-mass
%		fzm			:		x-component of the resulting springforce
%									on the mucosa-mass
%
%	from aerforc.m
%
%		fexv			:		x-component of the aerodynamic force
%									on the vocalis-masses
%		fexm			:		x-component of the aerodynamic force
%									on the mucosa-masses
%		fezv			:		z-component of the aerodynamic force
%									on the vocalis-masses
%		fezm			:		z-component of the aerodynamic force
%									on the mucosa-masses
%
%	from contforc.m
%
%		fcxv		:		contactforce on the vocalis-mass
%		fcxm		:		contactforce on the mucosa-mass
%		fczv		:		contactforce on the vocalismass caused by the mucosamass
%		fczm		:		contactforce on the mucosamass caused by the vocalismass
%
%	from dampforc.m
%
%		fdxv		:		x-component of the dampingforce acting
%								on the vocalis-mass
%		fdxm		:		x-component of the dampingforce acting
%								on the mucosa-mass
%		fdzv		:		z-component of the dampingforce acting
%								on the vocalis-mass
%		fdzm		:		z-component of the dampingforce acting
%								on the mucosa-mass
%
%   from external_forces.m
%
%       fextzv      :       z-component of external force on vocalis
%
%       fextzm      :       z-component of external force on mucosa
%
%
% output:
%
%		xv			:		x-component of new vocalisposition
%		xm			:		x-component of new mucosaposition
%		zv			:		z-component of new vocalisposition
%		zm			:		z-component of new mucosaposition
%
%
% used files:
%
%		--
%
%
%----------------------------------------------------------------------

function [xv,xm,zv,zm] = deq16m(T, fxv, fxm, fzv, fzm, ...
   fexv, fexm, fezv, fezm, ...
   fcxv, fcxm, fczv, fczm, ...
   fdxv, fdxm, fdzv, fdzm, ...
   fextzv, fextzm, ...
   x_1, x_2, z_1, z_2, lmv, rmv, lmm, rmm)

global MAXM


xv_1(:,1:MAXM) = x_1(:,1:MAXM);
xm_1(:,1:MAXM) = x_1(:,MAXM+1:2*MAXM);
xv_2(:,1:MAXM) = x_2(:,1:MAXM);
xm_2(:,1:MAXM) = x_2(:,MAXM+1:2*MAXM);
zv_1(:,1:MAXM) = z_1(:,1:MAXM);
zm_1(:,1:MAXM) = z_1(:,MAXM+1:2*MAXM);
zv_2(:,1:MAXM) = z_2(:,1:MAXM);
zm_2(:,1:MAXM) = z_2(:,MAXM+1:2*MAXM);

% left fold
for j = 1:MAXM
   xv(1,j) = T^2./lmv(j) .* (fxv(1,j) + fdxv(1,j) + fcxv(1,j) + fexv(1,j)  + fextzv(1, j)) + 2*xv_1(1,j) - xv_2(1,j);
   xm(1,j) = T^2./lmm(j) .* (fxm(1,j) + fdxm(1,j) + fcxm(1,j) + fexm(1,j)  + fextzm(1, j)) + 2*xm_1(1,j) - xm_2(1,j);
   zv(1,j) = T^2./lmv(j) .* (fzv(1,j) + fdzv(1,j) + fczv(1,j) + fezv(1,j)) + 2*zv_1(1,j) - zv_2(1,j);
   zm(1,j) = T^2./lmm(j) .* (fzm(1,j) + fdzm(1,j) + fczm(1,j) + fezm(1,j))+ 2*zm_1(1,j) - zm_2(1,j);
end

% right fold
for j = 1:MAXM
   xv(2,j) = T^2./rmv(j) .* (fxv(2,j) + fdxv(2,j) + fcxv(2,j) + fexv(2,j)  + fextzv(2, j)) + 2*xv_1(2,j) - xv_2(2,j);
   xm(2,j) = T^2./rmm(j) .* (fxm(2,j) + fdxm(2,j) + fcxm(2,j) + fexm(2,j)  + fextzm(2, j)) + 2*xm_1(2,j) - xm_2(2,j);
   zv(2,j) = T^2./rmv(j) .* (fzv(2,j) + fdzv(2,j) + fczv(2,j) + fezv(2,j)) + 2*zv_1(2,j) - zv_2(2,j);
   zm(2,j) = T^2./rmm(j) .* (fzm(2,j) + fdzm(2,j) + fczm(2,j) + fezm(2,j)) + 2*zm_1(2,j) - zm_2(2,j);
end
% 
% for i = 1:2
%    Kasi(i)= 1;
% end


