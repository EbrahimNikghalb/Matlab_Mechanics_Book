% for loop
S = 0;
n = 1000000;
for i = 1:n
    S = S + 1/i^2;
end
disp(S);
disp(pi^2/6);
