% Tracking Control of Inverted Pendulum]
clc, clear
l = 0.5;  m = 0.3; c = 0.06; g = 9.8;               
 
A = [0 1; g/l -c/(m*l^2)];
B = [0; 1/(m*l^2)];
C = [1, 0];
D = 0;
 
Az = [A,  zeros(2,1); -C 0]; 
Bz = [B; 0];
Cz = [C, 0];
Dz = 0;
 
P1 = -4; P2 = -2+8i; P3 = -2-8i;
K = place(Az, Bz, [-4, -2+8i, -2-8i]);
 
Acl = Az - Bz*K;
Bcl = [zeros(2,1);1];
Ccl = Cz;
Dcl = Dz;
 
SYScl = ss(Acl, Bcl, Ccl, Dcl);
step(SYScl)
