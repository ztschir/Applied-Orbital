% Planet tranfer using Lambert's method
% input:
% r0 - Starting position vector
% rf - Final position vector
% deltat - transfer time between planets
% DM - Direction of motion

function [v0, vf] = lambertTransfer(r0Vec, rfVec, deltat0, mu)

    r0 = norm(r0Vec);
    rf = norm(rfVec);

    deltaV = acos(dot(r0Vec, rfVec)/(r0*rf));

    if deltaV < pi
        DM = 1;
    else
        DM = -1;
    end
    
    A = DM*((sqrt(r0*rf)*sin(deltaV))/sqrt(1-cos(deltaV)));
    
    if deltaV == 0 || A == 0
        fprintf('Can not find trajectory');
        return;
    end
    
    
    psi = 0;
    c2 = 1/2;
    c3 = 1/6;
    psiUp = 4*pi^2;
    psiLow = -4*pi;
    deltat = 0;
    
    
    while abs(deltat - deltat0) > 1e-6
        y = r0 + rf + A*(psi*c3 - 1)/sqrt(c2);

        if A > 0 && y < 0
            while y <= 0
                y = r0 + rf + A*(psi*c3 - 1)/sqrt(c2);
                psi = psi + .05;
                psiLow = psi;
            end
        end
                
        chi = sqrt(y/c2);
        deltat = ((chi^3)*c3 + A*sqrt(y))/sqrt(mu);
        
        if deltat <= deltat0
            psiLow = psi;
        else
            psiUp = psi;
        end
        
        psi = (psiUp + psiLow)/2;
        
        if psi > 1e-6
            c2 = (1-cos(sqrt(psi)))/psi;
            c3 = (sqrt(psi)-sin(sqrt(psi)))/sqrt(psi^3);
        else
            c2 = 1/2;
            c3 = 1/6;
        end
    end
    
    f = 1 - y/r0;
    gDot = 1 - y/rf;
    g = A*sqrt(y/mu);
    
    v0 = (rfVec - f*r0Vec)/g;
    vf = (gDot*rfVec - r0Vec)/g;
        
    
end