% plot spectrogramm of signal
set(0,'CurrentFigure',Hndl.figureNumber)
set(Hndl.mainaxes1,'vis','off');
cla;
set(Hndl.mainaxes2,'vis','off');
cla;
axes(Hndl.mainaxes0);
if TRACTDISP == 1
   specgram(data.y,1024,data.Fs);
else
   specgram(data.y,1024,data.Fs);
end
xlabel('Time [s]');
ylabel('Frequency [Hz]');
axis([-inf inf -inf FMAX]);