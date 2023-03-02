% PID controller
clear all
clc

% dalam pembuatan pembilang(num) dan penyebut (denum)
% kita tinggal taro aja angka dan dia auto tau ini orde ke brp
num = [ 1 ]     % artinya cuma 1
denum = [1 3 1] % artinya 1s^2 + 3s + 1

Gp = tf(num,denum) % jadi transfer functionnya
H = [1]            % umpan sensor

M = feedback(Gp,H)
step(M)
hold on

%%
Kp = 24
Ki = 3
Kd = 8

Gc = pid(Kp,Ki,Kd)
Mc = feedback(Gc*Gp, H)
step(Mc)
grid on
