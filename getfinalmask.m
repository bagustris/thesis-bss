function [newsigL,newsigR,mask]=getfinalmask(wholesigL,wholesigR,cleansig1,cleansig2,oldM,Fs,th,m,NFFT,WINDOW,NOVERLAP,spar)
%%% returns mask and corresponding stereo signal.
yclean1=sg(cleansig1,NFFT,Fs,WINDOW,NOVERLAP);
yclean2=sg(cleansig2,NFFT,Fs,WINDOW,NOVERLAP);

ywholeL=sg(wholesigL,NFFT,Fs,WINDOW,NOVERLAP);
ywholeR=sg(wholesigR,NFFT,Fs,WINDOW,NOVERLAP);

[a,b]=size(ywholeL);

if(isempty(oldM))
  oldM=ones(a,b);
end

if m==1
    mask=abs(yclean1)>th*abs(yclean2);
end
if m==2
    mask=th*abs(yclean1)<abs(yclean2);
end

mask=mask.*oldM;
yL=ywholeL.*mask;
yR=ywholeR.*mask;

newsigL=invspecgram((yL),NFFT,Fs,(WINDOW),NOVERLAP);
newsigR=invspecgram((yR),NFFT,Fs,(WINDOW),NOVERLAP);

if(0)
    figure
imagesc(mask);
colormap([1,1,1;0,0,0]);
title(strcat('Getfinalmethod_',num2str(m)));
end
if(spar)
    mask=sparse(mask);
end
    