% Top level script
clc;
clear all;


%For question 2 part b

r0 = [192200; 332900.165];
v0 = [0;0];
t = 430218.8;
[R,V] = integrateThreeBodyEquation(r0,v0, t);

%plot(R(:,1), R(:,2));


%For question 2 part c

r0 = [-2766.61; -6042.12];
v0 = [9.86; -4.52];
t = 430218.8;

[R,V] = integrateThreeBodyEquation(r0,v0, t);

missDistance = sqrt(R(end,1)^2 + R(end,2)^2) - 384400

endVelocity = sqrt(V(end,1)^2 + V(end,2)^2)

plot(R(:,1), R(:,2));
hold on;

%Plot orbit of moon
x = 0;
y = 0;
r = 384400;

ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
plot(x+xp,y+yp);

