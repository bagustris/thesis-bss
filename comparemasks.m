function [valL,valR,e1L,e1R,e2L,e2R,q,lbl,cflag]=comparemasks_v1(fmask,imaskL,imaskR,labelvec,Fs,lx)
[a,b]=size(fmask{1});
for i=1:length(fmask)
    for j=1:length(imaskL)
        oneL=sum(sum(imaskL{j}));
        zeroL=a*b-oneL;
        oneR=sum(sum(imaskR{j}));
        zeroR=a*b-oneR;
        pct11L(i,j)=sum(sum(fmask{i}==1 & imaskL{j}==1))/oneL;
        pct00L(i,j)=sum(sum(fmask{i}==0 & imaskL{j}==0))/zeroL;
        pct10L(i,j)=sum(sum(fmask{i}==0 & imaskL{j}==1))/oneL;
        pct01L(i,j)=sum(sum(fmask{i}==1 & imaskL{j}==0))/zeroL;
        
        pct11R(i,j)=sum(sum(fmask{i}==1 & imaskR{j}==1))/oneR;
        pct00R(i,j)=sum(sum(fmask{i}==0 & imaskR{j}==0))/zeroR;
        pct10R(i,j)=sum(sum(fmask{i}==0 & imaskR{j}==1))/oneR;
        pct01R(i,j)=sum(sum(fmask{i}==1 & imaskR{j}==0))/zeroR;
      
       
    end
end
valL={pct11L,pct10L,pct01L,pct00L};
valR={pct11R,pct10R,pct01R,pct00R};

[p,q]=max(valL{1}'+valR{1}');
for i=1:min(length(fmask),length(imaskL))
    fg=figure;
    subplot(311)
    imagesc(linspace(0,lx/Fs,a),linspace(0,Fs/2,b),imaskL{q(i)});
    
    axis xy
    colormap([1,1,1;0,0,0]);
    str=strcat('Microphone 1 ideal binary mask for ',labelvec(q(i)));
    t=title(str,'Fontsize',12);
    set(gca,'YTick',[0:1000:5000])
    set(t,'Position',[2.49421 5000 1.00005])%%%Change of 2nd parameter, decrement moves title slightly down
    subplot(312)
    imagesc(linspace(0,lx/Fs,a),linspace(0,Fs/2,b),imaskR{q(i)});
    axis xy
    colormap([1,1,1;0,0,0]);
    str=strcat('Microphone 2 ideal binary mask for ',labelvec(q(i)));
    set(gca,'YTick',[0:1000:5000])
    t=title(str,'Fontsize',12);
    ylabel('Frequency [Hz]','Fontsize',16)
    set(t,'Position',[2.49421 5000 1.00005])
    subplot(313)
    imagesc(linspace(0,lx/Fs,a),linspace(0,Fs/2,b),fmask{i});
    axis xy
    colormap([1,1,1;0,0,0]);
    str=strcat('Estimated binary mask for ',labelvec(q(i)));
    t=title(str,'Fontsize',12);
    set(gca,'YTick',[0:1000:5000])
    xlabel('Time [s]','Fontsize',16)
    str=strcat('mask',num2str(i),'.eps');
    set(fg,'PaperPosition',[0.25 2.5 8 5.95])
    set(t,'Position',[2.49421 5000 1.00005])
    saveas(fg,str)
     str=strcat('mask',num2str(i),'.fig');
    saveas(fg,str)
    lbl{i}=labelvec(q(i));
    %%% finding e1,e2 according to hu-wang99 paper
    e1L{i}=(fmask{i}==0 & imaskL{q(i)}==1);%%%mask of signal present in IL(n) but absent in O(n)
    e1R{i}=(fmask{i}==0 & imaskR{q(i)}==1);%%%mask of signal present in IR(n) but absent in O(n)
    e2L{i}=(fmask{i}==1 & imaskL{q(i)}==0);%%%mask of signal present in O(n) but absent in IL(n)
    e2R{i}=(fmask{i}==1 & imaskR{q(i)}==0);%%%mask of signal present in O(n) but absent in IL(n)
end

%%Check is any signal appear twice
 
if(sum(diff(sort(q)))<(length(q)-1))
    cflag=1;
else
    cflag=0;
end