% vocal fold constants
% foldcons.m
%
%
% input:
%
%	--
%
% output:
%
%		thl			:			thickness of ligamentum
%		thv			:			thickness of vocalismass
%		thm			:			thickness of mucosamass
%		dl			:			depth of ligamentum
%		dv			:			depth of vocalis
%		dm			:			depth of mucosa
%		wc			:			critical width of folds
%		rho_v		:			vocalis density
%		rho_m		:			mucosa density
%		slmax		:			maximum ligamentum strain
%		eta_kcxv	:			factor of nonlinearity for the vocalis-contactspring
%										in x-direction
%		eta_kcxm	:			factor of nonlinearity for the mucosa-contactspring
%										in x-direction
%		eta_kczv	:			factor of nonlinearity for the vocalis-mucosa-contactspring
%										in x-direction
%		eta_kczm	:			same as eta_kczm
%		eta_k1x		:			factor of nonlinearity for the vocalis-mucosa-spring k1
%										in x-direction
%		eta_k1z		:			factor of nonlinearity for the vocalis-mucosa-spring k1
%										in z-direction
%		eta_k2x		:			factor of nonlinearity for the vocalis-boundary-spring k2
%										in x-direction
%		eta_k2z		:			factor of nonlinearity for the vocalis-boundary-spring k2
%										in z-direction
%		z0v0		:			z-component of the front-fixing of the vocalis in y-direction
%		z0vmaxmp1	:			z-component of the end-fixing of the vocalis in y-direction
%		z0m0		:			z-component of the front-fixing of the mucosa in y-direction
%		z0mmaxmp1	:			z-component of the end-fixing of the mucosa in y-direction
%
%-------------------------------------------------------------------------


% geometrical constants --------------------------------------------------
% downstream dimensions (z)
thl = 0.001;									% ligamentum thickness [m]
thv = 0.0025;									% vocalis thickness [m]
thm = 0.0005;									% mucosa thickness [m]

% lateral dimension (x)
dl = 0.001;										% ligamentum depth [m]
dv = 0.0025;									% vocalis depth [m]
dm = 0.001;										% mucosa depth [m]

wc = 0;											% m


% mass constants --------------------------------------------------------

rho_v = 1.04e3;								% vocalis density [kg/m^3]
rho_m = 1.02e3;								% mucosa density [kg/m^3]

% fixing in y-direction -------------------------------------------------

z0v0(1:2) 		 =  0;					%m
z0m0(1:2) 		 = (thm + thv) / 2;	%m
z0vmaxmp1(1:2)  = 0;						%m
z0mmaxmp1(1:2)  = (thm + thv) / 2;	%m


% nonlinearity of springs -----------------------------------------------

eta_k1x(1:2)  = 100e4;							%1/m^2
eta_k1z(1:2)  = 100e4;							%1/m^2
eta_k2x(1:2)  = 100e4;							%1/m^2
eta_k2z(1:2)  = 100e4;							%1/m^2
eta_kcxv(1:2) = 500e4;							%1/m^2
eta_kcxm(1:2) = 500e4;							%1/m^2
eta_kczv(1:2) = 500e4;							%1/m^2
eta_kczm(1:2) = 500e4;							%1/m^2


% maximum ligamentum ----------------------------------------------------

slmax = 0.3;

