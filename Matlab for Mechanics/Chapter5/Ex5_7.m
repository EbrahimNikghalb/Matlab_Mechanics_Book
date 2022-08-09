% Controllability Of Inverted Pendulum
clc, clear
l = 0.5;  m = 0.3; c = 0.06; g = 9.8;               
 
A = [0 1; g/l -c/(m*l^2)];
B = [0; 1/(m*l^2)];
C = [1, 0];
D = 0;
 
Co = ctrb(A, B);
IsControllable = rank(Co) == length(A)
