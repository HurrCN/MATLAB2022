%a = [125, -75;
%    -75, 75]
%b = inv(a)
%c = [75;
%    75]
%d = b*c
%%
k = 1
w = 100
a = [5*k,    -2*k,   0;
    -2*k,   3*k,    -k;
    0,      -k,     k]
f = [w;
    w;
    w]
ainv = inv(a)
u = ainv*f
