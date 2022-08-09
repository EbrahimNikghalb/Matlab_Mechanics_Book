% Inverted Pendulum
clear, clc
 
l = 0.5;  m = 0.3; c = 0.06; g = 9.8;               
 
A = [0 1; g/l -c/(m*l^2)];
B = [0; 1/(m*l^2)];
C = [1, 0];
D = 0;
 
SYS = ss(A, B, C, D);
K = place(A, B, [-10+8i,-10-8i]);
 
SYSc = ss(A-B*K, B, C, D);
step(SYSc)
