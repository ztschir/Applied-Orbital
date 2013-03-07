function [R,V] = integrateFourBodyEquation(r0,v0, t, muEarth, muMars, muSun, r2, r3)

% Parameters of the system

% Set the time range
t0 = 0;     % Initial time [s]
tf = t;    % Final time [s]

X0 = [r0;v0];

% Set up the options
options = odeset('AbsTol',1E-4,'RelTol',1E-4);

% Call the integrator 
[t,r] = ode45(@xDotDotIntegrator,[t0,tf],X0,options,muEarth, muMars, muSun, r2, r3);

% Do something with the output

R = r(:,1:2);
V = r(:,3:4);

% Integrator
function [dR] = xDotDotIntegrator(t,RV, muEarth, muMars, muSun, r2, r3)
dR = zeros(2,1);

R = RV(1:2);
V = RV(3:4);

X = R(1);
Y = R(2);
XDot = V(1);
YDot = V(2);

if abs(norm(R) - r2) < abs(norm(R) - r3)
    if abs(norm(R) - r2) < 10000
        dR(3:4) = -(muSun/(norm(R)^3))*R;
    else
        wc = ((muEarth + muSun)/(r2^3))^(1/2);
        dX = (-muSun*X)/(sqrt(X^2 + Y^2)^3) + muEarth*((r2-X)/(sqrt((r2-X)^2 + Y^2)^3) - (1/(r2^2))) + X*(wc^2) + 2*YDot*wc;
        dY = (-muSun*Y)/(sqrt(X^2 + Y^2)^3) + muEarth*((-Y)/(sqrt((r2-X)^2 + Y^2)^3)) + Y*(wc^2) - 2*XDot*wc;
        dR(3:4) = [dX; dY];
    end
else
    if abs(norm(R) - r3) < 10000
        dR(3:4) = -(muSun/(norm(R)^3))*R;
    else
        wc = ((muMars + muSun)/(r2^3))^(1/2);
        dX = (-muSun*X)/(sqrt(X^2 + Y^2)^3) + muMars*((r2-X)/(sqrt((r2-X)^2 + Y^2)^3) - (1/(r2^2))) + X*(wc^2) + 2*YDot*wc;
        dY = (-muSun*Y)/(sqrt(X^2 + Y^2)^3) + muMars*((-Y)/(sqrt((r2-X)^2 + Y^2)^3)) + Y*(wc^2) - 2*XDot*wc;
        dR(3:4) = [dX; dY];
    end
end

dR(1:2) = [XDot; YDot];


