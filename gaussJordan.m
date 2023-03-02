K = [5 -2 0; -2 3 -1; 0 -1 1];
F = [100; 100; 100];
N = length(K);
u = zeros(N,1);
[K, F] = rref(u);
disp([u]);