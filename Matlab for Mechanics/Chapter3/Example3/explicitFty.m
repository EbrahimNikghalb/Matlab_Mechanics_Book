%% Chapter-3 Example-3 (1):
% F(t,y) for explicit method

function dydt = explicitFty(t,y,data)

m1 = data.m1;  
m2 = data.m2;  
l1 = data.l1;
l2 = data.l2;
g = data.g;

A = [(m1+m2)*l1, m2*l2*cos(y(2)-y(1));
      l2, l1*cos(y(2)-y(1))];
b = [m2*l2*(y(4)^2)*sin(y(2)-y(1))-(m1+m2)*g*sin(y(1));
    -l1*(y(3)^2)*sin(y(2)-y(1))-g*sin(y(2))];

u = A\b;

dydt = zeros(4,1);
dydt(1) = y(3);
dydt(2) = y(4);
dydt(3) = u(1);
dydt(4) = u(2);

end