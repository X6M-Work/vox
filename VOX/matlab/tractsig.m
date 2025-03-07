function [p_out_mouth, pin_gl_ac, PARTRACT] = ...
   tractsig(ii, PARTRACT, glotarea, out_vf_voc, PARNOISE);

% TRACTSIG calculates the behaviour of the human vocal
% tract for various vowels
% TRACTSIG uses the recursive pressure calculation described in Barjau,
% JASA Vol.105, No.3, Mar.1999, p.1951-1964, especially ec.(8) on p.1956.
%
% Copyright (c) September 1999 by Ulrich Reiter
% last modified 29.6.2000 and 4.11.2000 by Malte Kob
%
% output:	p_out_mouth		pressure at mouth
%					p_out_mouth		pressure at glottis
%         pin_gl_ac     pressure into glottis
%         PARTRACT      struct containing pressure values and
%                       geometrical coefficients
%
% input:	ii            calculation step
%         PARTRACT      struct containing pressure values and
%                       geometrical coefficients
%         	(vowel      number of vowel to be calculated) modified by Daniel Riemann
%         	vowelname   name of vowel to be calculated  end of modification 18.01.2000
%         glotarea      opening area of the glottis, calculated by Nils
%         out_vf_voc    vocal fold out, calculated by Nils (foldsig.m)
%					PARNOISE			struct with data from noisesig

global c GRONT Hndl Xi0 radimproutine

if ~isstruct(PARTRACT)
   [Bm, Bp, a32, Teta32, A32, rvoc, numcyl, lastj, lastp2,...
      damp, pmr2, ppl2, pmR, pmT, ppR, ppT, zmR, ...
      p_out_mouth, Rm] = initract;
   PARTRACT.geom.Bm 			= Bm;
   PARTRACT.geom.Bp 			= Bp;
   PARTRACT.geom.a32 		= a32;
   PARTRACT.geom.Teta32 	= Teta32;
   PARTRACT.geom.A32 		= A32;
   PARTRACT.geom.numcyl 	= numcyl;
   PARTRACT.geom.lastj 	= lastj;
   PARTRACT.geom.lastp2 	= lastp2;
   PARTRACT.geom.rvoc 		= rvoc;
   PARTRACT.geom.Rm 			= Rm;
   PARTRACT.press.damp 	= damp;
   PARTRACT.press.pmr2 	= pmr2;
   PARTRACT.press.ppl2 	= ppl2;
   PARTRACT.press.pmR 		= pmR;
   PARTRACT.press.pmT 		= pmT;
   PARTRACT.press.ppR 		= ppR;
   PARTRACT.press.ppT 		= ppT;
   PARTRACT.press.zmR 		= zmR;
   vocarea = pi*(rvoc^2);
   pmr2.junction(1).time(1) = out_vf_voc*2*glotarea/(vocarea+glotarea);
else
   Bm 			= PARTRACT.geom.Bm;
   Bp 			= PARTRACT.geom.Bp;
   a32 		= PARTRACT.geom.a32;
   Teta32 	= PARTRACT.geom.Teta32;
   A32 		= PARTRACT.geom.A32;
   numcyl 	= PARTRACT.geom.numcyl;
   lastj 	= PARTRACT.geom.lastj;
   lastp2	= PARTRACT.geom.lastp2;
   rvoc 		= PARTRACT.geom.rvoc;
   Rm			= PARTRACT.geom.Rm;
   damp 		= PARTRACT.press.damp;
   pmr2 		= PARTRACT.press.pmr2;
   ppl2 		= PARTRACT.press.ppl2;
   pmR 		= PARTRACT.press.pmR;
   pmT 		= PARTRACT.press.pmT;
   ppR 		= PARTRACT.press.ppR;
   ppT 		= PARTRACT.press.ppT;
   zmR 		= PARTRACT.press.zmR;
   data=get(Hndl.figureNumber, 'UserData');
   radius = data.radius;
   dist = data.spacing;
   numcyl=length(radius);		% number of cylinders constituting the VT model
   lastj=numcyl+1;					% index of last junction (=output end)
   c0 = c;							% sound speed in air [m/s], GLOBAL!
   Fs = round(c0/dist);					% sampling frequency
   dx=c0/Fs;							% path increment [m]
   dt=1/Fs;							% time increment [s]
   damp=1-Xi0;
   nuem=zeros(1,numcyl-1);		% reflection coefficient
   nuep=zeros(1,numcyl-1);		% refl. coeff. for backwards travelling waves
   lcyld=ones(1,numcyl);
   lcyl=lcyld*dist;
   lsum=sum(lcyl);					% total length of vocal tract
   n=round(lsum/dx);				% total number of samples
   nspc=round(lcyl*n/lsum);		% number of samplepoints within each cylinder
   rl=radius;
   rr=rl;
   for i=2:numcyl
      Bm(i)=(rr(i-1)/rl(i))^2;	% Sout/Sin
   end
   Bm(1)=1;	% dummy value for division in next line
   Bp=1./Bm;
   a=-c0/(2*rr(numcyl));
   a32=a;
   b3=a;
   Teta32=[exp(b3*dt)];			% matrix Teta for output end
   TT21=((b3*dt-1)+exp(-b3*dt))/(dt*b3^2);	% 2nd row, 1st col.
   TT22=(1-(1+b3*dt)*exp(-b3*dt))/(dt*b3^2);
   TetaT32=[TT21 TT22];			% matrix	TetaTilde for output end
   A32=Teta32*TetaT32;			% matrix A (1 row, 2 columns) for output end
   rvoc = radius(1);
