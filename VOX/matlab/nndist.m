% calculate nearest neighbour distances
%-------------------------------------------------------------------------
%nndist.m
%
%
%
% input:
%
%		xv				:			x-component of the vocalisposition
%		xm				:			x-component of the mucosaposition
%		zv				:			z-component of the vocalisposition
%		zm				:			z-component of the mucosaposition
%       a               :           y-component of the mucosa and the vocalisposition
%
%
%	from params.m
%
%		x0v0			:			x-component of the front-fixing of the vocalis in y-direction
%		x0vmaxmp1	:			x-component of the end-fixing of the vocalis in y-direction
%		x0m0			:			x-component of the front-fixing of the mucosa in y-direction
%		x0mmaxmp1	:			x-component of the end-fixing of the mucosa in y-direction
%
%	from inifold.m
%
%		z0v0			:			z-component of the front-fixing of the vocalis in y-direction
%		z0vmaxmp1	:			z-component of the end-fixing of the vocalis in y-direction
%		z0m0			:			z-component of the front-fixing of the mucosa in y-direction
%		z0mmaxmp1	:			z-component of the end-fixing of the mucosa in y-direction
%
%
%
% output:
%
%		rm				:			distance between neighbour mucosamasses
%		rv				:			distance between neighbour vocalismasses
%
%
% used files:
%
%		--
%
%------------------------------------------------------------------------

r0m(1,1) = sqrt((x0m(1,1) - x0m0(1,1))^2 + (z0m(1,1) - z0m0(1,1))^2 + a^2);
r0m(2,1) = sqrt((x0m(2,1) - x0m0(2,1))^2 + (z0m(2,1) - z0m0(1,2))^2 + a^2);
r0v(1,1) = sqrt((x0v(1,1) - x0v0(1,1))^2 + (z0v(1,1) - z0v0(1,1))^2 + a^2);
r0v(2,1) = sqrt((x0v(2,1) - x0v0(2,1))^2 + (z0v(2,1) - z0v0(1,2))^2 + a^2);
%rm(:,1) = sqrt((xm(:,1) - x0m0)^2 + (zm(:,1) - z0m0)^2 + a^2);
%rv(:,1) = sqrt((xv(:,1) - x0v0)^2 + (zv(:,1) - z0v0)^2 + a^2);
rm(1,1) = sqrt((xm(1,1) - x0m0(1,1))^2 + (zm(1,1) - z0m0(1,1))^2 + a^2);
rm(2,1) = sqrt((xm(2,1) - x0m0(2,1))^2 + (zm(2,1) - z0m0(1,2))^2 + a^2);
rv(1,1) = sqrt((xv(1,1) - x0v0(1,1))^2 + (zv(1,1) - z0v0(1,1))^2 + a^2);
rv(2,1) = sqrt((xv(2,1) - x0v0(2,1))^2 + (zv(2,1) - z0v0(1,2))^2 + a^2);
if MAXM > 1
   for i = 1:2
      for j = 2:MAXM
         rm(i,j) = sqrt((xm(i,j) - xm(i,j-1))^2 + (zm(i,j) - zm(i,j-1))^2 + a^2);
         rv(i,j) = sqrt((xv(i,j) - xv(i,j-1))^2 + (zv(i,j) - zv(i,j-1))^2 + a^2);
      end
   end
end

for j = 1:2
   rm(j,MAXM+1) = sqrt((xm(j,MAXM) - x0mmaxmp1(j,1))^2 + (zm(j,MAXM) - z0mmaxmp1(1,j))^2 + a^2);
   rv(j,MAXM+1) = sqrt((xv(j,MAXM) - x0vmaxmp1(j,1))^2 + (zv(j,MAXM) - z0vmaxmp1(1,j))^2 + a^2);
end
%   r0m(j,MAXM+1) = sqrt((x0mmaxmp1(j,1) - x0m(j,MAXM))^2 + (z0mmaxmp1(1,j) - z0m(j,MAXM))^2 + a^2);
%    r0v(j,MAXM+1) = sqrt((x0vmaxmp1(j,1) - x0v(j,MAXM))^2 + (z0vmaxmp1(1,j) - z0v(j,MAXM))^2 + a^2);
%   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   rm(1) = sqrt((xm(1) - x0m0)^2 + (zm(1) - z0m0)^2 + a^2);
% rv(1) = sqrt((xv(1) - x0v0)^2 + (zv(1) - z0v0)^2 + a^2);
%
% if MAXM > 1
% 	for i = 2:MAXM
% 		rm(i) = sqrt((xm(i) - xm(i-1))^2 + (zm(i) - zm(i-1))^2 + a^2);
% 		rv(i) = sqrt((xv(i) - xv(i-1))^2 + (zv(i) - zv(i-1))^2 + a^2);
% 	end
% end
% rm(MAXM+1) = sqrt((xm(MAXM) - x0mmaxmp1)^2 + (zm(MAXM) - z0mmaxmp1)^2 + a^2);
% rv(MAXM+1) = sqrt((xv(MAXM) - x0vmaxmp1)^2 + (zv(MAXM) - z0vmaxmp1)^2 + a^2);