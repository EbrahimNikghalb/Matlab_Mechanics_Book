%% Chapter-2 Example-3
% objective function for parameter estimation of dual-rate spring

function f = paramEstObjFunc(x,Data)

disp = Data(:,1);
force = Data(:,2);

IndexK1 = disp <= x(1);
IndexK2 = ~IndexK1;

ForceK1 = x(2)*disp(IndexK1);
ForceK2 = x(3)*disp(IndexK2)-x(3)*x(1)+x(2)*x(1);

f = sum(abs(ForceK1-force(IndexK1))) + ...
    sum(abs(ForceK2-force(IndexK2)));

end