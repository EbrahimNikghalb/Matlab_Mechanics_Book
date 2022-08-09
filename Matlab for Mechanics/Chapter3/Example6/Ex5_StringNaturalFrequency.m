%% Chapter-3 Example-5:
% finite length string natural frequency
% finite difference method

clc, clear

%% input
T = 1;      % [N] string tension
L = 1;      % [m] string length
rho = 1;    % [kg/m] string density per length
dx = 0.01;  % [m] x discretization

%% process
x = (0:dx:L)';
alpha = rho/T;

Fmat2 = fdmOrder2(x);
A = -(1/alpha)*Fmat2;

A(:,1) = [];
A(:,end) = [];
A(1,:) = [];
A(end,:) = [];

[eigV,eigD] = eig(A);

eigD = sqrt(diag(eigD));
eigV = [zeros(1,size(eigV,2));
    eigV;
    zeros(1,size(eigV,2))];
for j = 1:size(eigV,2)
    eigV(:,j) = eigV(:,j)./ ...
    repmat(max(eigV(:,j)),size(eigV(:,j),1),1);
end

omgReal = ((1:numel(eigD))*pi*sqrt(1/alpha)/L)';

%% visualization
figure(1)
plot(abs(eigD-omgReal)*100./omgReal)
grid on
xlabel('Number of Natural Frequency')
ylabel('Error Percent (%)')

figure(2)
cla, hold on, box on
for j = 1:4
    plot(x,eigV(:,j),'LineWidth',2)
end
axis([0 L -1.2 1.2])