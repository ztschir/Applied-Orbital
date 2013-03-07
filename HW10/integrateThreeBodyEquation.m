function [R,V] = integrateThreeBodyEquation(r0,v0, t)

% Parameters of the system
muEarth = 398600.4415;
muMoon = muEarth/81.301;
r2 = 384400; %km assume constant with e = 0

% Set the time range
t0 = 0;     % Initial time [s]
tf = t;    % Final time [s]

X0 = [r0;v0];

% Set up the options
options = odeset('AbsTol',1E-10,'RelTol',1E-10);

% Call the integrator 
[t,r] = ode45(@xDotDotIntegrator,[t0,tf],X0,options,muEarth, muMoon, r2);

% Do something with the output

R = r(:,1:2);
V = r(:,3:4);

% Integrator
function [dR] = xDotDotIntegrator(t,RV, muEarth, muMoon, r2)
dR = zeros(2,1);

R = RV(1:2);
V = RV(3:4);

X = R(1);
Y = R(2);
XDot = V(1);
YDot = V(2);

wc = ((muEarth + muMoon)/(r2^3))^(1/2);

dX = (-muEarth*X)/(sqrt(X^2 + Y^2)^3) + muMoon*((r2-X)/(sqrt((r2-X)^2 + Y^2)^3) - (1/(r2^2))) + X*(wc^2) + 2*YDot*wc;
dY = (-muEarth*Y)/(sqrt(X^2 + Y^2)^3) + muMoon*((-Y)/(sqrt((r2-X)^2 + Y^2)^3)) + Y*(wc^2) - 2*XDot*wc;

dR(1:2) = [XDot; YDot];
dR(3:4) = [dX; dY];

