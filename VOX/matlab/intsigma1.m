function out = intsigma1(t, coefsigma, expsigma, t0, deltat, s)
idx=find((t-t0)== 0);
t(idx)=1+t0;
sigma = coefsigma*(t-t0).^(-1.5).*exp(-expsigma./(t-t0));
sigma(idx) = 0;
out = sigma.*(t/deltat).^s;
