%% Chapter-3 Example-3 (2):
% F(t,y) for semi implicit method

function Mdydt = semiImplicitFty(t,y,data)

m1 = data.m1;  
m2 = data.m2;  
l1 = data.l1;
l2 = data.l2;
g = data.g;

Mdydt = zeros(4,1);
Mdydt(1) = y(3);
Mdydt(2) = y(4);
Mdydt(3) = m2*l2*(y(4)^2)*sin(y(2)-y(1))-(m1+m2)*g*sin(y(1));
Mdydt(4) = -l1*(y(3)^2)*sin(y(2)-y(1))-g*sin(y(2));

end