function fmask=multisigcheck(fmask,wholesigL,wholesigR,tc,Fs,NFFT,WINDOW,NOVERLAP,numlags)
%%% if some of the final signals contains the same source, their corresponding masks are
%%% merged. The signal is then reestimated from the merged mask. 

ywholeL=sg(wholesigL,NFFT,Fs,WINDOW,NOVERLAP);
ywholeR=sg(wholesigR,NFFT,Fs,WINDOW,NOVERLAP);

Nsig=length(fmask);
for i=1:Nsig;
    str=strcat('finalstereo',num2str(i),'.wav');
    s=wavread(str);
    x(:,i)=s(:,1);%%%just keep one of the stereo signals
    y(:,i)=s(:,2);
end

    todelete=[];
    changed=[];
    xc0=zeros(Nsig);
for i=1:Nsig
    for j=i:Nsig
        xco(i,j)=max(xcorr(x(:,i),x(:,j),numlags,'coeff'));
    end
end
xco=xco-eye(Nsig);
  for i=1:Nsig
    for j=i:Nsig
     %   xco(i,j)=max(xcorr(x(:,i),x(:,j),numlags,'coeff'));
        if xco(i,j)>tc && i~=j && xco(i,j)== max(xco(:,j))%%% it is probably a reasonable threshold
            sf1=sum(sum(fmask{i}))
            sf2=sum(sum(fmask{j}))
            fmask{i}=fmask{i}+fmask{j}-fmask{i}.*fmask{j}; %%the second term makes any value which is 2 to be 1
            sf=sum(sum(fmask{i}))
            yL=ywholeL.*fmask{i};
            yR=ywholeR.*fmask{i};
            todelete=[todelete,j];
            changed=[changed,i];
            x(:,i)=invspecgram((yL),NFFT,Fs,(WINDOW),NOVERLAP);
            y(:,i)=invspecgram((yR),NFFT,Fs,(WINDOW),NOVERLAP);
            
        end
    end
end
xco
todelete
changed
fmask(todelete)=[];
x(:,[todelete])=[];
y(:,[todelete])=[];
for i=1:length(fmask)
    stestr=strcat('finalstereo',int2str(i),'.wav'); 
    wavwrite([x(:,i),y(:,i)],Fs,stestr);
end
for i=(length(fmask)+1):Nsig
    stestr=strcat('finalstereo',int2str(i),'.wav');% 
    delete(stestr);
end