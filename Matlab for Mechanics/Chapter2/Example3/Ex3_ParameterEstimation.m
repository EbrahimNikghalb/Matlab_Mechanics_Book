%% Chapter-2 Example-3:
% dual-rate spring parameter estimation

clc, clear

%% input
spTestData = xlsread('SpringTestData',1);

xLB = [2 15 18];
xUB = [8 25 30];
xInitial = [3 16 17];

%% process
option = optimoptions('fmincon',...
    'Algorithm','sqp',...
    'PlotFcn',@optimplotfval);
    
func = @(x)paramEstObjFunc(x, spTestData);

[x, fval, exitFlag] = fmincon(...
    func,xInitial,[],[],[],[],xLB,xUB,[],option);

%% visualization
disp(x)
disp(exitFlag)