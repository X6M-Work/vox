function  out = intsigma2(t, coefsigma, expsigma, t0, deltat, s, m)
idx=find((t+m*deltat-t0)== 0);
t(idx)=1;
sigma = coefsigma*(t+m*deltat-t0).^(-1.5).*exp(-expsigma./(t+m*deltat-t0));
sigma(idx) = 0;
out = sigma.*((t/deltat).^s);
