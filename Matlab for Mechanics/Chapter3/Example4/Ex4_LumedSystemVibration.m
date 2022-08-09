%% Chapter-2 Example-4:
% lumped-mass system natural frequency & forced vibration

clc,clear

%% input
k1 = 10; % [N/mm] spring1 stiffness
k2 = 10; % [N/mm] spring2 stiffness

c = 5;   % [N.s/mm] damper coefficient

m1 = 2;  % [kg] lumped mass1
m2 = 2;  % [kg] lumped mass2

data.omega = 1.3;  % [rad/s] periodic force frequency
data.f0 = 100;     % [N] periodic force amplitude

tspan = [0 20];    % [s, s] simulation time

y0 = [0, 0, 0, 0]; % [mm, mm, mm/s, mm/s] initial condition

%% process
M = [m1, 0; 0, m2];
C = [0, 0; 0, c];
K = [k1+k2, -k2; -k2, k2];

data.P = [C, M; M, zeros(size(K))];
data.Q = [K, zeros(size(K)); zeros(size(K)), -M];

[modeShapeComplex, natFreqComplex] = eig(data.Q,-data.P);
natFreq = abs(diag(natFreqComplex));
modeShape = abs(modeShapeComplex(1:2,:));
modeShape = modeShape ./ ...
            repmat(max(modeShape),size(modeShape,1),1);

option = odeset('Mass',@(t,y)data.P);
odeFun = @(t,y)semiImpicitFty(t,y,data);

[t,y] = ode45(odeFun,tspan,y0,option);

%% visualization
disp('mode shape:')
disp(modeShape)
disp('natural frequency:')
disp(natFreq')

figure
cla, hold on, box on, grid on
plot(t,y(:,1))
plot(t,y(:,2),'--')
xlabel('time (sec)'), ylabel('mm')
legend({'x1','x2'})