end
vocarea = pi*(rvoc^2);
Bglotm 	= glotarea/vocarea;    % area ratio at node glottis->VT (outgoing wave)
if glotarea == 0
   Bglotp = 1e10;
else
   Bglotp 	= 1/Bglotm;            % area ratio at node VT->glottis (ingoing wave)
end;
T1m 		= 2*glotarea/(vocarea+glotarea);

% start of calculus routine----------------------------------------------------

pmr2.junction(1).time(1) = ppR.junction(1).time(1) + out_vf_voc*T1m;
%pmr2.junction(1).time(1) = out_vf_voc;

% reflection and transmission of outgoing wave at input end (glottis)
pmR.junction(1).time(1) = out_vf_voc*(Bglotm-1)/(Bglotm+1);
pmT.junction(1).time(1) = pmR.junction(1).time(1) + out_vf_voc;

% add noise
pmT.junction(1).time(1) = pmT.junction(1).time(1) + PARNOISE.out(1);

% reflection and transmission of outgoing wave
for i=2:numcyl
   pmR.junction(i).time(1)=pmr2.junction(i-1).time(1)*...
      (Bm(i)-1)/(Bm(i)+1);          % reflected part of pmr2
   pmT.junction(i).time(1)=pmR.junction(i).time(1)+...
      pmr2.junction(i-1).time(1);   % transmitted part of pmr2

   % add noise
   pmT.junction(i).time(1)= pmT.junction(i).time(1) + PARNOISE.out(i);
end
% reflection of outgoing wave at output end; see Barjau ec.(8), p.1956
% zmR = z(t+dt)
% pmR = p_sub(F)(t+dt)
if radimproutine == 1
   zmR.junction(lastj).time(1) = ...
      zmR.junction(lastj).time(2)*Teta32 ...
      + A32(1)*pmr2.junction(numcyl).time(2) ...
      + A32(2)*pmr2.junction(numcyl).time(1);
   pmR.junction(lastj).time(1) = a32*zmR.junction(lastj).time(1);

   p_out_mouth = ...
      pmR.junction(lastj).time(1)...
      + pmr2.junction(lastj-1).time(1);
   %p_out_mouth(lastj)= -pmR.junction(lastj).time(1);
elseif radimproutine == 2
   Rm.state(:,2) ...
      = Rm.A*Rm.state(:,1) ...
      + Rm.B*pmr2.junction(numcyl).time(1);
   pmR.junction(lastj).time(1) ...
      = Rm.C*Rm.state(:,1) ...
      + Rm.D*pmr2.junction(numcyl).time(1);
   Rm.state(:,1) = Rm.state(:,2);
   %	pmR.junction(lastj).time(1) ...
   %		= pmr2.junction(numcyl).time(1)	* R;
   p_out_mouth ...
      = pmR.junction(lastj).time(1)...
      + pmr2.junction(lastj-1).time(1);
end

% reflection and transmission of ingoing wave
for i=numcyl:-1:2
   ppR.junction(i).time(1)=ppl2.junction(i+1).time(1)*...
      (Bp(i)-1)/(Bp(i)+1);          % reflected part of ppl2
   ppT.junction(i).time(1)=ppR.junction(i).time(1)+...
      ppl2.junction(i+1).time(1);   % transmitted part of ppl2
end

