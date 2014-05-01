function [bi]=enerstop(xa,xb,thE,minpower,fs)
%%% Determines if signal is of acceptable quality (save as finalstereo),
%%% poor quality (save as enerstereo), or very poor quality (do not save 
%%% and do not apply ica to this signal again) 

power=10*log10((sum(xa.^2)+sum(xb.^2))/(2*length(xa)));
bi1=power<thE;
bi2=power<minpower;%too low energy, dont save signal
if bi1
    bi=1;
else
    bi=0;
end
if bi2
    bi=2;
end

%calculate power in smaller time slots, this is not used
if(0)
    lx=length(xa);
    N=2*floor(lx/(10000))-1;
    for n=1:N
        power(n)=log10(((sum(xa((1:fs)+(n-1)*fs/2)).^2)+sum(xb((1:fs)+(n-1)*fs/2).^2))/(2*fs));
        bi1(n)=power(n)<thE;
        bi2(n)=power(n)<minpower;%too low energy, dont save signal
    end
    bi1
    bi2
    if sum(bi1)/N>0.8
        bi=1;
    else
        bi=0;
    end
    if sum(bi2)/N>0.8
        bi=2;
    end
end

