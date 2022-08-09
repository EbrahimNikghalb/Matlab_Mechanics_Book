clc, clear
syms th Dth DDth 
syms m g l t Tau
T = 1/2 * m * l^2 * Dth^2;
V = m * g * l *(1 - cos(th));
L = T - V;
%% Calculation of L_Dth and L_th
L_Dth = diff(L, Dth);
L_th  = diff(L,  th);
%%  Calculation of  d/dt( L_Dth )
L_Dth     = subs(L_Dth, {'th', 'Dth'}, {'th(t)', 'diff(th(t),t)'});
L_Dth_fun = symfun(L_Dth, t);
L_Dth_fun_t = diff(L_Dth_fun, t);
L_Dth_t     = subs(L_Dth_fun_t, {'th(t)', 'diff(th(t),t)', 'diff(th(t),t,t)'}, {'th', 'Dth', 'DDth'});
%% Lagrange's equations (Second kind) 
simplify(L_Dth_t - L_th - Tau)





