clear all; clc;


%Script for Homework 7
degrees = 180/pi;
radians = pi/180;
mu = 398600;
seconds = 86164;

%Given variables

e = 0.0013;
i=63.4;
RAAN=0;
perigee=0;
meanAnomaly0=0;


daysUntilRepeat = 8;
orbitalRevolutions = 121;


%Problem A: Determine semimajor axis

a = semimajorAxisForRepeatingGroundtrack(daysUntilRepeat, orbitalRevolutions)


%Problem B: Determine ECI inital pos/vel
meanMotion = (orbitalRevolutions/daysUntilRepeat)*(2*pi/seconds); %rad/sec
period = 2*pi/meanMotion;

%Determine angular Velocity
h = (((mu^2)*period/(2*pi))^(1/3))*sqrt(1-e^2);

%Determine true Anomaly
E = keplerSolver(e, meanAnomaly0*radians);
trueAnomaly0 = 2*atan(sqrt((1+e)/(1-e))*tan(E/2))*degrees;

if trueAnomaly0 < 0
    trueAnomaly0 = trueAnomaly0 + 360;
end

%Since this is the initial time, then ECEF is ECI.
[r0, v0] = RightAscnFrameToECEF(a,i,e,h,RAAN,perigee,trueAnomaly0)

%Integerate orbit without drag
[R,V,t] = integrateTwoBodyEquation(r0, v0, orbitalRevolutions, 0);

[declination, rightAscension] = positionVecToRAandDec(ECIToECEF(R(1,:), t(1), 0));
totDec = declination;
totRA = rightAscension;
for i = 1:size(R(:,1))-1
    [declination, rightAscension] = positionVecToRAandDec(ECIToECEF(R(i,:), t(i), 0));
    totDec = [totDec ; declination];
    totRA = [totRA ; rightAscension];
end

% Check to see if the Declination and Right Ascension values are the same
% at the beginning and the end of the orbit.
NoDragInitalDeclination = totDec(1)
NoDragEndDeclination = totDec(end)
NoDragInitalRightAscension = totRA(1)
NoDragEndRightAscension = totRA(end)

%plot the ground track 
%figure('Name','Ground Track','NumberTitle','off')
%plot(totRA, totDec, '-b');




%Integerate orbit with drag
[R,V,t] = integrateTwoBodyEquation(r0, v0, orbitalRevolutions, 1);

x = R(:,1);
y = R(:,2);
z = R(:,3);

figure('Name','R vs. t with Drag','NumberTitle','off')
subplot(3,1,1), plot(t,x,'-b')
title('X position vs. time');

%figure('Name','Y vs. t','NumberTitle','off')
subplot(3,1,2), plot(t,y,'-b')
title('Y position vs. time');

%figure('Name','Z vs. t','NumberTitle','off')
subplot(3,1,3), plot(t,z,'-b')
title('Z position vs. time');

[declination, rightAscension] = positionVecToRAandDec(ECIToECEF(R(1,:), t(1), 0));
totDec = declination;
totRA = rightAscension;
for i = 1:size(R(:,1))-1
    [declination, rightAscension] = positionVecToRAandDec(ECIToECEF(R(i,:), t(i), 0));
    totDec = [totDec ; declination];
    totRA = [totRA ; rightAscension];
end

% Check to see if the Declination and Right Ascension values are the same
% at the beginning and the end of the orbit.
DragInitalDeclination = totDec(1)
DragEndDeclination = totDec(end)
DragInitalRightAscension = totRA(1)
DragEndRightAscension = totRA(end)

%plot the ground track 
figure('Name','Ground Track','NumberTitle','off');
plot(totRA, totDec, '-b');
title('Ground track for drag orbit');

%plot RA and Dec
figure('Name','Declination and Ascension over time for drag orbit','NumberTitle','off');
subplot(2,1,1), plot(t, totDec, '-b');
title('Declination over time for drag orbit');
subplot(2,1,2), plot(t, totRA, '-b');
title('Right Ascension over time for drag orbit');


DifferenceInRightAscendingNodePostions = NoDragEndRightAscension - DragEndRightAscension




