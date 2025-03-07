% Calculation of geometrical glottal parameters. The 'switches'
% vc and mc are set
%---------------------------------------------------------------------
% glotpar.m
%
% input:
%
%		xv			:		x-position of vocalis-mass
%		xm			:		x-position of mucosa-mass
%
%	from inifold.m:
%
%		dv			:		depth of vocalis-mass
%		dm			:		depth of mucosa-mass
%		wc			:		critical width for both masses
%
%	from params.m
%
%		cetav_o	:		dampingfactor if vocalismasses are open
%		cetav_c	:		dampingfactor if mucosamasses are closed
%		cetam_o	:		dampingfactor if vocalismasses are open
%		cetam_c	:		dampingfactor if mucosamasses are closed
%		cetaz_o	:		dampingfactor if vocalis and mucosa have no contact
%		cetaz_c	:		dampingfactor if vocalis and mucosa have contact
%
%
%
%
%
% output:
%
%		xvm		    :		point, where the couplespring is fixed at the vocalis-mass
%		wv			:		width of the glottal slit from the axis of symmetry
%								(half the opening-width) at the vocalis-mass in cm
%		wm			:		width of the glottal slit from the axis of symmetry
%								(half the opening-width) at the mucosa-mass
%		vc			:		1 if the glottis is closed at the vocalis-masses
%							0 else
%		mc			:		1 if the glottis is closed at the mucosa-masses
%							0 else
%		gc			:		1 if the glottis is closed somewhere
%							0 else
%		contz		:		1 if vocalismass and mucosamass are in contact
%							0 else
%		av			:		glottal area between the corresponding vocalis-masses
%		am			:		glottal area between the corresponding mucosa-masses
%  	    amin  	    :       minimum area in the glottal passage
%		ke			:		pressure recovery coefficient
%		cetaxv      :		dampingfactor for the vocalismass in x-direction
%		cetazv      :		dampingfactor for the vocalismass in z-direction
%		cetaxm      :		dampingfactor for the mucosamass in x-direction
%		cetazm      :		dampingfactor for the mucosamass in z-direction
%
%
%---------------------------------------------------------------------


xvm = xv - (dv-dm)/2;								    %m


% glottal widths -----------------------------------------------------

% wv = xv-dv/2;											%m
% wm = xm-dm/2;											%m

for i = 1:2
    for j = 1:MAXM
        if i == 1     %left fold
            wv(i,j) = xv(i,j)-dv/2-Infold.lvoffset(j)/1e4;           %m
            wm(i,j) = xm(i,j)-dm/2-Infold.lmoffset(j)/1e4;		   %m
        else          %right fold
            wv(i,j) = xv(i,j)-dv/2-Infold.rvoffset(j)/1e4;           %m
            wm(i,j) = xm(i,j)-dm/2-Infold.rmoffset(j)/1e4;           %m
        end
    end
end


% closing flags ------------------------------------------------------
for j = 1:MAXM
   if (xv(1,j)-Infold.lvoffset(j)/1e3 == dv/2 & xv(2,j)-Infold.rvoffset(j)/1e3 == dv/2)
      av(1,j)  = 0;
      vc(j)    = 1;
   elseif ((sign(wv(1,j))==-1 & sign(wv(2,j)) == -1) | ((wv(1,j) + wv(2,j)) == 0) |(sign(wv(1,j)+wv(2,j)) == -1))
      av(1,j)  = 0;
      vc(j)    = 1;
   else
      av(1,j) = (wv(1,j)+wv(2,j)) * a;
      vc(j)   = 0;
   end
end

for j = 1:MAXM
   if (xm(1,j)-Infold.lmoffset(j)/1e3 == dv/2 & xm(2,j)-Infold.rmoffset(j)/1e3 == dv/2)
      am(1,j) = 0;
      mc(j)   = 1;
   elseif ((sign(wm(1,j))==-1 & sign(wm(2,j)) == -1) | ((wm(1,j) + wm(2,j)) == 0) |(sign(wm(1,j)+wm(2,j)) == -1))
      am(1,j) = 0;
      mc(j)   = 1;
   else
      am(1,j) = (wm(1,j)+wm(2,j)) * a;
      mc(j)   = 0;
   end
end

contz = (zm<(zv+(thm+thv)/2));


% glottal areas ------------------------------------------------------
 
for j = 1:MAXM
   amin(j) = min(av(1,j),am(1,j));									%m^2
end

% dampingfactors -----------------------------------------------------

for h = 1:2
   for i = 1:MAXM
      cetaxv(h,i) = (vc(i) * cetav_c(h,i) + cetav_o(h,i));
      cetaxm(h,i) = (mc(i) * cetam_c(h,i) + cetam_o(h,i));
   end
end
cetazv = (contz .* cetaz_c + cetaz_o);
cetazm = (contz .* cetaz_c + cetaz_o);


