function a = semimajorAxisForRepeatingGroundtrack(daysUntilRepeat, orbitalRevolutions)

    mu = 398600;
    secondsInSiderealDay = 86164;

    a = ((sqrt(mu)*daysUntilRepeat*secondsInSiderealDay)/(2*pi*orbitalRevolutions))^(2/3);
end