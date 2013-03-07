clear all; clc;

a = 6678; %KM
e = 0;
i = 97.7; %Degrees
perigee = 0; %Degrees
trueAnomalyVec = 0:1:359;
RAANVec = 270:180/365:(270+180);
earthRad = 6371; %KM

mu = 398600;

n = sqrt(mu/a^3);
period = 2*pi/n;

maxCounterInEclipse = 0;
dayOfMaxEclipse = 0;
dayOfYear = 80; %March 20th

%Find any eclipse
for RAAN = RAANVec

    RAANCorrection = mod(RAAN, 360);
    
    degreeOfSunECI = mod(RAANCorrection + 90, 360); % degrees, works because this is sun-synch.
    
    
    uSunX = cosd(degreeOfSunECI);
    uSunY = cosd(23.44)*sind(degreeOfSunECI);
    uSunZ = sind(23.44)*sind(degreeOfSunECI);                        
    uSun = [uSunX,uSunY,uSunZ];
    uSunNorm = uSun./norm(uSun);

    counterOfDegreesInEclipse = 0;
    for trueAnomaly = trueAnomalyVec
        [rX, rY, rZ] = RightAscnFrameToECI(a,i,e,RAANCorrection,perigee,trueAnomaly);
        rSat = [rX, rY, rZ];
        rSatNorm = norm(rSat);
        cosineAlpha = dot(uSunNorm, rSat)/rSatNorm;
        
        if(cosineAlpha < 0)
            sineAlpha = 1-cosineAlpha^2;
            if(rSatNorm*sineAlpha < earthRad);
                counterOfDegreesInEclipse = counterOfDegreesInEclipse + 1;
            end
        end
    end
    if counterOfDegreesInEclipse > 0
       fprintf('Found possible satellite eclipse at day %d of year\n', dayOfYear);   
    end
    if maxCounterInEclipse < counterOfDegreesInEclipse
        maxCounterInEclipse = counterOfDegreesInEclipse;
        dayOfMaxEclipse = dayOfYear;
    end
      dayOfYear = dayOfYear + 1;

end


MaxTimeSpentInEclipse = maxCounterInEclipse*(period/360)

