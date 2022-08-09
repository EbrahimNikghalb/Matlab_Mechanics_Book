%% Chapter-2 Example-4:
% F(t,y) for semi-implicit method

function Mdydt = semiImpicitFty(t,y,data)

omega = data.omega;
f0 = data.f0;
F = [f0*sin(omega*t);
     0]; 
R = [F;
     zeros(size(F))];
Mdydt = -data.Q*y + R;

end