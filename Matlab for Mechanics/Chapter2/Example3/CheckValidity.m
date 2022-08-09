%% Chapter-2 Example-3
% check the validity of spring parameter estimation

%% pre sun
Ex3_ParameterEstimation;
close all

%% post process

xsm = (0:0.1:12)';

x1 = x(1);
k1 = x(2);
k2 = x(3);

x1p_Estimated = xsm(xsm<=x1);
x2p_Estimated = xsm(xsm>=x1);

y1_Estimated = @(x)k1*x;
y2_Estimated = @(x)k2*x-k2*x1+k1*x1;

x1p_Estimated = [x1p_Estimated; x(1)];
x2p_Estimated = [x(1); x2p_Estimated];

y1p_Estimated = y1_Estimated(x1p_Estimated);
y2p_Estimated = y2_Estimated(x2p_Estimated);

%% visualization
figure
cla
hold on, box on, grid on
plot(spTestData(:,1),spTestData(:,2),'ok');
plot(x1p_Estimated,y1p_Estimated,'r')
plot(x2p_Estimated,y2p_Estimated,'r')
xlabel('displacement (mm)')
xlabel('force (N)')