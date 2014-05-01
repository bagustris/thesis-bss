%% this cunction calculates the direction-dependent elements in the mixing matrix. 
function A=calcA(theta,u)
A=[1+u*cos(theta);1-u*cos(theta)];