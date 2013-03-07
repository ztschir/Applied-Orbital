function [REarthFixed] = ECIToECEF(R, t, t0)
    
    We = 2*pi/86164;
    
    theta = We*(t - t0);
    
    R3 = [cos(theta), sin(theta), 0; -sin(theta), cos(theta), 0; 0,0,1];
    
    REarthFixed = R3*R';
    
end