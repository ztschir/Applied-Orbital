function [declination, rightAscension] = positionVecToRAandDec(R)

    r = norm(R);
    
    l = R(1)/r;
    m = R(2)/r;
    n = R(3)/r;
    
    declination = asind(n);
    
    
    if m > 0   
        rightAscension = acosd(l/cosd(declination));
    else
        rightAscension = 360 - acosd(l/cosd(declination));
    end

end