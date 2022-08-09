%% Chapter-3 Example-3 (2):
% M(t,y) for semi implicit method

function M = semiImpicitMty(t,y,data)

m1 = data.m1;  
m2 = data.m2;  
l1 = data.l1;
l2 = data.l2;

M = [1,0,0,0;
     0,1,0,0;
    0,0,(m1+m2)*l1, m2*l2*cos(y(2)-y(1));
    0,0, l2, l1*cos(y(2)-y(1))];

end