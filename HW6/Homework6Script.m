
clear all;
clc;

mu = 398600; %KM
seconds = 86164; %seconds
degrees = 180/pi; %convert to degrees
radians = pi/180; %convert to radians


% Find Grace 1 State Vector 
e_GRACE1 = .0019832;
i_GRACE1 = 89.0263; %degrees
RAAN_GRACE1 = 222.2924; %degrees
argumentOfPerigee_GRACE1 = 41.9865; %degrees
meanAnomaly_GRACE1 = 318.2929; %degrees
meanMotion_GRACE1 = 15.31234582*(2*pi/seconds); %rad/sec
period_GRACE1 = 2*pi/meanMotion_GRACE1; %seconds
time_GRACE1 = 343.90711393; %days of the year
time_GRACE1_Final = 343.90745732; %days of the year

E = keplerSolver(e_GRACE1, meanAnomaly_GRACE1*radians);
trueAnomaly_GRACE1 = 2*atan(sqrt((1+e_GRACE1)/(1-e_GRACE1))*tan(E/2))*degrees;

if trueAnomaly_GRACE1 < 0
    trueAnomaly_GRACE1 = trueAnomaly_GRACE1 + 360;
end

h_GRACE1 = (((mu^2)*period_GRACE1/(2*pi))^(1/3))*sqrt(1-e_GRACE1^2);
[r_GRACE1,v_GRACE1] = orbitalElementsToStateVectors(h_GRACE1,e_GRACE1,...
    i_GRACE1,RAAN_GRACE1,argumentOfPerigee_GRACE1,trueAnomaly_GRACE1)

altitude_GRACE1_InKilometers = sqrt(dot(r_GRACE1,r_GRACE1)) - 6378


% Find Grace 1 State Vector with new time by Changing the meanAnomaly
time_GRACE1_2 = ((E - e_GRACE1*sin(E))/(meanMotion_GRACE1)) + (time_GRACE1 - time_GRACE1_Final)*seconds;
meanAnomalyP = time_GRACE1_2/period_GRACE1;
deltaTime = (meanAnomalyP - floor(meanAnomalyP))*period_GRACE1;
meanAnomaly_GRACE1_2 = (meanMotion_GRACE1)*deltaTime;
E = keplerSolver(e_GRACE1, meanAnomaly_GRACE1_2);
trueAnomaly_GRACE1_2 = 2*atan(sqrt((1+e_GRACE1)/(1-e_GRACE1))*tan(E/2))*degrees;
if trueAnomaly_GRACE1_2 < 0
    trueAnomaly_GRACE1_2 = trueAnomaly_GRACE1_2 + 360;
end

% New Orbital elements at the same time as Grace 2
[r_GRACE1_2,v_GRACE1_2] = orbitalElementsToStateVectors(h_GRACE1,e_GRACE1...
    ,i_GRACE1,RAAN_GRACE1,argumentOfPerigee_GRACE1,trueAnomaly_GRACE1_2)

altitude_GRACE1_2_InKilometers = sqrt(dot(r_GRACE1_2,r_GRACE1_2)) - 6378




%Find Grace 2 state vector
e_GRACE2 = .0020960;
i_GRACE2 = 89.0256; %degrees
RAAN_GRACE2 = 222.2919; %degrees
argumentOfPerigee_GRACE2 = 43.2866; %degrees
meanAnomaly_GRACE2 = 317.0043; %degrees
meanMotion_GRACE2 = 15.31232792*(2*pi/seconds); %rad/sec
period_GRACE2 = 2*pi/meanMotion_GRACE2; %seconds
time_GRACE2 = 343.90745732; %days of the year

%Solve keplers equation for the trueAnomaly
E = keplerSolver(e_GRACE2, meanAnomaly_GRACE2*radians);
trueAnomaly_GRACE2 = 2*atan(sqrt((1+e_GRACE2)/(1-e_GRACE2))*tan(E/2))*degrees;
if trueAnomaly_GRACE2 < 0
    trueAnomaly_GRACE2 = trueAnomaly_GRACE2 + 360;
end
h_GRACE2 = (((mu^2)*period_GRACE2/(2*pi))^(1/3))*sqrt(1-e_GRACE2^2);


[r_GRACE2,v_GRACE2] = orbitalElementsToStateVectors(h_GRACE2,e_GRACE2...
    ,i_GRACE2,RAAN_GRACE2,argumentOfPerigee_GRACE2,trueAnomaly_GRACE2)

altitude_GRACE2_InKilometers = sqrt(dot(r_GRACE2,r_GRACE2)) - 6378

deltaR = r_GRACE1_2-r_GRACE2;

%Find the distance between the satilites
DistanceApart_InKilometers = sqrt(dot(deltaR, deltaR))


%Find RTN components
[Rrtn_InKilometers] = relativePositionVectorsToRTN(r_GRACE2, v_GRACE2, r_GRACE1_2)






