%% Chapter-3 Example-7:
% nonlinear equations for 'fsolve' function

function F = nonlinEquation(th,data)

F = [data.r1*sin(th(1)) + data.r2*sin(th(2)) + ...
     data.r3*sin(data.th3) + data.r4*sin(data.th4);
     data.r1*cos(th(1)) + data.r2*cos(th(2)) + ...
     data.r3*cos(data.th3) + data.r4*cos(data.th4)];
 
end