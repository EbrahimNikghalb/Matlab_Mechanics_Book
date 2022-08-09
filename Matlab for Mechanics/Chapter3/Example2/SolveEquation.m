%% First, Run The following commands
% LagrangeEquation2
% StateSpaceFormOfEquations

%%
clc, clear
syms th_1 th_2  Dth_1 Dth_2  DDth_1 DDth_2 
syms l_1 l_2 m_1 m_2 J_1 J_2  g t 
load SS_NonLin;

%% Preparation of SS Eq for ODE Solver: Creating Anonymous Fcn
F_0 = subs(F.',[l_1 l_2 m_1 m_2 J_1 J_2 g],[0.5 0.5 1 2 0.2 0.5 9.81]);
F_ode0 = matlabFunction(F_0,'vars',{sym('x_',[1,4]),t});

F_ode = @(t,x)F_ode0(x(1:4)',t);

%% 1] Evaluation of IC respone
InitCnd = [120,-90,0,0];
[t,X] = ode45(F_ode,linspace(0,5,1e3),InitCnd/180*pi); 

figure(1); plot(t,X(:,1),'r'); hold on; plot(t,X(:,2),':b'); 
S1 = sprintf('$ \\theta_2$'); 
S2 = sprintf('$ \\theta_2$');
H = legend(S1,S2); set(H,'interpreter','latex','fontsize',14,'location','SouthWest');
xlabel('Time (sec)'); ylabel('Angles (rad)');
Animator(X(:,1:2)/pi*180)