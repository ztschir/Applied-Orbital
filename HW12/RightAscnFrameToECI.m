function [X,Y,Z] = RightAscnFrameToECI(a,i_Degrees,e,RAAN_Degrees,perigee_Degrees,trueAnomaly_Degrees)


Q11 = cosd(perigee_Degrees)*cosd(RAAN_Degrees)-sind(perigee_Degrees)*sind(RAAN_Degrees)*cosd(i_Degrees);
Q12 = -sind(perigee_Degrees)*cosd(RAAN_Degrees)-cosd(perigee_Degrees)*sind(RAAN_Degrees)*cosd(i_Degrees);
Q21 = cos(perigee_Degrees)*sind(RAAN_Degrees)+sind(perigee_Degrees)*cosd(RAAN_Degrees)*cosd(i_Degrees);
Q22 = -sind(perigee_Degrees)*sind(RAAN_Degrees)+cosd(perigee_Degrees)*cosd(RAAN_Degrees)*cosd(i_Degrees);
Q31 = sind(perigee_Degrees)*sind(i_Degrees);
Q32 = cosd(perigee_Degrees)*sind(i_Degrees);


X = a*cosd(trueAnomaly_Degrees)*Q11+a*sind(trueAnomaly_Degrees)*Q12;
Y = a*cosd(trueAnomaly_Degrees)*Q21+a*sind(trueAnomaly_Degrees)*Q22;
Z = a*cosd(trueAnomaly_Degrees)*Q31+a*sind(trueAnomaly_Degrees)*Q32;