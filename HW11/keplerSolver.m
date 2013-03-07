function E = keplerSolver(e, meanAnomaly)

    E = meanAnomaly - e*sin(meanAnomaly);
    
    M = E - e*sin(E) - meanAnomaly ;
    Mprime = 1 - e*cos(E);
    
    while (abs(M/Mprime) > 10^-8)
       E = E - M/Mprime;
       M = E - e*sin(E) - meanAnomaly ;
       Mprime = 1 - e*cos(E); 
    end
end