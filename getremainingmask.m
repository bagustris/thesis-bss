function [newsigL,newsigR,mask]=getremainingmask(wholesigL,wholesigR,fmask,Fs,NFFT,WINDOW,NOVERLAP,cmL,cmR)

[a,b]=size(fmask{1});
ywholeL=sg(wholesigL,NFFT,Fs,WINDOW,NOVERLAP);
ywholeR=sg(wholesigR,NFFT,Fs,WINDOW,NOVERLAP);
umask=zeros(size(fmask{1}));
for i=1:length(fmask)
    umask=or(umask,fmask{i});
end
mask=not(umask);

yL=ywholeL.*mask;
yR=ywholeR.*mask;
newsigL=invspecgram((yL),NFFT,Fs, (WINDOW),NOVERLAP);
newsigR=invspecgram((yR),NFFT,Fs, (WINDOW),NOVERLAP);

if(0)
    figure
    imagesc(mask);
    axis xy
    colormap([1,1,1;0,0,0]);
end
if(0)
    cmskL=mask.*cmL;
    cmskR=mask.*cmR;
    cmap=[1,1,1;1,0,0;0,1,0;1,1,0;0,0,1;0.5,0,0.5;1,0.5,0];
    fig=figure
    imagesc(linspace(0,50000/Fs,a),linspace(0,Fs/2,b),cmskL);
    axis xy
    colormap(cmap);
    set(fig,'PaperPosition',[0.25 2.5 8 3])
    saveas(fig,'remainingL.png')
end