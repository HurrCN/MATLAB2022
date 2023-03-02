clc
clear all
K = [2.276  0.447; 0.447  0.72404];
F = [100; 200];
N = length(K);
u = zeros(N,1);

Kinv = inv(K);
u = Kinv*F;
disp('u = ');
disp([u]);

pinnedNodes = [1;2];
for i=pinnedNodes
    disp([i]);
    hold on;
end