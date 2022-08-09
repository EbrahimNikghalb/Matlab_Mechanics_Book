clc, clear 
syms th_1 th_2  Dth_1 Dth_2  DDth_1 DDth_2 
syms l_1 l_2 m_1 m_2 J_1 J_2  g t 

%% Kinetic and Potential Energy
T1 = 1/2*J_1*Dth_1^2 +1/2*m_1*(l_1/2*Dth_1)^2;

Vc2_x = l_1*Dth_1*cos(th_1) + l_2/2*(Dth_1 + Dth_2)*cos(th_1+th_2);
Vc2_y = l_1*Dth_1*sin(th_1) + l_2/2*(Dth_1 + Dth_2)*sin(th_1+th_2);
Vc2 = sqrt(Vc2_x^2 + Vc2_y^2); 
T2 = 1/2*J_2*(Dth_1+Dth_2)^2+1/2*m_2*Vc2^2;

T = T1 + T2;

V1 = m_1*g*l_1*(1-cos(th_1))/2;
V2 = m_2*g*(l_1*(1-cos(th_1))+l_2*(1-cos(th_1+th_2))/2);
V = V1 + V2;

L = T - V;

%% Calculation of L_Dth and L_th
L_Dth_1 = diff(L, Dth_1);
L_th_1  = diff(L,  th_1);

L_Dth_2 = diff(L, Dth_2);
L_th_2  = diff(L,  th_2);

%% Calculation of  d/dt( L_Dth )
L_Dth_1         = subs(L_Dth_1, {'th_1', 'Dth_1'}, {'th_1(t)', 'diff(th_1(t),t)'});
L_Dth_1         = subs(L_Dth_1, {'th_2', 'Dth_2'}, {'th_2(t)', 'diff(th_2(t),t)'});
L_Dth_1_fun     = symfun(L_Dth_1, t);
L_Dth_1_fun_t   = diff(L_Dth_1_fun, t);
L_Dth_1_t0      = subs(L_Dth_1_fun_t, {'th_1(t)', 'diff(th_1(t),t)', 'diff(th_1(t),t,t)'}, {'th_1', 'Dth_1', 'DDth_1'});
L_Dth_1_t       = subs(L_Dth_1_t0,    {'th_2(t)', 'diff(th_2(t),t)', 'diff(th_2(t),t,t)'}, {'th_2', 'Dth_2', 'DDth_2'});

L_Dth_2         = subs(L_Dth_2, {'th_1', 'Dth_1'}, {'th_1(t)', 'diff(th_1(t),t)'});
L_Dth_2         = subs(L_Dth_2, {'th_2', 'Dth_2'}, {'th_2(t)', 'diff(th_2(t),t)'});
L_Dth_2_fun     = symfun(L_Dth_2, t);
L_Dth_2_fun_t   = diff(L_Dth_2_fun, t);
L_Dth_2_t0      = subs(L_Dth_2_fun_t, {'th_1(t)', 'diff(th_1(t),t)', 'diff(th_1(t),t,t)'}, {'th_1', 'Dth_1', 'DDth_1'});
L_Dth_2_t       = subs(L_Dth_2_t0,    {'th_2(t)', 'diff(th_2(t),t)', 'diff(th_2(t),t,t)'}, {'th_2', 'Dth_2', 'DDth_2'});

%% Lagrange's equations (Second kind) 
Eq_1 = simplify(L_Dth_1_t - L_th_1)
Eq_2 = simplify(L_Dth_2_t - L_th_2)
save('Equations', 'Eq_1', 'Eq_2');