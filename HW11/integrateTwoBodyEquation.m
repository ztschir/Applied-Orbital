function [R,V,tfin] = integrateTwoBodyEquation(r0, v0, tf, mu)

% Set the time range
t0 = 0;     % Initial time [s]

X0 = [r0;v0];

% Set up the options
options = odeset('AbsTol',1E-6,'RelTol',1E-6);

% Call the integrator for inital setup

[t,r] = ode45(@integrator,[t0,tf],X0,options,mu);

% Do something with the output

R = r(:,1:3);
V = r(:,4:6);
r0 = r(end,1:3);
v0 = r(end,4:6);

X0 = [r0';v0'];
t0 = t(end);
tfin = t;


%Ideal Integrator
function [dX] = integrator(t,X, mu)
dX = zeros(2,1);

R = X(1:3);
V = X(4:6);

dV = -(mu/(norm(R)^3))*R;

dX(1:3) = V;
dX(4:6) = dV;

