function [newsigL1,newsigR1,newsigL2,newsigR2,mask1,mask2]=applymasks(wholesigL,wholesigR,cleansig1,cleansig2,oldM,Fs,th,NFFT,WINDOW,NOVERLAP,cmR,cmL)
%%% The function estimates the binary masks based on comparison between  
%%% cleansig1 and cleansig2. The binary masks are applied to the two 
%%% original signals, and 4 masked signals are estimated. For evaluation 
%%% purpose, the binary masks can be drawn, where the color of the F-T unit
%%% corresponds to the color of the ideal mask of each signal.
 
yclean1=sg(cleansig1,NFFT,Fs,WINDOW,NOVERLAP);
yclean2=sg(cleansig2,NFFT,Fs,WINDOW,NOVERLAP);

ywholeL=sg(wholesigL,NFFT,Fs,WINDOW,NOVERLAP);
ywholeR=sg(wholesigR,NFFT,Fs,WINDOW,NOVERLAP);

[a,b]=size(ywholeL);
[c,d]=size(yclean1);

if(isempty(oldM))
    oldM=ones(a,b);
end
mask1=abs(yclean1)>th*abs(yclean2);
mask2=th*abs(yclean1)<abs(yclean2);
mask1=mask1.*oldM;
mask2=mask2.*oldM;
yL1=ywholeL.*mask1;
yR1=ywholeR.*mask1;
yL2=ywholeL.*mask2;
yR2=ywholeR.*mask2;

newsigL1=invspecgram((yL1),NFFT,Fs, (WINDOW),NOVERLAP);
newsigR1=invspecgram((yR1),NFFT,Fs, (WINDOW),NOVERLAP);
newsigL2=invspecgram((yL2),NFFT,Fs, (WINDOW),NOVERLAP);
newsigR2=invspecgram((yR2),NFFT,Fs, (WINDOW),NOVERLAP);

%%%%evaluation
if(0)
    figure
    subplot(211)
    imagesc(mask1);
    colormap([1,1,1;0,0,0]);
    subplot(212)
    imagesc(mask2);
    colormap([1,1,1;0,0,0]);
end
if(0)
    fig=figure
    imagesc(linspace(0,length(cleansig1)/Fs,a),linspace(0,Fs/2,b),mask1);
    axis xy
    colormap([1,1,1;0,0,0]);
    set(fig,'PaperPosition',[0.25 2.5 8 3])
    str1=strcat('m1',int2str(round(rem(now,1)*1000000)),'.png');
    str2=strcat('mask2',int2str(round(rem(now,1)*1000000)),'.png');

    saveas(fig,'m1.eps')
    saveas(fig,str1)
    fig=figure
    imagesc(linspace(0,length(cleansig2)/Fs,a),linspace(0,Fs/2,b),mask2);
    axis xy
    colormap([1,1,1;0,0,0]);
    set(fig,'PaperPosition',[0.25 2.5 8 3])%% optimized for matlab v6.5
    saveas(fig,'m2.eps')
    saveas(fig,str2)
end
if(0)
    mask1L=mask1.*cmL;
    mask1R=mask1.*cmR;
    mask2L=mask2.*cmL;
    mask2R=mask2.*cmR;
    cmap=[1,1,1;1,0,0;0,1,0;1,1,0;0,0,1;0.5,0,0.5;1,0.5,0];
    fig=figure
    subplot(211)
    imagesc(linspace(0,length(cleansig1)/Fs,a),linspace(0,Fs/2,b),mask1L);
    axis xy
    colormap(cmap);
    subplot(212)
    imagesc(linspace(0,length(cleansig2)/Fs,a),linspace(0,Fs/2,b),mask1R);
    axis xy
    colormap(cmap);
    fig=figure
    subplot(211)
    imagesc(linspace(0,length(cleansig1)/Fs,a),linspace(0,Fs/2,b),mask2L);
    axis xy
    colormap(cmap);
    subplot(212)
    imagesc(linspace(0,length(cleansig2)/Fs,a),linspace(0,Fs/2,b),mask2R);
    axis xy
    colormap(cmap);
elseif(0)
    str1=strcat('mask1',int2str(round(rem(now,1)*1000000)),'.png');
    str2=strcat('mask2',int2str(round(rem(now,1)*1000000)),'.png');
    mask1L=mask1.*cmL;
    mask1R=mask1.*cmR;
    mask2L=mask2.*cmL;
    mask2R=mask2.*cmR;
    cmap=[1,1,1;1,0,0;0,1,0;1,1,0;0,0,1;0.5,0,0.5;1,0.5,0];
    fig=figure
    imagesc(linspace(0,length(cleansig1)/Fs,a),linspace(0,Fs/2,b),mask1L);
    axis xy
    colormap(cmap);
    set(fig,'PaperPosition',[0.25 2.5 8 3])
    saveas(fig,str1)
    fig=figure
    imagesc(linspace(0,length(cleansig1)/Fs,a),linspace(0,Fs/2,b),mask2L);
    axis xy
    colormap(cmap);
    set(fig,'PaperPosition',[0.25 2.5 8 3])
    saveas(fig,str2)
end
