% Calculation of the Dampingforces from a resulting springconstant
%---------------------------------------------------------------------
% dampforc.m
%
%
%
% input:
%
%		x_1		:		x-displacement of masses one timestep T ago
%		z_1		:		z-displacement of masses one timestep T ago
%
%	from cplforc.m
%
%		ftv		:		forces between neighbour vocalis-masses
%		ftm		:		forces between neighbour mucosa-masses
%
%	from nndist.m
%
%		rv			:		distances between neighbour vocalismasses
%		rm			:		distances between neighbour mucosamasses
%
%	from params.m
%
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
%		mv			:		mass of vocalis
%		mm			:		mass of mucosa
%		cetaxv	:		dampingfactor of k2x
%		cetazv	:		dampingfactor of k2z
%		cetaxm	:		dampingfactor of k1x
%		cetazm	:		dampingfactor of k1z
%		cetatxv	:		dampingfactor of springs between vocalismasses
%								(x-component)
%		cetatxm	:		dampingfactor of springs between mucosamasses
%								(x-component)
%		cetatzv	:		dampingfactor of springs between vocalismasses
%								(z-component)
%		cetatzm	:		dampingfactor of springs between mucosamasses
%								(z-component)
%
%
% output:
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
%---------------------------------------------------------------------

xv_1 = x_1(:,1:MAXM);
xm_1 = x_1(:,MAXM+1:2*MAXM);
zv_1 = z_1(:,1:MAXM);
zm_1 = z_1(:,MAXM+1:2*MAXM);

% total spring-constants ---------------------------------------------

kdtxv = ftv ./ rv;
kdtzv = ftv ./ rv;
kdtxm = ftm ./ rm;
kdtzm = ftm ./ rm;
kdxv  = k2x;
kdzv  = k2z;
kdxm  = k1x;
kdzm  = k1z;

% degrees of damping -------------------------------------------------
% basti made spring vector extension

for j = 1:MAXM
   Dxv(1,j) = 2 * cetaxv(1,j) .* sqrt(lmv(1,j)*kdxv*Infold.lmbsfac(j));
   Dzv(1,j) = 2 * cetazv(1,j) .* sqrt(lmv(1,j)*kdzv*Infold.lmbsfac(j));
   Dxm(1,j) = 2 * cetaxm(1,j) .* sqrt(lmm(1,j)*kdxm*Infold.lmmsfac(j));
   Dzm(1,j) = 2 * cetazm(1,j) .* sqrt(lmm(1,j)*kdzm*Infold.lmmsfac(j));

   if size(lmv,2) == 1
      Dtxv(1,j) = 2 * cetatxv(1,j) .* sqrt(lmv(1,j).*kdtxv(1,j));
      Dtxm(1,j) = 2 * cetatxm(1,j) .* sqrt(lmm(1,j).*kdtxm(1,j));
      Dtzv(1,j) = 2 * cetatzv(1,j) .* sqrt(lmv(1,j).*kdtzv(1,j));
      Dtzm(1,j) = 2 * cetatzm(1,j) .* sqrt(lmm(1,j).*kdtzm(1,j));

   else
      Dtxv(1,j) = 2 * cetatxv(1,j) .* sqrt(lmv(1,MAXM).*kdtxv(1,j));
      Dtxm(1,j) = 2 * cetatxm(1,j) .* sqrt(lmm(1,MAXM).*kdtxm(1,j));
      Dtzv(1,j) = 2 * cetatzv(1,j) .* sqrt(lmv(1,MAXM).*kdtzv(1,j));
      Dtzm(1,j) = 2 * cetatzm(1,j) .* sqrt(lmm(1,MAXM).*kdtzm(1,j));
   end
end

