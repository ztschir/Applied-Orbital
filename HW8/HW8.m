clear all; clc;

% Assume PRN 09 GPS orbit characteristics for year 2000
% also just assume the location of the user is on the Northern Hemisphere
% with a random latitude in the given range.

mu = 398600;
degrees = 180/pi; %convert to degrees
radians = pi/180; %convert to radians

a = 26559.3; %Km
e = 0.0098;
i = 54; %Degrees
RAAN = 175.7; %Degrees
argumentOfPerigee = 32.3; %degrees
meanAnomaly = 103.0 - argumentOfPerigee;
period = 43082; %seconds


% Given values for problem 1
elevation = 0; %degrees
azimuth = 25; %degrees


E = keplerSolver(e, meanAnomaly*radians);
trueAnomaly = 2*atan(sqrt((1+e)/(1-e))*tan(E/2))*degrees;

if trueAnomaly < 0
    trueAnomaly = trueAnomaly + 360;
end

h = (((mu^2)*period/(2*pi))^(1/3))*sqrt(1-e^2);
[r,v] = orbitalElementsToStateVectors(h,e,i,RAAN,argumentOfPerigee,...
    trueAnomaly);



% Convert UTC and DOY to a Julian date, Assume year is 2000.

year = 2000;
month = 3; %March
day = 1;
hour = 7.75;

localSiderealTime = convertUTCAndDOYToSiderealTimeInDegreesAtGreenwich(...
    year, month, day, hour);

% Need to find users position
