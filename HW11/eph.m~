function [a,e,i,W,w,v] = eph(planet,JD)

% EPH    Planetary ephemerides
%
% [a,e,i,W,w,v] = eph(PLANET,JD)
%
% Inputs:
% PLANET: Position of the planet from the Sun.  
%           Earth = 3
%           Mars  = 4
% JD: Julian date
%
% Outputs:
% a: heliocentric semimajor axis [km]
% e: heliocentric eccentricity
% i: heliocentric inclination [deg]
% W: heliocentric right ascension of ascending node [deg]
% w: heliocentric argument of perihelion [deg]
% v: heliocentric true anomaly [deg]
% 
% Nick Bradley
% ASE 366L TA
% Spring 2012

T = (JD - 2451545.0) / 36525;   % Julian centuries from J2000.0 epoch

% ====Coefficients====
switch planet
    case 3      % Earth
        Lc = [100.466449 35999.3728519 -0.00000568 0.0];                % [deg]
        ac = [1.000001018 0 0 0] * 1.4959965E8;                         % [km]
        ec = [0.01670862 -0.000042037 -0.0000001236 0.00000000004];
        ic = [0.0 0.0130546 -0.00000931 -0.000000034];                  % [deg]
        Wc = [174.873174 -0.2410908 0.00004067 -0.000001327];           % [deg]
        Pc = [102.937348 0.3225557 0.00015026 0.000000478];             % [deg]
    case 4      % Mars
        Lc = [355.433275 19140.2993313 0.00000261 -0.000000003];        % [deg]
        ac = [1.523679342 0 0 0] * 1.4959965E8;                         % [km]
        ec = [0.09340062 0.000090483 -0.0000000806 -0.00000000035];
        ic = [1.849726 -0.0081479 -0.00002255 -0.000000027];            % [deg]
        Wc = [49.558093 -0.2949846 -0.00063993 -0.000002143];           % [deg]
        Pc = [336.060234 0.4438898 -0.00017321 0.000000300];            % [deg]
    otherwise
        error('This planet is not defined for the EPH function');
end

% ====Keplerian elements====
L = Lc(1) + Lc(2)*T + Lc(3)*T^2 + Lc(4)*T^3;    % Mean longitude
a = ac(1) + ac(2)*T + ac(3)*T^2 + ac(4)*T^3;    % Semimajor axis
e = ec(1) + ec(2)*T + ec(3)*T^2 + ec(4)*T^3;    % Eccentricity
i = ic(1) + ic(2)*T + ic(3)*T^2 + ic(4)*T^3;    % Inclination
W = Wc(1) + Wc(2)*T + Wc(3)*T^2 + Wc(4)*T^3;    % Long. of asc. node
P = Pc(1) + Pc(2)*T + Pc(3)*T^2 + Pc(4)*T^3;    % Long. of perihelion

% Convert to radians
L = L*pi/180;
W = W*pi/180;
P = P*pi/180;

w = P-W;    % Argument of perihelion
M = L-P;    % Mean anomaly

Ccen = (2*e-e^3/4+5/96*e^5)*sin(M) + (5/4*e^2-11/24*e^4)*sin(2*M) + ...
       ((13/12)*e^3-43/64*e^5)*sin(3*M) + (103/96)*e^4*sin(4*M) + ...
       (1097/960)*e^5*sin(5*M);
   
v = M+Ccen; % True anomaly

L = L*180/pi;
W = W*180/pi;
P = P*180/pi;
v = v*180/pi;
w = w*180/pi;