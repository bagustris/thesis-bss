%%% normalization of mixing matrix based on known microphone responsed
function [A,W,y,theta]=normmix(A,x,u)
k=A(1,:)./A(2,:);
theta=real(acos((k-1)./(u*(k+1))));
A=calcA(theta,u);
W=inv(A);
y=W*x;
