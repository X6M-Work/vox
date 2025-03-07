% initialisation of vocal fold parameters
%
% input:
%
%   foldsig functionparameters
%
% output:
%
%      mv            :         vocalis mass
%      mm            :         mucosa mass
%      lg            :         total length of vocal folds
%      a             :         length of one vocalis/mucosamass
%      taul          :         stress constant of ligamentum
%      as            :         input area of subglottal resonator
%      avoc          :         input area of vocal tract
%      z_sub_1       :         input impedance of first subglottal segment
%      z_voc_1       :         input impedance of first vocal tract segment
%      k1x           :         springconstant of the spring
%                              between the vocalis-mass and the mucosa-mass
%                              in x-direction
%      k1z           :         springconstant of the spring
%                              between the vocalis-mass and the mucosa-mass
%                              in z-direction
%      k2x           :         springconstant of the spring
%                              between the vocalis-mass and the boundary
%                              in x-direction
%      k2z           :         springconstant of the spring
%                              between the vocalis-mass and the boundary
%                              in z-direction
%      kcxv          :         linear spring constant of vocalis-contactspring
%                              in x-direction
%      kcxm          :         linear spring constant of mucosa-contactspring
%                              in x-direction
%      kczv          :         linear spring constant of vocalis-mucosa-contactspring
%                              in z-direction
%      kczm          :         same as kczv
%      x0v0          :         x-component of the front-fixing of the vocalis in y-direction
%      x0vmaxmp1     :         x-component of the end-fixing of the vocalis in y-direction
%      x0m0          :         x-component of the front-fixing of the mucosa in y-direction
%      x0mmaxmp1     :         x-component of the end-fixing of the mucosa in y-direction
%      x0v           :         x-component of the vocalis restposition
%      x0m           :         x-component of the mucosa restposition
%      x0vm          :         x-component of the vocalis-mucosa-fixpoint
%      z0v           :         z-component of the vocalis restposition
%      z0m           :         z-component of the mucosa restposition
%      r0v           :         initial distances between nearest vocalis neighbours
%      r0m           :         initial distances between nearest mucosa neighbours
%      u_min_voc     :          reflected flow from vocal tract
%      u_plus_sub    :          reflected flow from subglottal resonator
%      VOC           :         Flag indicating if vocal tract is considered
%      SUB           :         Flag indicating if subglottal resonator is considered
%      cetav_o       :         dampingcoefficient if vocalismasses are open
%      cetav_c       :         dampingcoefficient if mucosamasses are closed
%      cetam_o       :         dampingcoefficient if vocalismasses are open
%      cetam_c       :         dampingcoefficient if mucosamasses are closed
%      cetaz_o       :         dampingcoefficient if vocalis and mucosa have no contact
%      cetaz_c       :         dampingcoefficient if vocalis and mucosa have contact
%      cetatxv       :         dampingcoefficient of longitudinal vocalissprings
%                              (x-direction)
%      cetatzv       :         dampingcoefficient of longitudinal vocalissprings
%                              (z-direction)
%      cetatxm       :         dampingcoefficient of longitudinal mucosasprings
%                              (x-direction)
%      cetatzm       :         dampingcoefficient of longitudinal mucosasprings
%                              (z-direction)
%
%       
%
%-------------------------------------------------------------------------


% read foldsig input flags ----------------------------------------------

PMON          = Infold.flags.PMON;
VOC           = Infold.flags.VOC;
SUB           = Infold.flags.SUB;
ALONE         = Infold.flags.ALONE;               % 1: vector output 0: single value

% set register factors --------------------------------------------------
if Infold.register == 1   % MODAL
    mvfac2 = 1;
    mmfac2 = 1;
    taufac = 1;
    tvfac  = 1;
    tmfac  = 1;
    lgfac  = 1;
elseif Infold.register == 2 % HEAD
    mvfac2 = 0.1;
    mmfac2 = 0.1;
    taufac = 0.1;
    tvfac  = 0.1;
    tmfac  = 2;
    lgfac  = 1;
elseif Infold.register == 3 % FALSETT
    mvfac2 = 0.1;
    mmfac2 = 0.1;
    taufac = 0.1;
    tvfac  = 0.1;
    tmfac  = 2;
    lgfac  = 2/3;
elseif Infold.register == 0 % File
    mvfac2 = 1;
    mmfac2 = 1;
    taufac = 1;
    tvfac  = 1;
    tmfac  = 1;
    lgfac  = 1;
else
    error('Select a valid register')
end

sizefac = size(Infold.lmmfac,2);
if MAXM > sizefac
    for idx = sizefac+1:MAXM
        Infold.lmmfac(1,idx) = 1;
        Infold.rmmfac(1,idx) = 1;
        Infold.lmvfac(1,idx) = 1;
        Infold.rmvfac(1,idx) = 1;
    end
else
    %MAXM = sizefac;
end

% read foldsig inputparameters ------------------------------------------

calctime    = Infold.calctime;
k           = Infold.k;             % not known use in grstuff
ptg         = Infold.ptg;
k1          = Infold.k1;            % spring stiffness between fold and mucosa
k2          = Infold.k2;            % spring stiffness between fold and boundary

w0(1,1)      = Infold.w0lp(1)./1e6;
w0(2,1)      = Infold.w0rp(1)./1e6;
wmax(1,1)    = abs(Infold.wmaxla(1)./1e6);
wmax(2,1)    = abs(Infold.wmaxra(1)./1e6);

