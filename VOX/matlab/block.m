function [out]=block(in,updownflag);

% zeropadding or truncation of input vector towards 2^n blocklength
s = size(in);
if s(1) > s(2)	% less columns than rows
   in=in';			% turn vectors
end;
if nargin <1
   error('no input given!');
elseif nargin < 2
   updownflag = 0;
end;
if updownflag == 0
   maxexp = floor(log2(max(s)));
   out=in(:,1:2.^maxexp);
elseif updownflag == 1
   maxexp = ceil(log2(size(in,2)));
   %  out=zeros(size(in));
   %  out=[in(:,:) zeros(2.^maxexp-size(in,1),size(in,2)];
   for rows = 1:size(in,1)
      out(rows,:)=[in(rows,:) zeros(1,2.^maxexp-size(in,2))];
   end;
end;
if s(1) > s(2)
   out=out';	% turn back the vectors
end;
out;