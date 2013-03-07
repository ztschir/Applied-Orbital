a = 6978; %KM
e = 0;
i = 97.7; %Degrees
perigee = 0; %Degrees
trueAnomalyVec = 0:1:359;
earthRad = 6371; %KM


%Vernal Equinox
uSun = [1,0,0];
RAAN = 270;

for trueAnomaly = trueAnomalyVec
    [rX, rY, rZ] = RightAscnFrameToECEF(a,i,e,RAAN,perigee,trueAnomaly);
    rSat = [rX, rY, rZ];
    rSatNorm = norm(rSat);
    cosineAlpha = dot(uSun, rSat)/rSatNorm;
    if(cosineAlpha < 0)
        sineAlpha = 1-cosineAlpha^2;
        if(rSatNorm*sineAlpha < earthRad);
            fprintf('Found possible satellite eclipse during Vernal Equinox at trueAnomaly = %d\n', trueAnomaly);
        end
    end
end

%Summer Solstice
uSun = [0,0.69,0.31];
RAAN = 0;

for trueAnomaly = trueAnomalyVec
    [rX, rY, rZ] = RightAscnFrameToECEF(a,i,e,RAAN,perigee,trueAnomaly);
    rSat = [rX, rY, rZ];
    rSatNorm = norm(rSat);
    cosineAlpha = dot(uSun, rSat)/rSatNorm;
    if(cosineAlpha < 0)
        sineAlpha = 1-cosineAlpha^2;
        if(rSatNorm*sineAlpha < earthRad);
            fprintf('Found possible satellite eclipse during Summer Solstice at trueAnomaly = %d\n', trueAnomaly);
        end
    end
    
end

%Autumnal Equinox
uSun = [-1,0,0];
RAAN = 90;

for trueAnomaly = trueAnomalyVec
    [rX, rY, rZ] = RightAscnFrameToECEF(a,i,e,RAAN,perigee,trueAnomaly);
    rSat = [rX, rY, rZ];
    rSatNorm = norm(rSat);
    cosineAlpha = dot(uSun, rSat)/rSatNorm;
    if(cosineAlpha < 0)
        sineAlpha = 1-cosineAlpha^2;
        if(rSatNorm*sineAlpha < earthRad);
            fprintf('Found possible satellite eclipse during Autumnal Equinox at trueAnomaly = %d\n', trueAnomaly);
        end
    end
    
end

%Winter Solstice
uSun = [0,-0.69,-0.31];
RAAN = 180;

for trueAnomaly = trueAnomalyVec
    [rX, rY, rZ] = RightAscnFrameToECEF(a,i,e,RAAN,perigee,trueAnomaly);
    rSat = [rX, rY, rZ];
    rSatNorm = norm(rSat);
    cosineAlpha = dot(uSun, rSat)/rSatNorm;
    if(cosineAlpha < 0)
        sineAlpha = 1-cosineAlpha^2;
        if(rSatNorm*sineAlpha < earthRad);
            fprintf('Found possible satellite eclipse during Winter Solstice at trueAnomaly = %d\n', trueAnomaly);
        end
    end
    
end