%% Chapter-3 Example-6:
% finite length string time response with initial condition
% compute response time with mode-shape
% this code need 'Ex5_StringNaturalFrequency' in the current path to run

clc, clear

%% pre-run
Ex5_StringNaturalFrequency;
close all

%% input
ts = 5;      % [sec] simulation time
dt = 0.02;   % [sec] time discretization
noMode = 15; % number of mode to calculate time response
U0_1 = 0.05*sin(pi*x/L);          % [mm] initial condition 1
U0_2 = (0.5*x).*(x<=L/10) + ...
       ((-5/90)*(x-L)).*(x>L/10); % [mm] initial condition 2
U0 = U0_2;
   
%% process
t = 0:dt:ts;
eigVtres = eigV(:,1:noMode);
coeffj = zeros(noMode,1);
Uxt = zeros(size(eigVtres,1),numel(t));

for j = 1:noMode
    coeffj(j) = trapz(x,eigVtres(:,j).*U0)/...
                trapz(x,eigVtres(:,j).^2);
end

for i = 1:numel(t)
    for j = 1:noMode
        Uxt(:,i) = Uxt(:,i) + ...
                   coeffj(j)*eigVtres(:,j)*cos(eigD(j)*t(i));
    end
end

%% visualization
figure(1)
subplot(1,2,1), cla, hold on, box on
plot(x,U0,'k','lineWidth',1)
plot(x,Uxt(:,1),'--k','lineWidth',2)
axis([0 L 0 0.06])
xlabel('x (mm)'),ylabel('u (mm)')
legend({'initial condition','estimated by mode'})

subplot(1,2,2), cla
bar(coeffj)
xlabel('mode coefficient number')

figure(2)
plot(x,U0)
plot(x,Uxt(:,1))
axis([0 L -0.1 0.1])
ax = gca;
ax.NextPlot = 'replacechildren';
for i = 2:numel(t)
    plot(x,Uxt(:,i))
    drawnow            
end