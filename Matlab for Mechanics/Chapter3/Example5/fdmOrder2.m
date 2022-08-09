%% Chapter-3 Example-5:
% finite difference method
% order-2 Aij matrix

function Aij2 = fdmOrder2(x)

N = numel(x);
Aij2 = zeros(N);

dx2 = (x(2)-x(1))^2;
row = [1 -2 1] / dx2;

for k = 2:N-1
    % central fd
    Aij2(k,k-1:k+1) = row;
end

% forward fd
Aij2(1,1:3) = row;
% backward fd
Aij2(N,N-2:N) = row;
end