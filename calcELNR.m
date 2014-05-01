function [PLEL,PREL,PLNR,PRNR,SNRL,SNRR,SNRiL,SNRiR,SNRoL,SNRoR]=calcELNR(e1L,e1R,e2L,e2R,imaskL,imaskR,q,NFFT,WINDOW,NOVERLAP,Xalone,labelvec,energypercentageL,energypercentageR)
[wholesig,Fs]=wavread('stereomix.wav');
if(nargin==11)
    mus=0;
else
    mus=1;
end
if(mus)
    [remsig,Fs]=wavread('remaining.wav');
    for i=1:size(Xalone,3)
        str=strcat('ideal',int2str(i),'.wav');
        [idX,Fs]=wavread(str);
        idealX(:,:,i)=idX';
    end
end
ywholeL=sg(wholesig(:,1),NFFT,Fs,WINDOW,NOVERLAP);
ywholeR=sg(wholesig(:,2),NFFT,Fs,WINDOW,NOVERLAP);
for i=1:length(e1L)
    i
    str=strcat('finalstereo',int2str(i),'.wav');
    [O_n,Fs]=wavread(str);
    spe1L=ywholeL.*e1L{i};
    spe1R=ywholeR.*e1R{i};
    spe2L=ywholeL.*e2L{i};
    spe2R=ywholeR.*e2R{i};
    spIL_n=ywholeL.*imaskL{q(i)};
    spIR_n=ywholeR.*imaskR{q(i)};
    e1L_n=invspecgram(spe1L,NFFT,Fs, (WINDOW),NOVERLAP);
    e1R_n=invspecgram(spe1R,NFFT,Fs, (WINDOW),NOVERLAP);
    e2L_n=invspecgram(spe2L,NFFT,Fs, (WINDOW),NOVERLAP);
    e2R_n=invspecgram(spe2R,NFFT,Fs, (WINDOW),NOVERLAP);
    IL_n=invspecgram(spIL_n,NFFT,Fs, (WINDOW),NOVERLAP);
    IR_n=invspecgram(spIR_n,NFFT,Fs, (WINDOW),NOVERLAP);
    whL=invspecgram(ywholeL,NFFT,Fs, (WINDOW),NOVERLAP);
    whR=invspecgram(ywholeR,NFFT,Fs, (WINDOW),NOVERLAP);
    PLEL(i)=sum(e1L_n.^2)/sum(IL_n.^2);
    PREL(i)=sum(e1R_n.^2)/sum(IR_n.^2);
    PLNR(i)=sum(e2L_n.^2)/sum(O_n(:,1).^2);
    PRNR(i)=sum(e2R_n.^2)/sum(O_n(:,2).^2);
    SNRL(i)=10*log10(sum(IL_n.^2)/sum((IL_n-O_n(:,1)).^2));
    SNRR(i)=10*log10(sum(IR_n.^2)/sum((IR_n-O_n(:,2)).^2));
    SNRiL(i)=10*log10(sum(IL_n.^2)/sum((IL_n-whL).^2));
    SNRiR(i)=10*log10(sum(IR_n.^2)/sum((IR_n-whR).^2));
    XA1=Xalone(1,:,q(i));
    XA2=Xalone(2,:,q(i));
    minlength=min(length(O_n),length(XA1));
    XA1=XA1(:,1:minlength);%%adjust lengths
    XA2=XA2(:,1:minlength);%%adjust lengths
    O_n=O_n(1:minlength,:);%%adjust lengths
    XA1=XA1/(sqrt(var(XA1)));
    XA2=XA2/(sqrt(var(XA2)));
    On1=O_n(:,1)/sqrt(var(O_n(:,1)));
    On2=O_n(:,2)/sqrt(var(O_n(:,2)));
    
    SNRoL(i)=10*log10(sum(On1.^2)/sum((XA1'-On1).^2));
    SNRoR(i)=10*log10(sum(On2.^2)/sum((XA2'-On2).^2));
    if(mus)
        ylabelvec{i}=strcat('Output ',num2str(i));
        for j=1:size(Xalone,3)
            xcoL(i,j)=abs(xcorr(On1,Xalone(1,1:minlength,j),0,'coeff'));
            xcoR(i,j)=abs(xcorr(On2,Xalone(2,1:minlength,j),0,'coeff'));
            if i==length(e1L)
                xcoL(i+1,j)=abs(xcorr(remsig(1:minlength,1)',Xalone(1,1:minlength,j),0,'coeff'));
                xcoR(i+1,j)=abs(xcorr(remsig(1:minlength,2)',Xalone(2,1:minlength,j),0,'coeff'));
                if isnan(xcoL(i+1,j))
                    xcoL(i+1,j)=0;
                end
                if isnan(xcoR(i+1,j))
                    xcoR(i+1,j)=0;
                end
            end
            if isnan(xcoL(i,j))
                xcoL(i,j)=0;
            end
            if isnan(xcoR(i,j))
                xcoR(i,j)=0;
            end
        end
        for j=1:size(Xalone,3)
            xcoLI(i,j)=abs(xcorr(On1,idealX(1,1:minlength,j),0,'coeff'));
            xcoRI(i,j)=abs(xcorr(On2,idealX(2,1:minlength,j),0,'coeff'));
            if i==length(e1L)
                xcoLI(i+1,j)=abs(xcorr(remsig(1:minlength,1)',idealX(1,1:minlength,j),0,'coeff'));
                xcoRI(i+1,j)=abs(xcorr(remsig(1:minlength,2)',idealX(2,1:minlength,j),0,'coeff'));
                if isnan(xcoLI(i+1,j))
                    xcoLI(i+1,j)=0;
                end
                if isnan(xcoRI(i+1,j))
                    xcoRI(i+1,j)=0;
                end
            end
            if isnan(xcoLI(i,j))
                xcoLI(i,j)=0;
            end
            if isnan(xcoRI(i,j))
                xcoRI(i,j)=0;
            end
        end
    end
end
if(mus)
    ylabelvec{i+1}='Remaining';
    ylabelvec{i+2}='% of power';
    
    save cordata xcoL xcoR xcoLI xcoRI labelvec ylabelvec energypercentageL energypercentageR 
    figure
    flotmatrix(xcoL,labelvec,ylabelvec,energypercentageL)
    figure
    flotmatrix(xcoR,labelvec,ylabelvec,energypercentageR)
    figure
    flotmatrix(xcoLI,labelvec,ylabelvec,energypercentageL)
    figure
    flotmatrix(xcoRI,labelvec,ylabelvec,energypercentageR)
end