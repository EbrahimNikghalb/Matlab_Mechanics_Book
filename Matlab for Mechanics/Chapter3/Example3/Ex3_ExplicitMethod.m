%% Chapter-3 Example-3 (1):
% discrete-mass dual pendulum 
% explicit form solution

clc,clear

%% input
data.m1 = 1;   %[kg] concentrate mass 1
data.m2 = 2;   %[kg] concentrate mass 2
data.l1 = 0.5; %[m] length of wire 1
data.l2 = 0.5; %[m] length of wire2
data.g = 9.82; %[m/s2] acceleration of gravity

tspan = [0, 10];            % [s, s] simulation time span
y0 = [20, 40, 0, 0]*pi/180; % [deg, deg, deg/s, deg/s] initial condition

%% proess
options = odeset('RelTol',1e-2);
odefun = @(t,y)explicitFty(t,y,data);
[t,y] = ode45(odefun,tspan,y0,options);

theta1 = y(:,1) * 180/pi;
theta2 = y(:,2) * 180/pi;

%% visualization
figure;
cla, hold on, box on, grid on
plot(t,theta1,'k');
plot(t,theta2,'--k');
xlabel('time (sec)')
ylabel('angle (deg)')
legend({'\theta1','\theta2'})