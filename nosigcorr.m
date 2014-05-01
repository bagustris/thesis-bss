function fmask=nosigcorr(fmask,enermask,wholesigL,wholesigR,tc,Fs,NFFT,WINDOW,NOVERLAP,numlags)
%%% if poor quality signals are correlated with one of the final signals, their corresponding masks are
%%% merged. The final signal is then reestimated from the merged mask. 


ywholeL=sg(wholesigL,NFFT,Fs,WINDOW,NOVERLAP);
ywholeR=sg(wholesigR,NFFT,Fs,WINDOW,NOVERLAP);
Nsig=length(fmask)
Nesig=length(enermask)
for i=1:Nsig
    str=strcat('finalstereo',num2str(i),'.wav');
    s=wavread(str);
    x(:,i)=s(:,1);%%%just keep one of the stereo signals
    y(:,i)=s(:,2);
end
% for j=1:Nesig
%     str=strcat('enerstereo',num2str(j),'.wav');
%     s=wavread(str);
%     xe(:,j)=s(:,1);%%%just keep one of the stereo signals
%     %y(:,j)=s(:,2);
% end

    todelete=[];
    changed=[];
    xc0=zeros(Nsig,Nesig);
for i=1:Nsig
    for j=1:Nesig
        str=strcat('enerstereo',num2str(j),'.wav');
        s=wavread(str);
        xe=s(:,1);
        xco(i,j)=max(xcorr(x(:,i),xe,numlags,'coeff'));
    end
end
for i=1:Nsig
    for j=1:Nesig
        if xco(i,j)>tc && xco(i,j)== max(xco(:,j))%%% it is probably a reasonable threshold the other ensures that the mask is only added to one of the signals.
            if(issparse(enermask{j}))
                enermask{j}=full(enermask{j});
            end
           % sfm=sum(sum(fmask{i}));
           % sfe=sum(sum(enermask{j}));
            fmask{i}=fmask{i}+enermask{j}-fmask{i}.*enermask{j}; %%the second term makes any value which is 2 to be 1
          %  sf=sum(sum(fmask{i}))
            yL=ywholeL.*fmask{i};
            yR=ywholeR.*fmask{i};
            todelete=[todelete,j];
            changed=[changed,i];
            x(:,i)=invspecgram((yL),NFFT,Fs, (WINDOW),NOVERLAP);
            y(:,i)=invspecgram((yR),NFFT,Fs, (WINDOW),NOVERLAP);
            enermask{j}=sparse(enermask{j});
        end
          end
      end
xco
todelete
changed
%enermask(todelete)=[];
for i=1:length(fmask)
    stestr=strcat('finalstereo',int2str(i),'.wav'); 
    wavwrite([x(:,i),y(:,i)],Fs,stestr);
end
for j=1:Nesig
    stestr=strcat('enerstereo',int2str(j),'.wav');% 
    delete(stestr);
end