% If 
clc
x = 2.5;
if x < -pi
    y = -x - pi;
else
    y = sin(x)./x;
end
disp(y)
