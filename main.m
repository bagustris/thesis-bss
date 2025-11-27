%%% Underdetimed source separation
%%% The algorithm is described in "Michael Syskind Pedersen, DeLiang Wang,
%%% Jan Larsen and Ulrik Kjems: Two-microphone Separation of Speech
%%% Mixtures", 2006, Submitted.
clear all
close all
format compact

dis=1;%%% display information while algorithm is running
if dis
    disp('Initialisation...')
end
rand('state',1)
y={[]};
M=2; %number of sensors
u=0.5;%cardioid pattern controller
N=3;% number of signals in mixture     %%% only used in mixing process
th=1;  %mask threshold control (tau)?
stopthresholdini=3000;     %One source if condition number is above this value
TC1=0.1; %Merge finalstereo signals if correlation is above TC1
TC2=0.03; %Merge finalstereo and enerstereo if correlation is above TC2
numlags=1;     %%% when correlation between two signals are found, how many lags should be considered?
thepow=20;     %%% tau_E
minpow=30;     %%% included to save a few calculations. 

%evalu=0%%% source signals as input, separated signals as output
%evalu=1%%% separation and evaluation
evalu=1;

winnumber=3; %%Selects window function
NFFT=2048;%%%DFT length
k=4;  %%% window length is NFFT/k
lastfmasklength=1;
switch winnumber
    case 1
        WINDOW=hanning(NFFT/k);
    case 2
        WINDOW=hann(NFFT/k);
    case 3
        WINDOW=hamming(NFFT/k);
    case 4
        WINDOW=bartlett(NFFT/k);%(triangular)
    case 5
        WINDOW=triang(NFFT/k);
    case 6
        WINDOW=blackman(NFFT/k);
    case 7
        WINDOW=rectwin(NFFT/k);
end
noverlapfactor=0.75;% overlap between consecutive windows
NOVERLAP=length(WINDOW)*noverlapfactor;


