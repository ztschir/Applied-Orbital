


a = 8000;
tfVec = 0:0.5:20;
x0 = 110;
y0 = 0;


mu = 398600;
T = 2*pi/sqrt(mu)*a^1.5;
n = 2*pi/T;

i = 1;
for tf = tfVec*60
    C = cos(n*tf);
    S = sin(n*tf);

    yDot0(i) = ((6*n*S*(n*tf - S) - 2*n*(4-3*C)*(1-C))*x0 - n*S*y0)...
            / (S*(4*S-3*n*tf)+ 4*(1-C)^2);
        
    xDot0(i) = -(n*(4-3*C)*x0 + 2*(1 - C)*yDot0(i))/S;
    i = i + 1;
end

i = 1;
tf = 20*60;
for t = tfVec*60
    C = cos(n*t);
    S = sin(n*t);    
    
%    x(i) = (4-3*C)*x0 + (S*xDot0(i))/n + (2/n)*(1-C)*yDot0(i);
%    y(i) = 6*(S - n*tf)*x0 + y0 - (2/n)*(1-C)*xDot0(i) + ((4*S - 3*n*tf)/n)*yDot0(i);
r0 = [x0 y0 0 xDot0(end) yDot0(end) 0]';
K = [4-3*C 0 0 S/n (2/n)*(1-C) 0;
     6*(S-n*t) 1 0 -(2/n)*(1-C) (4*S-3*n*t)/n 0;
     0 0 C 0 0 S/n;
     3*n*S 0 0 C -2*S 0;
     -6*n*(1-C) 0 0 -2*S 4*C-3 0;
     0 0 -n*S 0 0 C];

R = K*r0;
x(i) = R(1);
y(i) = R(2);
 
i = i + 1;
end

hold on;

plot(x, y);
title('x vs. y');
xlabel('x (km)');
ylabel('y (km)');

% hold on;
% 
% plot(tfVec, yDot0);
% title('Time vs. yDot0');
% xlabel('Time (min)');
% ylabel('yDot0 (km)');
% 
% figure('Name', 'Time vs. xDot0');
% plot(tfVec, xDot0);
% title('Time vs. xDot0');
% xlabel('Time (min)');
% ylabel('xDot0 (km)');