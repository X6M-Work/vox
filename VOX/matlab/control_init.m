% Initialisation file for vox
%
PARFOLD  = [];  % Initialisation of Vocal Fold Parameters
PARTRACT = [];  % Initialisation of Vocal Tract Stairs Parameters
PARCTIM  = [];  % Initialisation of Vocal Fold CTIM2 Parameters
Infold.pin_gl_ac = 0;  % load of VF by vocal tract, later from "tractsig"
Infold.ps_gl_ac  = 0;

% stand alone calculation disabled --------
Infold.flags.ALONE = 0;

%coupling of vocal folds to tract and trachea
%Infold.flags.VOC = 0.1*TRACT;   % Frickelfactor 0.1*boolean; 1 is too much!
Infold.flags.VOC = TRACT;   % Frickelfactor 0.1*boolean; 1 is too much!
Infold.flags.SUB = TRACH;   % no trachea taken into account
%Infold.pin_gl_ac = 0; % = pin- load of vocal folds by vocaltract
%Infold.ps_gl_ac  = 0;   % = ps+  load of vocal folds by lung

% set graphicflags --------
%Infold.flags.PMON    = 1;

% set registerflag --------
%Infold.flags.reg.MODAL   = MODAL;
%Infold.flags.reg.HEAD    = HEAD;
%Infold.flags.reg.FALSETT = FALSETT;



%=====================================================
% define Vocal Tract parameters
%vowelname = get(Hndl.VOWEL,'String');
%vowelname = vowelname(get(Hndl.VOWEL,'value'),2:3);

%=====================================================
% define noise damping parameter
%PARNOISE.dampdB = DAMPDB;
