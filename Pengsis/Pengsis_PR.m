clear all
clc
% ubah persamaan di sini, cukup koef aja gess
num = [1 3]       %num = pembilang transfer function
denum = [3 13 8] %denum = penyebut transfer function
Gp = tf(num,denum)
H = [1]
M = feedback(Gp, H)
step(M)
hold on
%%
%Kp = 100
%Ki = 2
%Kd = 0
Kp = 100
Ki = 0
Kd = 0
Gc = pid(Kp,Ki,Kd)
Mc = feedback(Gc*Gp, H)
step(Mc)
grid on