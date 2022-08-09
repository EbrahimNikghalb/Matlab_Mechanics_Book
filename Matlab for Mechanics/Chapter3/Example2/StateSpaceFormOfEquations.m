clc, clear 
syms th_1 th_2  Dth_1 Dth_2  DDth_1 DDth_2 
syms l_1 l_2 m_1 m_2 J_1 J_2  g t 
%% State Space formalation of system dynamic equation
X = sym('x_',[1 4]);
load Equations
tic
A11 = simplify(diff(Eq_1,DDth_1));
A12 = simplify(diff(Eq_1,DDth_2));
B1  = -simplify(Eq_1 - (A11*DDth_1+A12*DDth_2));

%%

A21 = simplify(diff(Eq_2,DDth_1));
A22 = simplify(diff(Eq_2,DDth_2));
B2  = -simplify(Eq_2 - (A21*DDth_1+A22*DDth_2));

%%
tic
TH1 = simplify((B1*A22-B2*A12)/(A11*A22-A12*A21));
TH2 = simplify((A11*B2-A21*B1)/(A11*A22-A12*A21));

fprintf('TH1 and TH2 has been obtained!  ||');toc;fprintf('\n')
%% Nonlinear State Space Equation
tic
F0(1) = Dth_1;
F0(2) = Dth_2;
F0(3) = TH1;
F0(4) = TH2;

X0 = [th_1, th_2, Dth_1, Dth_2];

X = [sym('x_',[1 4])]; F = subs(F0, X0, X);

save('SS_NonLin','F','X');
fprintf('F and X has been constructed!   ||');toc;fprintf('\n')
