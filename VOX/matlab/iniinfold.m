% set some fold parameters
Infold.maxm     = MAXM;
Infold.k        = 1;
Infold.lmvfac   = ones(1,MAXM);
Infold.rmvfac   = ones(1,MAXM);
Infold.lmmfac   = ones(1,MAXM);
Infold.rmmfac   = ones(1,MAXM);
Infold.lmmsfac  = ones(1,MAXM);
Infold.rmmsfac  = ones(1,MAXM);
Infold.lmbsfac  = ones(1,MAXM);
Infold.rmbsfac  = ones(1,MAXM);
Infold.xmax     = 20;

%Offset for the x-component of the masses
Infold.lmoffset = zeros(1,MAXM);
Infold.lvoffset = zeros(1,MAXM);
Infold.rmoffset = zeros(1,MAXM);
Infold.rvoffset = zeros(1,MAXM);

% if no interaction:
Infold.rvoc   		= rvocdefault/1000; % default input radius of vocal tract
Infold.rtrach 		= rtrachdefault/1000;	% default input radius of trachea
Infold.flags.VOC	= TRACT; 			% to be CHANGED?
Infold.flags.SUB 	= TRACH;
Infold.pin_gl_ac 	= 0;    % "Load" of vocal folds by vocal tract, see above.
Infold.ps_gl_ac  	= 0;    % "Load" of vocal folds by lung
Infold.pin        = 0;
Infold.ps         = 0;

% set Graphicflags ----------
Infold.flags.GRON = GRON;
Infold.flags.PMON = 1;

% set registerflag ----------
Infold.register = 1;		% 1: Modal, 2: Head, 3: Falsett
Infold.flags.ALONE = 1;   % 1: standalone execution of loop

% set VF shape
Infold.shape = 1;

foldmod('defaults');