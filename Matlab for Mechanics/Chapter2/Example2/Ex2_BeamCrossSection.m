%% Chapter-2 Example-2:
% beam cross-section optimization 
% with nonlinear constraint & 3 design variable

clc, clear

%% input 
xLB = [50 70 1];   % [mm] x lower bound
xUB = [150 120 5]; % [mm] x upper bound
xInit = [50 70 1]; % [mm] x initial vector

%% process
option = optimoptions('fmincon',...
    'Algorithm','sqp',...
    'PlotFcn',@optimplotfval);

func = @(x) ...
    -(2*x(1).*x(3).^3+6*x(3).*x(1).*(x(2)+x(3)).^2+x(3).*x(2).^3)/12;

[x,fval,exitFlag] = fmincon( ...
    func,xInit,[],[],[],[],xLB,xUB,@nonlinConstraint,option);

%% visulization
disp(x)
disp(-fval)
disp(exitFlag)