% initialisation of vocal fold constants
% inifold.m
%
% input:
%
%	--
%
% output:
%
%		xv			:			x-component of the vocalis startposition
%		xm			:			x-component of the mucosa startposition
%		xvm		    :			x-component of the vocalis-mucosa-fixpoint
%		zv			:			z-component of the vocalis startposition
%		zm			:			z-component of the mucosa startposition
%		x_1		    :			x-positions of masses one timestep ago
%		z_1		    :			z-positions of masses one timestep ago
%		T			:			Timestep
%		num_it	    :			number of iterations for calculation
%		u			:			flow through the glottis
%
%
%-------------------------------------------------------------------------

% startpositions of the masses ------------------------------------------

xv  = x0v;											%m
xm  = x0m;											%m
xvm = x0vm;											%m
zv  = z0v;											%m
zm  = z0m;											%m


% initialisation of mass history ----------------------------------------
x_1 = [xv xm];										%m
z_1 = [zv zm];


%flow initialisation ----------------------------------------------------

u          = 0;
Infold.pin = 0;
Infold.ps  = 0;

%-----------------------------------------------------------------------