clc, clear

a1 = 4.23; b1 = 1.89; c1 = 5.37;
a2 = 5.37; b2 = 3.56; c2 = 3.96;
a3 = 1.99; b3 = 3.96; c3 = 2.72;

S1 = Heron(a1, b1, c1);
S2 = Heron(a2, b2, c2);
S3 = Heron(a3, b3, c3);

S = S1 + S2 + S3