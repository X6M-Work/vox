function pistonfilttest

global biquadstate Hndl c

init = 1;
tic
%if init
ord = 18;
data  = get(Hndl.figureNumber,'UserData');
d     = 2*data.radius(end);
Fs    = data.Fs;
fmax  = round(Fs/2);
x     = 0:1:32767;
%  d     = 0.03;
%  Fs    = 22050;
%  fmax  = Fs/2;
%  x     = 0:25:fmax;
k     = 2*pi*x/c;
warning off
f     = 1 -	2*besselj(1,k*d)./(k*d) + j*2*mstruv(k*d) ./(k*d);
warning on
%  f(isnan(f))=0;
f = 1 ./(1+j*k*d);
timef = real(ifft(f));
%  f2 = fft(timef)*1.1;
timef = [timef zeros(1,length(timef))];
hilbi = hilbert(timef);
f2 = fft(hilbi(1:length(hilbi)/2));
figure(221);plot(x,angle(f),'m-',x,angle(f2),'c-');grid on
figure(222);plot(x,abs(f),'m-',x,abs(f2),'c-');grid on

%   fy    = x/fmax;
%   my    = angle(f);
% 	R 		= angle((f - 1)./(f + 1));
% 	T 		= angle(2*f./(f + 1));
%   [b,a] = yulewalk(ord,fy,my);
%   [A,B,C,D] = tf2ss(b,a);
%   [bR,aR] = yulewalk(ord,fy,R);
%   [AR,BR,CR,DR] = tf2ss(bR,aR);
%   [bT,aT] = yulewalk(ord,fy,T);
%   [AT,BT,CT,DT] = tf2ss(bT,aT);
%   save kolben2
% else
%   load kolben2
% end
% diracvec    = [1 zeros(1, 2^7-1)];
% in  = diracvec;
% %in  = data.y;
% out  = [];
% outR = [];
% outT = [];
% statevec  = zeros(ord,2);
% statevecR = zeros(ord,2);
% statevecT = zeros(ord,2);
% for sample = 1:size(in,2)
%   statevec(:,2)  = A*statevec(:,1) + B*in(sample);
%   out(sample)    = C*statevec(:,1) + D*in(sample);
%   statevec(:,1)  = statevec(:,2);
% 	statevecR(:,2) = AR*statevecR(:,1) + BR*in(sample);
%   outR(sample)   = CR*statevecR(:,1) + DR*in(sample);
%   statevecR(:,1) = statevecR(:,2);
% 	statevecT(:,2) = AT*statevecT(:,1) + BT*in(sample);
%   outT(sample)   = CT*statevecT(:,1) + DT*in(sample);
%   statevecT(:,1) = statevecT(:,2);
% end
% toc
%
% figure(826)
% subplot(2,1,1)
% time = [0:size(in,2)-1]/Fs;
% plot(time,in,'g', time,out,'k', time,outR,'k:', time,outT,'k--')
%
% subplot(2,1,2)
% lines = length(out);
% df=Fs/lines;
% f_calc=0:Fs/lines:(lines/2-1)*df;
% Y = fft(out,lines);
% H_calc = angle(Y(1:lines/2));
% YR = fft(outR,lines);
% H_calcR = angle(YR(1:lines/2));
% YT = fft(outT,lines);
% H_calcT = angle(YT(1:lines/2));
% %[h,w] = freqz(b,a,128);
% %plot(x,my,'b', w/pi*fmax,abs(h),'r', f_calc,H_calc,'k');
% plot(x,my,'b', x,R,'b:', x,T,'b--', ...
% 		 f_calc,H_calc,'k', f_calc,H_calcR,'k:', f_calc,H_calcT,'k--');
% %legend('original ','bs&as FRF','state sp.',4)
% ylabel('original (black), filter (blue)')
% legend('|Z|',' R ',' T ',4)
% %grid on
% %axis([0 40000 0 2 ])
% %soundsc(in,Fs)
% %soundsc(out,Fs)