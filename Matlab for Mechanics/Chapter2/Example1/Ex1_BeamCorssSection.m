%% Chapter-2 Example-1:
% beam cross-section optimization 
% linear constraint & 2 design variable

clc, clear

%% input
t = 3;           % [mm] thickness
rhoL = 0.0156;   % [kg/mm2] density
mMax = 14;       % [kg] maximum mass

xLB = [50 70];   % [mm] x lower bound
xUB = [150 120]; % [mm] x upper bound
xInit = [50 70]; % [mm] x initial vector

%% process
A = rhoL*[2*t t;0 0];
b = [mMax; 0];

option = optimoptions('fmincon',...
    'Algorithm','sqp',...
    'PlotFcn',@optimplotfval);

func = @(x)-(2*x(1).*t.^3+6*t.*x(1).*(x(2)+t).^2+t.*x(2).^3)/12;
[x,fval,exitFlag] = fmincon(func,xInit,A,b,[],[],xLB,xUB,[],option);

%% visulization
disp(x)
disp(-fval)
disp(exitFlag)