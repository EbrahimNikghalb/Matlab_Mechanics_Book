clear, clc

m = 3.2; l = 0.5; c = 0.4; g = 9.8;

G = tf(1,[m*l^2, c, m*g*l]);
C = tf(1,[1,0]);

SYS = C*G;

rlocus(SYS)