if evalu %%%read source signals signals
    s=[];
    [s(:,1),fs]=wavread('ukma.wav');%A
    [s(:,2),fs]=wavread('frma.wav');%B
    [s(:,3),fs]=wavread('itfe.wav');%C
    [s(:,4),fs]=wavread('cnfe.wav');%D
    [s(:,5),fs]=wavread('rufe.wav');%E
    [s(:,6),fs]=wavread('gema.wav');%F
    [s(:,7),fs]=wavread('nlma.wav');%G
    [s(:,8),fs]=wavread('jpfe.wav');%H
    [s(:,9),fs]=wavread('brfe.wav');%I
    [s(:,10),fs]=wavread('esma.wav');%J
    [s(:,11),fs]=wavread('dkma.wav');%K
    [s(:,12),fs]=wavread('ukfe.wav');%L
    labelvec={' A',' B',' C',' D',' E',' F',' G',' H',' I',' J',' K',' L'};
    % s=s(10001:50000,:);%%%%if signal duration should be made shorter

    %%% randomly pick N source signal from the pool of size(s,2) source signals.
    NS=1:size(s,2);
    for i=1:N
        rnd=ceil(rand(1)*(size(s,2)-i+1));
        Ns(i)=NS(rnd);
        NS(rnd)=[];%actually we pick by removing size(s,2)-N sources from the pool
    end
    N=length(Ns);
    S=s(:,Ns)';

    Npos=max(N,7); % at least 7 different directions
    all_theta=linspace(0,pi,Npos); %directions equally spaced between 0 and 180 degrees

    for i=1:N
        rnd=ceil(rand(1)*(Npos-i+1));
        theta(i)=all_theta(rnd);
        all_theta(rnd)=[];
    end
    %theta*180/pi     %%%% vector of direction angles

    %two cardioids pointing in two directions varying from 1-u to 1+u,0<u<=1
    A=calcA(theta,u); %calculate elements in mixing matrix
    X=A*S; %%%Create 2 mixed signals
    wavwrite(X',fs,'stereomix');%save stereo mixture, not scaled!!!
else 
    [X,fs]=wavread('stereomix.wav');
    X=X';
end

%%estimate energy stop thresholds
powpow=10*log10((sum(X(1,:).^2)+sum(X(2,:).^2))/(2*length(X)));%power of mixture(used to determine thresholds)
thE=powpow-thepow; %power threshold
minpower=powpow-minpow;%do not save signals with very little power (makes computations faster)
%%% create ideal masks for evaluation purpose
if evalu
    for i=1:N
        vd=zeros(1,N);
        vd(i)=1;
        ivd=(vd-1)*(-1);
        [imaskL{i},imaskR{i},SNRiL(i),SNRiR(i)]=idealmask(A*diag(vd)*S,A*diag(ivd)*S,fs,NFFT,WINDOW,NOVERLAP);
    end
    [cmL,cmR]=colorimask(imaskL,imaskR,fs); %%% draw each ideal BM with a certain color
end
x={X}; %initialize buffer of signals to be separated
mask={[]}; %initialize mask buffer
fmask={[]};
enermask={[]};
delete_me_again=sg(X(1,:),NFFT,fs,WINDOW,NOVERLAP);%get dimensions of mask
lastremmask=zeros(size(delete_me_again));
clear delete_me_again
%%% Start algorithm
%%%Initialize counters
countmax=30; %the maximum iteration number (to be absolutely sure that the algorithm stops)
finalcnt=1;    %counts the number of separated output signals
enercnt=1;     %counts the number of low energy masks
exitcnt=1;     % counts the number of times the mask buffer is emptied and the remaining mask is estimated
cnt=0;%number of iterations
if dis
    disp('Starting algorithm...')
end
while cnt<countmax
    sx=size(x,2);     %%%%size of the signal vector. the signals are grouped in sx/2 grops. When there is no more signals left in x, the separation task is over.
    cnt=cnt+1;
    % stopthreshold=max(stopthresholdini/cnt,minstopthreshold)%enable if stop threshold should change during iterations
    stopthreshold=stopthresholdini;

    %%% make empty buffers to store signal pairs and corresponding masks for evaluation
    xbuffer={};
    maskbuffer={};

    for n=1:sx
        %%% 2 by 2 ICA algorithm
        [y{n},Aest] = icaML(x{n});
        %%% alternative 2 by 2 ICA algorithm
        %%% [Aest,y{n}]=jade(x{n});%%% available from ICA central


        %%%normalization
        for m=1:2%%%normalization
            y{n}(m,:)=y{n}(m,:)/(10*sqrt(var(y{n}(m,:))));
        end
        %[Aest,W,y{n},theta_est]=normmix(Aest,x{n},u);     %normalization based on kmnown microphone responses
        %%%normalization

        %%% ICA  evaluation
        if(0)%%% plots ICA output beampatterns
            evalICAdB(W,theta_est,theta,N,Ns,labelvec,u)
        end
        %%% ICA  evaluation

        %%% estimate mask
        if dis
            disp('Finding mask...')
        end
        if evalu
            [newX{1}(1,:),newX{1}(2,:),newX{2}(1,:),newX{2}(2,:),msk{1},msk{2}]=applymasks(X(1,:)',X(2,:)',y{n}(1,:)',y{n}(2,:)',mask{n},fs,th,NFFT,WINDOW,NOVERLAP,cmR,cmL);
        else
            [newX{1}(1,:),newX{1}(2,:),newX{2}(1,:),newX{2}(2,:),msk{1},msk{2}]=applymasks(X(1,:)',X(2,:)',y{n}(1,:)',y{n}(2,:)',mask{n},fs,th,NFFT,WINDOW,NOVERLAP);
        end
        %% binaural stopping criteria
        for m=1:2
            condi=oneortwo_cond(newX{m}(1,:),newX{m}(2,:),fs);%%% one or two signals based on condition number
            if(enerstop(newX{m}(1,:),newX{m}(2,:),thE,minpower)==2)
                if dis
                    disp('Not a speech signal-too low energy')
                end
            elseif(enerstop(newX{m}(1,:),newX{m}(2,:),thE,minpower)==1)
                if dis
                    disp('Not a good quality speech signal')
                end
                [L,R,enermask{enercnt}]=getfinalmask(X(1,:)',X(2,:)',y{n}(1,:)',y{n}(2,:)',mask{n},fs,th,m,NFFT,WINDOW,NOVERLAP,1);%to save memory, enermask is a sparse matrix
                stestr=strcat('enerstereo',int2str(enercnt));%not scaled
                if dis
                    disp(strcat('enerstereo',int2str(enercnt)))
                end    
                wavwrite([L,R],fs,stestr);
                enercnt=enercnt+1;
            elseif(condi>stopthreshold)
                if dis
                    disp('Save as final signal...')
                end
                [L,R,fmask{finalcnt}]=getfinalmask(X(1,:)',X(2,:)',y{n}(1,:)',y{n}(2,:)',mask{n},fs,1,m,NFFT,WINDOW,NOVERLAP,0);%notice that in the last step, the threshold is set to 1.
                %str=strcat('y',int2str(m),'iter',int2str(cnt),'n',int2str(n),'final',int2str(finalcnt))
                %wavwrite(y{n}(m,:),fs,str);    %%%save files
                stestr=strcat('finalstereo',int2str(finalcnt));%not scaled
                if dis
                    disp(strcat('finalstereo',int2str(finalcnt)))
                end
                wavwrite([L,R],fs,stestr);
                finalcnt=finalcnt+1;    %%%save files
            else %continue
                xbuffer={xbuffer{1:end},newX{m}};
                maskbuffer={maskbuffer{1:end},msk{m}};
                %                 str=strcat('y',int2str(m),'iter',int2str(cnt),'n',int2str(n))
                %                 wavwrite(y{n}(m,:),fs,str);
            end
        end
    end
    clear x
    x=xbuffer;
    clear mask
    mask=maskbuffer;

    if(isempty(xbuffer))    %%% all branches in the algorithm has ended, no more signal pairs to which ICA should be applied
        if dis
            disp('Stopping separation algorithm')
        end
        if length(fmask)~=lastfmasklength; %check if one source appears more than once in the final signals
            fmask=multisigcheck(fmask,X(1,:)',X(2,:)',TC1,fs,NFFT,WINDOW,NOVERLAP,numlags);
            lastfmasklength=length(fmask);
            finalcnt=lastfmasklength+1;
        end
        if isempty(enermask{1})
        else %check if poor quality signal is correlated with one of the final signals
            fmask=nosigcorr(fmask,enermask,X(1,:)',X(2,:)',TC2,fs,NFFT,WINDOW,NOVERLAP,numlags);
        end
        enercnt=1;
        enermask={[]};
        if isempty(fmask{1})
            if dis
                disp('No signals segregated. Stopping separation procedure.')'
            end
            exitcnt=4;
            break
        else
            if dis
                disp('Finding remaining mask...')
            end
            if evalu
                [L,R,remainingmask]=getremainingmask(X(1,:)',X(2,:)',fmask,fs,NFFT,WINDOW,NOVERLAP,cmL,cmR);
            else
                [L,R,remainingmask]=getremainingmask(X(1,:)',X(2,:)',fmask,fs,NFFT,WINDOW,NOVERLAP);
            end
        end
        if lastremmask==remainingmask     %%% Should not continue if background mask have not changed.
            if dis
                disp('No changes. Stopping separation procedure.')
            end
            exitcnt=4;
            wavwrite([L,R],fs,'remaining');
            break
        else
            lastremmask=remainingmask;    %%% to see if the next background mask have changed.
        end
        wavwrite([L,R],fs,'remaining');
        condi=oneortwo_cond(newX{m}(1,:),newX{m}(2,:),fs);
        if(enerstop(L',R',thE,minpower,fs)>0) %% enough energy in remaining mask?
            if dis
                disp('Not a speech signal')
            end
            break
        elseif(condi>stopthreshold)%%%more than one signal in remaining?
            stestr=strcat('finalstereo',int2str(finalcnt));%not scaled
            
            wavwrite([L,R],fs,stestr);
            if dis
                disp('save remaing')
                disp(strcat('finalstereo',int2str(finalcnt)))
            end
            fmask{finalcnt}=remainingmask;
            break
        else
            mask={remainingmask};
            x={[L';R']};
        end
        if exitcnt>=4
            break
        end
        exitcnt=exitcnt+1;
    end
end
if isempty(fmask)
    flag=1;
    mEL=0
    mNR=0
    mSNRi=0
    mSNRo=0
    mSNRx=0
else
    if length(fmask)~=lastfmasklength;
        fmask=multisigcheck(fmask,X(1,:)',X(2,:)',TC1,fs,NFFT,WINDOW,NOVERLAP,numlags);
    end
    if isempty(enermask{1});
    else
        fmask=nosigcorr(fmask,enermask,X(1,:)',X(2,:)',TC2,fs,NFFT,WINDOW,NOVERLAP,numlags);
    end
end

if dis
    disp('Separation done.')
end
if evalu
    if dis
        disp('Evaluation of outputs')
    end
    
    %%%clear x and mask if algorithm should be run again on another mixture
    clear x
    clear mask
    %% sort masks with corresponding ideal mask
    [valL,valR,e1L,e1R,e2L,e2R,q,lbl,cflag]=comparemasks(fmask,imaskL,imaskR,labelvec(Ns),fs,length(s));
    %standalone signals
    for i=1:N
        Xalone(:,:,i)=A(:,i)*S(i,:);
    end
    %%% calculate snr according to hu-wang 1999 paper
    [PLEL,PREL,PLNR,PRNR,SNRL,SNRR,SNRiLi,SNRiRi,SNRxL,SNRxR]=calcELNR(e1L,e1R,e2L,e2R,imaskL,imaskR,q,NFFT,WINDOW,NOVERLAP,Xalone);
    lbl{1:end};

    datafile=strcat('data.mat');
    save(datafile, 'PLEL', 'PREL', 'PLNR' ,'PRNR', 'SNRL', 'SNRR', 'SNRiL', 'SNRiR','lbl', 'th', 'stopthresholdini', 'TC1' ,'TC2', 'thepow', 'minpow', 'NFFT', 'winnumber', 'k', 'NOVERLAP', 'Ns', 'theta')
    mEL=100*(mean(PLEL)+mean(PREL))/2
    mNR=100*(mean(PLNR)+mean(PRNR))/2
    mSNRi=(mean(SNRiL)+mean(SNRiR))/2
    mSNRo=(mean(SNRL)+mean(SNRR))/2
    mSNRx=(mean(SNRxL)+mean(SNRxR))/2
    if length(fmask)~=N
        flag=1;        %%%not same number of segregated signals as input signals
    elseif cflag==1    %%% one of the segregated signals appears to be the same source signal.
        flag=1;
    else
        flag=0;
    end

mSNR=mSNRo-mSNRi
save mydata mEL mNR mSNRi mSNRo mSNR mSNRx flag
end
if dis
    disp('Done')

end
