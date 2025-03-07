% initinate vocal tract properties
function datainit(maxsegments, maxdevlimit,
XI, Xi0)

global Hndl

try
   data = get(Hndl.figureNumber,'Userdata');
end
data.properties.value       = get(Hndl.VOWEL,'value');
[data.radius, data.spacing] = areadata(data.properties.value);
initractcalcmode            = get(Hndl.TractCalcMode,'value');
if initractcalcmode == 1	% stairs
   damp = Xi0;
else											% tubes
   damp = XI;
end;
data.properties.damping     = damp; % default 0.135 for ctim2;
data.properties.maxdevlimit = maxdevlimit;
data.properties.maxsegments = maxsegments;
data.properties.color       = 1;
data.properties.mode        = initractmode;


set(Hndl.figureNumber,'Userdata',data);