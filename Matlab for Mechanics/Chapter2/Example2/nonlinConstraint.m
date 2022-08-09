%% Chapter-2 Example-2
% nonlinear constraint function

function [C,Ceq] = nonlinConstraint(x)

rhoL = 0.0156;   % [kg/mm2] density
mMax = 14;       % [kg] maximum mass

C(1) = (2*x(3)*x(1)+x(3)*x(2))-mMax/rhoL;
Ceq = [];

end