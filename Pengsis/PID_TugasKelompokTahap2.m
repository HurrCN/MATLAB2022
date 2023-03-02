% PID controller
clear all
clc

% dalam pembuatan pembilang(num) dan penyebut (denum)
% kita tinggal taro aja angka dan dia auto tau ini orde ke brp
num = [ 40 ]     % artinya cuma 1
denum = [1 10.05] % artinya 1s^2 + 3s + 1

Gp = tf(num,denum) % jadi transfer functionnya
H = [1]            % umpan sensor

%M = feedback(Gp,H)
%step(M)
%hold on

%%
%Kp = 100
%Ki = 0.2
%Kd = 12

%Gc = pid(Kp,Ki,Kd)
n = [3.39 30.5778]
d = [1 17.731]
Gc = tf(n,d)
Mc = feedback(Gc*Gp, H)
step(Mc)
grid on
