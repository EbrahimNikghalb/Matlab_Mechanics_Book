%% Chapter-3 Example-7:
% 4-link mechanism kinematics solution

clc, clear

%% input
data.r1 = 45;     % [mm] link1 length
data.r2 = 70;     % [mm] link2 length
data.r3 = 15;     % [mm] link3 length
data.r4 = 70;     % [mm] link4 length
data.th4 = 170;   % [deg] link4 angle

th3Init = 195;              % [deg] link 3 (driver) initial angle
thInit = [49.644; 321.221]; % [deg] link 2 & 3 initial angle
dTh = 2;                    % [deg] angle incerement

%% pre process
data.th4 = data.th4 * pi/180;
thInit = thInit * pi/180;

Th3 = th3Init + (1:dTh:360);
Th3 = Th3 * pi/180;

%% process
options = optimoptions('fsolve',...
                       'Tolx',1e-5,...
                       'Display','off');
                   
thSolution = zeros(2,numel(Th3));

for j = 1:numel(Th3)
    data.th3 = Th3(j);
    fun = @(th)nonlinEquation(th,data);
    thSolution(:,j) = fsolve(fun,thInit,options);
    thInit = thSolution(:,j);
end

%% post process

mechEfficiency = gradient(thSolution(1,:),dTh*pi/180);

plotPoints = zeros(4,2);
plotPoints(4,1) = -data.r4*cos(data.th4);
plotPoints(4,2) = -data.r4*sin(data.th4);

plotPoints(2,:) = [data.r1*cos(thSolution(1,j)), ...
                   data.r1*sin(thSolution(1,j))];
             
plotPoints(3,:) = plotPoints(2,:) + ...
                  [data.r2*cos(thSolution(2,j)), ...
                  data.r2*sin(thSolution(2,j))];

%% visuallization
figure(1)
subplot(2,1,1)
cla, hold on, box on, grid on
plot(Th3*180/pi,thSolution(1,:)*180/pi)
plot(Th3*180/pi,thSolution(2,:)*180/pi,'--')
xlim([Th3(1) Th3(end)]*180/pi)
xlabel('\theta_3 [deg]')
ylabel('\theta [deg]')
legend({'\theta_1','\theta_2'})
subplot(2,1,2)
cla, hold on, box on, grid on
plot(Th3*180/pi,mechEfficiency)
xlim([Th3(1) Th3(end)]*180/pi)
xlabel('\theta_3 [deg]')
ylabel('d\theta_1/d\theta_3')
title('Mechanical Efficiency')

figure(2)
plot(plotPoints(:,1),plotPoints(:,2),'-o','LineWidth',2)
hold on, axis equal, box on
axis([-10 90 -30 50])
ax = gca;
ax.NextPlot = 'replacechildren';

for j = 1:numel(Th3)
    
    plotPoints(2,:) = [data.r1*cos(thSolution(1,j)), ...
        data.r1*sin(thSolution(1,j))];
    
    plotPoints(3,:) = plotPoints(2,:) + ...
                      [data.r2*cos(thSolution(2,j)), ...
                      data.r2*sin(thSolution(2,j))];
    
    plot(plotPoints(:,1),plotPoints(:,2),'-o','LineWidth',2)           
    
    drawnow            
end