function [y_out, bqs] = pistonfilt(y_in, bqs, sos, g)

% bqs = biquadstate

for step = 1:size(sos,1)
   bqs(step,3) = bqs(step,2);
   bqs(step,2) = bqs(step,1);
   bqs(step,1) = g * y_in ...
      - bqs(step,3) * sos(step,6) ...
      - bqs(step,2) * sos(step,5);

   y_in        = bqs(step,1) ...
      + bqs(step,3) * sos(step,3) ...
      + bqs(step,2) * sos(step,2);
end
y_out = y_in;


%  [h,w] = freqz(b,a,128);
%  save kolben1
%else
%  load kolben1
%end
%figure(822);
%plot(fy*fmax,my,'-k',w/pi*fmax,abs(h),':k')
%data.yf = filter(b,a,data.y);
%soundsc(data.y, data.Fs);
%pause(1)
%soundsc(data.yf, data.Fs);
%set(Hndl.figureNumber,'UserData',data);