for j = 1:MAXM
   Dxv(2,j) = 2 * cetaxv(2,j) .* sqrt(rmv(1,j)*kdxv*Infold.rmbsfac(j));
   Dzv(2,j) = 2 * cetazv(2,j) .* sqrt(rmv(1,j)*kdzv*Infold.rmbsfac(j));
   Dxm(2,j) = 2 * cetaxm(2,j) .* sqrt(rmm(1,j)*kdxm*Infold.rmmsfac(j));
   Dzm(2,j) = 2 * cetazm(2,j) .* sqrt(rmm(1,j)*kdzm*Infold.rmmsfac(j));

   if size(rmv,2) == 1
      Dtxv(2,j) = 2 * cetatxv(2,j) .* sqrt(rmv(1,j).*kdtxv(2,j));
      Dtxm(2,j) = 2 * cetatxm(2,j) .* sqrt(rmm(1,j).*kdtxm(2,j));
      Dtzv(2,j) = 2 * cetatzv(2,j) .* sqrt(rmv(1,j).*kdtzv(2,j));
      Dtzm(2,j) = 2 * cetatzm(2,j) .* sqrt(rmm(1,j).*kdtzm(2,j));

   else
      Dtxv(2,j) = 2 * cetatxv(2,j) .* sqrt(rmv(1,MAXM).*kdtxv(2,j));
      Dtxm(2,j) = 2 * cetatxm(2,j) .* sqrt(rmm(1,MAXM).*kdtxm(2,j));
      Dtzv(2,j) = 2 * cetatzv(2,j) .* sqrt(rmv(1,MAXM).*kdtzv(2,j));
      Dtzm(2,j) = 2 * cetatzm(2,j) .* sqrt(rmm(1,MAXM).*kdtzm(2,j));
   end
end

% result2ng damping forces -------------------------------------------
for i = 1:2
   if MAXM > 1
      fdxv(i,1) = ...
         -Dxv(i,1) * (xv(i,1) - xv_1(i,1))/T ...
         + Dxm(i,1) * ((xm(i,1) - xm_1(i,1)) - (xv(i,1) - xv_1(i,1)))/T ...
         - Dtxv(i,1) * ((xv(i,1) - x0v0(i,1)) - (xv_1(i,1) - x0v0(i,1)))/T ...
         - Dtxv(i,2) * ((xv(i,1) - xv(i,2)) - (xv_1(i,1) - xv_1(i,2)))/T;
      fdxm(i,1) = ...
         - Dxm(i,1) * ((xm(i,1) - xm_1(i,1)) - (xv(i,1) - xv_1(i,1)))/T ...
         - Dtxm(i,1) * ((xm(i,1) - x0m0(i,1)) - (xm_1(i,1) - x0m0(i,1)))/T ...
         - Dtxm(i,2) * ((xm(i,1) - xm(i,2)) - (xm_1(i,1) - xm_1(i,2)))/T;
      fdzv(i,1) = ...
         -Dzv(i,1) * (zv(i,1) - zv_1(i,1))/T ...
         + Dzm(i,1) * ((zm(i,1) - zm_1(i,1)) - (zv(i,1) - zv_1(i,1)))/T ...
         - Dtzv(i,1) * ((zv(i,1) - z0v0(1,i)) - (zv_1(i,1) - z0v0(1,i)))/T ...
         - Dtzv(i,2) * ((zv(i,1) - zv(i,2)) - (zv_1(i,1) - zv_1(i,2)))/T;
      fdzm(i,1) = ...
         - Dzm(i,1) * ((zm(i,1) - zm_1(i,1)) - (zv(i,1) - zv_1(i,1)))/T ...
         - Dtzm(i,1) * ((zm(i,1) - z0m0(1,i)) - (zm_1(i,1) - z0m0(1,i)))/T ...
         - Dtzm(i,2) * ((zm(i,1) - zm(i,2)) - (zm_1(i,1) - zm_1(i,2)))/T;
   end
