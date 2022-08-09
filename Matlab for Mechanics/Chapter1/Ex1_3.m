% For loop, If
clc
x = linspace(-10,10,100);
for i = 1:100
    if x(i) < -pi
        y(i) = -x(i) - pi;
    else
        y(i) = sin(x(i))./x(i);
    end
end
plot(x, y)