% reflection and transmission of ingoing wave at input end (glottis)
% ppR.junction(1).time(1) = ppl2.junction(2).time(1)*(Bglotp-1)/(Bglotp+1); % should be valid
ppR.junction(1).time(1) = ppl2.junction(2).time(1); % modified to match voctract (D)!	% should be erased
% ppT.junction(1).time(1) = ppR.junction(1).time(1)+ppl2.junction(2).time(1); % not in voctract! % should be valid

% pressure reflected to glottis
%p_out_glottis = ppR.junction(1).time(1);

% timeshift of outgoing and ingoing waves
for i=1:numcyl
   pmr2.junction(i).time(2:lastp2(i))=...
      pmr2.junction(i).time(1:lastp2(i)-1);
   ppl2.junction(i+1).time(2:lastp2(i))=...
      ppl2.junction(i+1).time(1:lastp2(i)-1);
end
zmR.junction(lastj).time(2)=zmR.junction(lastj).time(1);
% end of timeshift

% newest element of outgoing wave (incl. from glottis = from Nils)
%for i=1:numcyl
for i=2:numcyl % modified to match voctract (E)
   pmr2.junction(i).time(1)=ppR.junction(i).time(1)+...
      pmT.junction(i).time(1);
   pmr2.junction(i).time(1)=damp*pmr2.junction(i).time(1);
end
pmr2.junction(1).time(1)=ppR.junction(1).time(1); % line added to match voctract (E)
pmr2.junction(1).time(1)=damp*pmr2.junction(1).time(1); % line added to match voctract (E)

% newest element of ingoing wave
ppl2.junction(lastj).time(1)=pmR.junction(lastj).time(1);
for i=numcyl:-1:2
   ppl2.junction(i).time(1)=pmR.junction(i).time(1)+...
      ppT.junction(i).time(1);
   ppl2.junction(i).time(1)=damp*ppl2.junction(i).time(1);
end

% newest element of ingoing wave into vocal folds (to Nils)
pin_gl_ac = pmR.junction(1).time(1)+ppT.junction(1).time(1);

% for i=1:numcyl;
%   dudu1(i) = pmr2.junction(i).time(1);		% wave runs downstream
%   dudu2(i) = ppl2.junction(i+1).time(1);	% wave runs upstream
%   p_out_mouth(i) = ...
%     dudu1(i)+dudu2(i);
% end
%p_out_mouth(i) = pmr2.junction(numcyl).time(1)
%               + ppl2.junction(numcyl+1).time(1);

% if (GRONT == 2) | (GRONT == 3)
%   mdudu=max(max(abs([dudu1;dudu2;p_out_mouth(1:numcyl)])));
% 	if figflag('Sound pressure in the vocal tract',1) == 1
% 	  plot(1:lastj, [dudu1 pmr2.junction(lastj-1).time(1)], 'r-', ...
%  	   	1:lastj, [dudu2 pmR.junction(lastj).time(1)],    		'b-', ...
%   	  1:lastj, p_out_mouth,		'k-', ...
%       1:lastj, [PARNOISE.out; 0]', 'g-', ...
% 			'Parent', Hndl.tractsigfigplot);
% 	else
% 		Hndl.tractsigfig = figure('visible','on','NumberTitle','off', ...
% 					'Name','Sound pressure in the vocal tract','Units','normalized',...
% 					'Position',[.5 .05 .5 .4]);
% 		set(Hndl.tractsigfig,'MenuBar', 'none');
% 	  Hndl.tractsigfigplot = axes;
% 		plot(1:lastj, [dudu1 pmr2.junction(lastj-1).time(1)], 'r-', ...
%  	   	1:lastj, [dudu2 pmR.junction(lastj).time(1)],    		'b-', ...
%   	  1:lastj, p_out_mouth,       												'k-');
% 	end
% grid on
% axis([-inf inf -mdudu mdudu]);
% axis([-inf inf -1 1]);
%end
PARTRACT.geom.Bm = Bm;
PARTRACT.geom.Bp = Bp;
PARTRACT.geom.a32 = a32;
PARTRACT.geom.Teta32 = Teta32;
PARTRACT.geom.A32 = A32;
PARTRACT.geom.numcyl = numcyl;
PARTRACT.geom.lastj = lastj;
PARTRACT.geom.lastp2 = lastp2;
PARTRACT.geom.rvoc = sqrt(vocarea/pi);
PARTRACT.press.damp = damp;
PARTRACT.press.pmr2 = pmr2;
PARTRACT.press.ppl2 = ppl2;
PARTRACT.press.pmR = pmR;
PARTRACT.press.pmT = pmT;
PARTRACT.press.ppR = ppR;
PARTRACT.press.ppT = ppT;
PARTRACT.press.zmR = zmR;