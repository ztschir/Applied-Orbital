%Cap omega = RAAN
%Lowercase omega = argumentOfPerigee
%theta or f = trueAnomaly


function [r,v] = orbitalElementsToStateVectors(h,e,i,RAAN,argumentOfPerigee ,trueAnomaly)

    mu = 398600; %KM
    %RAAN, argumentOfPerigee, trueAnomaly in Degrees

    rxbar = ((h^2)/mu)*(1/(1+(e*cosd(trueAnomaly))))*([cosd(trueAnomaly), sind(trueAnomaly), 0]');
    
    vxbar = (mu/h)*([-sind(trueAnomaly), e + cosd(trueAnomaly), 0]');
    
    Qxbarx = [cosd(argumentOfPerigee), sind(argumentOfPerigee), 0; -sind(argumentOfPerigee), cosd(argumentOfPerigee), 0; 0, 0, 1]...
             *[1,0,0;0,cosd(i), sind(i); 0, -sind(i), cosd(i)]*[cosd(RAAN), sind(RAAN), 0; -sind(RAAN), cosd(RAAN), 0; 0, 0, 1];
         
    r = Qxbarx'*rxbar;
    v = Qxbarx'*vxbar;

end