function [imaskL,imaskR,SNRiL,SNRiR]=idealmask(xclean,xresid,Fs,NFFT,WINDOW,NOVERLAP)
%%% the funciton returns the ideal binary masks for the two microphone
%%% signals. Also the input sna is calculated.
th=1;
%
ycleanL=sg(xclean(1,:),NFFT,Fs,WINDOW,NOVERLAP);
ycleanR=sg(xclean(2,:),NFFT,Fs,WINDOW,NOVERLAP);
yresidL=sg(xresid(1,:),NFFT,Fs,WINDOW,NOVERLAP);
yresidR=sg(xresid(2,:),NFFT,Fs,WINDOW,NOVERLAP);
[a,b]=size(ycleanL);

imaskL=abs(ycleanL)>th*abs(yresidL);
imaskR=abs(ycleanR)>th*abs(yresidR);
SNR=10*log10(sum(xclean.^2,2)./sum(xresid.^2,2))';
SNRiL=SNR(1);
SNRiR=SNR(2);
if(0)%%% plot masks
    figure
    subplot(211)
    imagesc(linspace(0,length(xclean)/Fs,a),linspace(0,Fs/2,b),(imaskL));
    axis xy
    colormap([1,1,1;0,0,0]);
    subplot(212)
    imagesc(linspace(0,length(xclean)/Fs,a),linspace(0,Fs/2,b),imaskR);
    axis xy
    colormap([1,1,1;0,0,0]);
end
%pctcorrect=1-sum(sum(abs(imaskL-imaskR)))/(a*b)
