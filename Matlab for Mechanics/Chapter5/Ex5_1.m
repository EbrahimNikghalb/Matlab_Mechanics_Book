clear, clc

m = 3.2;               % [kg] Mass
l = 0.5;               % [m]   Pendulum Length
c = 0.4;               % [Nms] Angular Damping Ratio
g = 9.8;               % [m/s^2]    Gravity

G = tf(1,[m*l^2, c, m*g*l]);
P = pole(G)
step(G)