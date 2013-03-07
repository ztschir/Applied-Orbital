function [localSiderealTime] = convertUTCAndDOYToSiderealTimeInDegreesAtGreenwich(year, month, day, hour) 

    J0 = 367*year - floor((7/4)*(year + floor((month+9)/12))) + floor(275*month/9) + day + 1721013.5;
    
    T0 = (J0 - 2451545)/36525;
    
    thetaG0 = 100.4606184 + 36000.77004*T0 + 0.000387933*T0^2 - 2.583*(10^-8)*T0^3;
    
    thetaG0 = thetaG0 - floor(thetaG0/360)*360;
    
    localSiderealTime = thetaG0 + 360.98564724*(hour/24);
    

end