tvakt         = Infold.tvakt*1000;  % * tvfac !!!!!Nachfragen!!!!!!!!!!!
rvoc          = Infold.rvoc;
rtrach        = Infold.rtrach;
pin_gl_ac     = Infold.pin_gl_ac;
ps_gl_ac      = Infold.ps_gl_ac;
pin           = Infold.pin;
ps            = Infold.ps;

%-------------------------------------------------------------------------

% geometrical parameters -------------------------------------------------

lg = lgfac*Infold.vflength/1000;                 %m%mo:
a  = lg/MAXM;                                    %m

lmv = Infold.lmvfac.*mvfac2.*(thl*dl*a+thv*dv*a)*rho_v;       %kg
rmv = Infold.rmvfac.*mvfac2.*(thl*dl*a+thv*dv*a)*rho_v;       %kg
lmm = Infold.lmmfac.*mvfac2.*thm*dm*a*rho_m;                  %kg
rmm = Infold.rmmfac.*mvfac2.*thm*dm*a*rho_m;                  %kg

% lmm(7) = lmm(7) * 8; %make a konstant nodule...

% stress constant in N/m^2 ----------------------------------------------

taul = taufac*350000;


% springconstants in N/m ------------------------------------------------

k1x = k1;
k1z = k1;
k2x = k2;
k2z = k2;


% springcharacteristics of contactsprings --------------------------------

kcxv = 3*k2x;                              %N/m
kcxm = 0.125;                              %N/m
kczv = 3*k1z;                              %N/m
kczm = 3*k1z;                              %N/m

% connection areas and input impedances ----------------------------------

sum_as     = pi*rtrach^2;
sum_avoc   = pi*rvoc^2;
z_sub_1    = rho*c./sum_as;
z_voc_1    = rho*c/sum_avoc;

% Restpositions (Interpolation)-----------------------------------
w0g=interpvf(w0,wmax,MAXM,a,lg,Infold.w0lp,Infold.wmaxla,Infold.w0rp,Infold.wmaxra);

% fixing in y-direction -------------------------------------------------

x0v0        = w0g(:,1)    + dv/2;
x0m0        = w0g(:,1)    + dm/2;
x0vmaxmp1   = w0g(:,MAXM) + dv/2;
x0mmaxmp1   = w0g(:,MAXM) + dm/2;

% restpositions of the masses -------------------------------------------

x0v  = (w0g + dv/2);                       %m
x0m  = (w0g + dm/2)+0.0000000001;                       %m
x0vm = x0v - (dv - dm)/2;                  %m


% reading again foldsig input parameters for z direction------------------
w0(1,1)       = Infold.w0lp(3)./1e6;
w0(2,1)       = Infold.w0rp(3)./1e6;
wmax(1,1)     = Infold.wmaxla(3)./1e6;
wmax(2,1)     = Infold.wmaxra(3)./1e6;


z0v  = w0g;                        %m
z0m  = z0v + (thm + thv) / 2;      %m


% nearest neighbour distances at restposition ---------------------------
r0m(1,1) = sqrt((x0m(1,1) - x0m0(1,1))^2 + (z0m(1,1) - z0m0(1,1))^2 + a^2);
r0m(2,1) = sqrt((x0m(2,1) - x0m0(2,1))^2 + (z0m(2,1) - z0m0(1,2))^2 + a^2);
r0v(1,1) = sqrt((x0v(1,1) - x0v0(1,1))^2 + (z0v(1,1) - z0v0(1,1))^2 + a^2);
r0v(2,1) = sqrt((x0v(2,1) - x0v0(2,1))^2 + (z0v(2,1) - z0v0(1,2))^2 + a^2);

if MAXM > 1
    for i = 1:2
        for j = 2:MAXM
            r0m(i,j) = sqrt((x0m(i,j) - x0m(i,j))^2 + (z0m(i,j) - z0m(i,j))^2 + a^2);
            r0v(i,j) = sqrt((x0v(i,j) - x0v(i,j))^2 + (z0v(i,j) - z0v(i,j))^2 + a^2);
        end
    end
end
for j = 1:2
    r0m(j,MAXM+1) = sqrt((x0mmaxmp1(j,1) - x0m(j,MAXM))^2 + (z0mmaxmp1(1,j) - z0m(j,MAXM))^2 + a^2);
    r0v(j,MAXM+1) = sqrt((x0vmaxmp1(j,1) - x0v(j,MAXM))^2 + (z0vmaxmp1(1,j) - z0v(j,MAXM))^2 + a^2);
end

% damping coefficients --------------------------------------------------
%!!!!!!!!!!!!!
% can be changed----------
cetav_o = 0.2 * ones(2,MAXM);
cetam_o = 0.4 * ones(2,MAXM);
cetav_c = ones(2,MAXM);
cetam_c = ones(2,MAXM);
%------------------------

cetaz_o = 0.2 * ones(2,MAXM);
cetaz_c = ones(2,MAXM);
cetatxv = 0.2 * ones(2,MAXM+1);
cetatzv = 0.1 * ones(2,MAXM+1);
cetatxm = 0.4 * ones(2,MAXM+1);
cetatzm = 0.1 * ones(2,MAXM+1);



% Frickelfaktor nach Titze : "Parameterization of glottal area ... ", 1983
% JASA 75(2), S. 570-580
% kt = 1.1;
