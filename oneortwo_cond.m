function condi=oneortwo_cond(X1,X2,fs,f_low,f_high)
%%% returns condition number of covariance matrix between the masked stereo
%%% signals. A high condition number indicates that only a single source is in the mixture.  
if nargin==3
    f_low=500; %low BP cutoff frequency
    f_high=3500; %low BP cutoff frequency
end
[B,A]=butter(8,[f_low f_high]/(fs/2));
Xf1=filter(B,A,X1);
Xf2=filter(B,A,X2);
X=[Xf1;Xf2];
R=X*X';
R;
condi=cond(R);
%%% actually the same as condi=(max(eig(R))/min(eig(R)))
