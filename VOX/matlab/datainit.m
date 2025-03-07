function datainit(maxsegments, maxdevlimit, XI, Xi0, radimproutine)

global Hndl

try
   data = get(Hndl.figureNumber,'Userdata');
end
data.properties.value       = get(Hndl.VOWEL,'value');
[data.radius, data.spacing] = areadata(data.properties.value);
data.properties.radimp			= radimproutine;
data.properties.mode        = get(Hndl.TractCalcMode,'value');
if data.properties.mode == 1
   data.properties.damping   = Xi0; % stairs
else
   data.properties.damping   = XI;  % tubes
end;
data.properties.maxdevlimit = maxdevlimit;
data.properties.maxsegments = maxsegments;
data.properties.color       = 1;
data = databatchinit(data);


set(Hndl.figureNumber,'Userdata',data);