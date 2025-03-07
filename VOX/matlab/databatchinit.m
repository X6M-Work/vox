function data = databatchinit(data);
% initialise data for batch calculation


data.batch.modFreq = 5.5;	% modulation frequency [Hz]
data.batch.modDepth = 5;	% modulation depth [%]
data.batch.start = 80;		% start of linear ramp [%]
data.batch.stop = 110;		% end of linear ramp [%]
data.batch.seg1 = 10;			% number of segments per period
data.batch.seg2 = 100;		% number of linear segments
data.batch.periodic = 1;	% flag periodic
data.batch.linramp = 0;		% flag linear
data.batch.actstr = 1;		% flag active stress
data.batch.subpre = 0;		% flag subglottal pressure
data.batch.shift = 0;     % flag random shift
data.batch.shiftvalue = 2; % range of random shift
data.batch.trac = 0;      % flag modulation of the first 10 radius segments
data.batch.import = 0;    % flag for imported areadata
data.batch.areadata = [];
