function [tubes] = radiusconvert(radius,spacing,newradius);
% this function converts the old radius-format to the new one
% 08.30.00 Daniel Riemann


if nargin ~= 3
   error('Wrong number of input arguments');
end;

lcyl(1) = ((newradius(2)-newradius(1))*spacing) + spacing;
rl(1) = radius(1);
rr(1) = radius(newradius(2));
i = 2;
nextradius = 0;
for n = 2:length(newradius)-1
   if ((newradius(n+1) - newradius(n)) > 1) | (nextradius == 1)
      if nextradius == 0
         lcyl(i) = (newradius(n+1)-newradius(n))*spacing;
      else
         lcyl(i) = (newradius(n+1)-newradius(n-1))*spacing;
      end;
      rl(i) = radius(newradius(n));
      rr(i) = radius(newradius(n+1));
      i = i+1;
      nextradius = 0;
   else nextradius = 1;
   end;
end;

tubes = [lcyl; rl; rr]';