end
for i = 1:2
   for j = 2:MAXM-1
      if MAXM > 1
         fdxv(i,j) = ...
            -Dxv(i,j) * (xv(i,j) - xv_1(i,j))/T ...
            + Dxm(i,j) * ((xm(i,j) - xm_1(i,j)) - (xv(i,j) - xv_1(i,j)))/T ...
            - Dtxv(i,j) * ((xv(i,j) - xv(i,j-1)) - (xv_1(i,j) - xv_1(i,j-1)))/T ...
            - Dtxv(i,j+1) * ((xv(i,j) - xv(i,j+1)) - (xv_1(i,j) - xv_1(i,j+1)))/T;

         fdxm(i,j) = ...
            - Dxm(i,j) * ((xm(i,j) - xm_1(i,j)) - (xv(i,j) - xv_1(i,j)))/T ...
            - Dtxm(i,j) * ((xm(i,j) - xm(i,j-1)) - (xm_1(i,j) - xm_1(i,j-1)))/T ...
            - Dtxm(i,j+1) * ((xm(i,j) - xm(i,j+1)) - (xm_1(i,j) - xm_1(i,j+1)))/T;

         fdzv(i,j) = ...
            -Dzv(i,j) * (zv(i,j) - zv_1(i,j))/T ...
            + Dzm(i,j) * ((zm(i,j) - zm_1(i,j)) - (zv(i,j) - zv_1(i,j)))/T ...
            - Dtzv(i,j) * ((zv(i,j) - zv(i,j-1)) - (zv_1(i,j) - zv_1(i,j-1)))/T ...
            - Dtzv(i,j+1) * ((zv(i,j) - zv(i,j+1)) - (zv_1(i,j) - zv_1(i,j+1)))/T;
         - Dtzv(i,j) * ((zv(i,j) - zv(i,j)) - (zv_1(i,j) - zv_1(i,j)))/T ...
            - Dtzv(i,j) * ((zv(i,j) - zv(i,j)) - (zv_1(i,j) - zv_1(i,j)))/T;
         fdzm(i,j) = ...
            - Dzm(i,j) * ((zm(i,j) - zm_1(i,j)) - (zv(i,j) - zv_1(i,j)))/T ...
            - Dtzm(i,j) * ((zm(i,j) - zm(i,j-1)) - (zm_1(i,j) - zm_1(i,j-1)))/T ...
            - Dtzm(i,j+1) * ((zm(i,j) - zm(i,j+1)) - (zm_1(i,j) - zm_1(i,j+1)))/T;
      end
   end
end
for i = 1:2
   fdxv(i,MAXM) = ...
      - Dxv(i,MAXM) * (xv(i,MAXM) - xv_1(i,MAXM))/T ...
      + Dxm(i,MAXM) * ((xm(i,MAXM) - xm_1(i,MAXM)) - (xv(i,MAXM) - xv_1(i,MAXM)))/T ...
      - Dtxv(i,MAXM) * ((xv(i,MAXM) - xv(i,MAXM-1)) - (xv_1(i,MAXM) - xv_1(i,MAXM-1)))/T ...
      - Dtxv(i,MAXM) * ((xv(i,MAXM) - x0vmaxmp1(i,1)) - (xv_1(i,MAXM) - x0vmaxmp1(i,1)))/T;
   fdxm(i,MAXM) = ...
      - Dxm(i,MAXM) * ((xm(i,MAXM) - xm_1(i,MAXM)) - (xv(i,MAXM) - xv_1(i,MAXM)))/T ...
      - Dtxm(i,MAXM) * ((xm(i,MAXM) - xm(i,MAXM-1)) - (xm_1(i,MAXM) - xm_1(i,MAXM-1)))/T ...
      - Dtxm(i,MAXM) * ((xm(i,MAXM) - x0mmaxmp1(i,1)) - (xm_1(i,MAXM) - x0mmaxmp1(i,1)))/T;
   fdzv(i,MAXM) = ...
      - Dzv(i,MAXM) * (zv(i,MAXM) - zv_1(i,MAXM))/T ...
      + Dzm(i,MAXM) * ((zm(i,MAXM) - zm_1(i,MAXM)) - (zv(i,MAXM) - zv_1(i,MAXM)))/T ...
      - Dtzv(i,MAXM) * ((zv(i,MAXM) - zv(i,MAXM-1))-(zv_1(i,MAXM) - zv_1(i,MAXM-1)))/T ...
      - Dtzv(i,MAXM) * ((zv(i,MAXM) - z0vmaxmp1(1,i))-(zv_1(i,MAXM) - z0vmaxmp1(1,i)))/T;
   fdzm(i,MAXM) = ...
      - Dzm(i,MAXM) * ((zm(i,MAXM) - zm_1(i,MAXM)) - (zv(i,MAXM) - zv_1(i,MAXM)))/T ...
      - Dtzm(i,MAXM) * ((zm(i,MAXM) - zm(i,MAXM-1)) - (zm_1(i,MAXM) - zm_1(i,MAXM-1)))/T ...
      - Dtzm(i,MAXM) * ((zm(i,MAXM) - z0mmaxmp1(1,i)) - (zm_1(i,MAXM) - z0mmaxmp1(1,i)))/T;

