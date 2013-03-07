function [rOut,vOut] = RightAscnFrameToECEF(r,i_Degrees,e,h,RAAN_Degrees,perigee_Degrees,trueAnomaly_Degrees)
mu = 398600; %KM

Q11 = cosd(perigee_Degrees)*cosd(RAAN_Degrees)-sind(perigee_Degrees)*sind(RAAN_Degrees)*cosd(i_Degrees);
Q12 = -sind(perigee_Degrees)*cosd(RAAN_Degrees)-cosd(perigee_Degrees)*sind(RAAN_Degrees)*cosd(i_Degrees);
Q21 = cos(perigee_Degrees)*sind(RAAN_Degrees)+sind(perigee_Degrees)*cosd(RAAN_Degrees)*cosd(i_Degrees);
Q22 = -sind(perigee_Degrees)*sind(RAAN_Degrees)+cosd(perigee_Degrees)*cosd(RAAN_Degrees)*cosd(i_Degrees);
Q31 = sind(perigee_Degrees)*sind(i_Degrees);
Q32 = cosd(perigee_Degrees)*sind(i_Degrees);


X = r*cosd(trueAnomaly_Degrees)*Q11+r*sind(trueAnomaly_Degrees)*Q12;
Y = r*cosd(trueAnomaly_Degrees)*Q21+r*sind(trueAnomaly_Degrees)*Q22;
Z = r*cosd(trueAnomaly_Degrees)*Q31+r*sind(trueAnomaly_Degrees)*Q32;
rOut = [X, Y, Z]';

Vr = (mu/h)*e*sind(trueAnomaly_Degrees);
Vtheta = h/r;
Xdotstar = Vr*cosd(trueAnomaly_Degrees)-Vtheta*sind(trueAnomaly_Degrees);
Ydotstar = Vr*sind(trueAnomaly_Degrees)+Vtheta*cosd(trueAnomaly_Degrees);


Xdot = Xdotstar*Q11 + Ydotstar*Q12;
Ydot = Xdotstar*Q21 + Ydotstar*Q22;
Zdot = Xdotstar*Q31 + Ydotstar*Q32;

vOut = [Xdot, Ydot, Zdot]';
