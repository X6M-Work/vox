%calculation of pressures acting on the vocalis- and mucosamass because of
%the flow through the glottis
%
% input:
%
%                VOC                        :                Flag indicating if vocal tract is considered in calculation
%                SUB                        :                Flag indicating if subglottal resonator is considered in calculation
%                ps0                        :                subglottal pressure (lungpressure)
%
%        from params.m
%
%                as                         :                area of first subglottal resonator segment
%                z_sub_1                    :                input impedance of first subglottal segment
%                z_voc_1                    :                input impedance of first vocal tract segment
%                u_min_voc                  :                reflected flow from vocal tract into the glottis
%                u_plus_sub                 :                reflected flow from subglottal resonator into the glottis
%
%        from flow.m
%
%                u_plus_voc                 :                flow into the vocal tract
%                u_min_sub                  :                flow back into the subglottal resonator
%
%        from glotpar.m
%
%                vc                                :                1 if the glottis is closed at the vocalis-masses
%                                                                0 else
%                mc                                :                1 if the glottis is closed at the mucosa-masses
%                                                                0 else
%                av                                :                glottal area between the corresponding vocalis-masses
%                am                                :                glottal area between the corresponding mucosa-masses
%                ke                                :                pressure recovery coefficient
%
%
% output:
%
%                pv                                :                pressure on the vocalismasses in N/m^2
%                pm                                :                pressure on the mucosamasses in N/m^2
%                ps                                :                total subglottal pressure
%                pin                               :                total supraglottal pressure
%
%
% used files:
%
%                --
%
%
%------------------------------------------------------------------------

pin = psup;
ps  = psub;

%ke = 0;
%avn = av(find(av~=0));
%aminn = amin(find(amin~=0));
for i =1:MAXM
   if vc(i)==1 % vocalis mass area is zero
      pv(i) = 0;
      pm(i) = not(mc(i)) * pin;
   elseif mc(i)==1 % mucosa mass area is zero
      pv(i) = not(vc(i)) * ps;
      pm(i) = 0;
   elseif am(i) < av(i) % convergent segment
      if (av(i)==0 | amin(i)==0 | as0(i) == 0)
         pv(i) = 0;
         pm(i) = pin;
      else
         pv(i) = ps - (ps - pin) * ...
            (1/av(i)^2 - 1/as0(i)^2) / ((1-ke)/amin(i)^2 - 1/as0(i)^2); % Nils A. corrected
         pm(i) = pin;
      end
   elseif (av(i)==0 | amin(i)==0 | as0(i) == 0 ) % divergent segment
      pv(i) = 0;
      pm(i) = pin;
   else
      pv(i) = ps - (ps - pin) * ...
         (1/av(i)^2 - 1/as0(i)^2) / ((1-ke)/amin(i)^2 - 1/as0(i)^2); % Nils A. corrected
      pm(i) = pin;
   end
end

% total subglottal pressure ---------------------------------------------
%%%ps = SUB*ps_gl_ac + ps0;	%N/m^2 sublottal bernoulli pressure always constant (correct)
%%%pinak = VOC*pin_gl_ac + sum_u*z_voc_1;                        %N/m^2
%%%pin = VOC*pin_gl_ac;
ps    = ps0;	%N/m^2 sublottal bernoulli pressure always constant (correct)
pinak = sum_u*z_voc_1;                        %N/m^2
pin   = 0;

Infold.pin = pin;
Infold.ps  = ps;
%ke
%sum(amin0)%-sum(as0)