end



if MAXM < 1
   fdxv(i,1) = ...
      -Dxv(i,1) * (xv(i,1) - xv_1(i,1))/T ...
      + Dxm(i,1) * ((xm(i,1) - xm_1(i,1)) - (xv(i,1) - xv_1(i,1)))/T ...
      - Dtxv(i,1) * ((xv(i,1) - x0v0(i,1)) - (xv_1(i,1) - x0v0(i,1)))/T ...
      - Dtxv(i,2) * ((xv(i,1) - x0vmaxmp1) - (xv_1(i,1) - x0vmaxmp1))/T;
   fdxm(i,1) = ...
      - Dxm(i,1) * ((xm(i,1) - xm_1(i,1)) - (xv(i,1) - xv_1(i,1)))/T ...
      - Dtxm(i,1) * ((xm(i,1) - x0mmaxmp1) - (xm_1(i,1) - x0mmaxmp1))/T ...
      - Dtxm(i,2) * ((xm(i,1) - x0mmaxmp1) - (xm_1(i,1) - x0mmaxmp1))/T;
   fdzv(i,1) = ...
      -Dzv(i,1) * (zv(i,1) - zv_1(i,1))/T ...
      + Dzm(i,1) * ((zm(i,1) - zm_1(i,1)) - (zv(i,1) - zv_1(i,1)))/T ...
      - Dtzv(i,1) * ((zv(i,1) - z0v0(1,i)) - (zv_1(i,1) - z0v0(1,i)))/T ...
      - Dtzv(i,2) * ((zv(i,1) - z0vmaxmp1) - (zv_1(i,1) - z0vmaxmp1))/T;
   fdzm(i,1) = ...
      - Dzm(i,1) * ((zm(i,1) - zm_1(i,1)) - (zv(i,1) - zv_1(i,1)))/T ...
      - Dtzm(i,1) * ((zm(i,1) - z0m0(1,i)) - (zm_1(i,1) - z0m0(1,i)))/T ...
      - Dtzm(i,2) * ((zm(i,1) - z0mmaxmp1) - (zm_1(i,1) - z0mmaxmp1))/T;
end

testfdxv1(n,1:MAXM) = fdxv(1,:);
testfdxv2(n,1:MAXM) = fdxv(2,:);
testfdxm1(n,1:MAXM) = fdxm(1,:);
testfdxm2(n,1:MAXM) = fdxm(2,:);
testfdzv1(n,1:MAXM) = fdzv(1,:);
testfdzv2(n,1:MAXM) = fdzv(2,:);
testfdzm1(n,1:MAXM) = fdzm(1,:);
testfdzm2(n,1:MAXM) = fdzm(2,:);