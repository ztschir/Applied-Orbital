clear all;
clc;


muSun = 1.327124e20; % MU of Sun
muEarth = 3.9860044e14;
muMars = 1.327124e20;
JD1 = 2457114; % Julian date for beginning TX
JD2 = 2457339; % Julian date for end TX
TotalTime = 225*86400;

% Earth
[a1,e1,i1,W1,w1,v1] = eph(3,JD1);
meanMotion1 = sqrt(muSun/(a1^3)); 
h1 = (((muSun^2)/meanMotion1)^(1/3))*sqrt(1-e1^2);

[r1,v1] = orbitalElementsToStateVectors(h1,e1,i1,W1,w1,v1);

T1 = (JD1 - 2451545.0) / 36525;

% Mars
[a2,e2,i2,W2,w2,v2] = eph(4,JD2);
meanMotion2 = sqrt(muSun/(a2^3)); 
h2 = (((muSun^2)/meanMotion2)^(1/3))*sqrt(1-e2^2);

[r2,v2] = orbitalElementsToStateVectors(h2,e2,i2,W2,w2,v2);

T2 = (JD2 - 2451545.0) / 36525;


%Question 1
[v0, vf] = lambertTransfer(r1, r2, 225*86400, muSun)


[R,V,tfin] = integrateTwoBodyEquation(r1, v0, 225*86400, muSun)


[R,V] = integrateFourBodyEquation([r1(1); r1(2)],[v0(1); v0(2)], 225*86400, muEarth, muMars, muSun, norm(r1), norm(r2))

