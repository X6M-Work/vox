function [newarea, newareaintpol, outsegments, outdevlimit] ...
   = areaintpol(area, segments, devlimit);
% 08.30.00 Daniel Riemann

area=area(:)';	% after modification, area becomes a row vector!
volume 	 = sum(area);
newarea  = [];
newarea(1) = 1;
newarea(2) = length(area);
x = [1,length(area)];
newareaintpol = interp1(x,area(newarea),1:1:length(area),'*linear');
areadiff = abs(newareaintpol-area);
areadev = sum(areadiff);
maxdev = find(areadiff == max(areadiff));
if length(maxdev) > 1
   maxdev = maxdev(1);
end;
% nun die schleife:
% --------------------------------------------------------------
while (length(newarea) < segments+1) & (areadev > devlimit/100*volume);
   newpoint = find(newarea >= maxdev);
   newpoint = newpoint(1);
   % jetzt wieder interpolieren:
   x = [newarea(newpoint-1),maxdev];
   Y = [area(newarea(newpoint-1)),area(maxdev)];
   newareaintpol(newarea(newpoint-1):maxdev) ...
      = interp1(x,Y,newarea(newpoint-1):1:maxdev,'*linear');
   x = [maxdev,newarea(newpoint)];
   Y = [area(maxdev),area(newarea(newpoint))];
   newareaintpol(maxdev:newarea(newpoint)) ...
      = interp1(x,Y,maxdev:1:newarea(newpoint),'*linear');
   % newarea aktualisieren:
   newarea(length(newarea)+1) = maxdev;
   newarea = sort(newarea);
   areadiff = abs(newareaintpol-area);
   maxdev = find(areadiff == max(areadiff));
   if length(maxdev) > 1
      maxdev = maxdev(1);
   end;
   areadev = sum(areadiff);
end;
outsegments = length(newarea)-1;
outdevlimit = areadev*100/volume;