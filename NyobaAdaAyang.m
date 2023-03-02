% Kelompok 3
num = [ 1 ]
denum = [1 10.05]

Gp = tf(num,denum) % jadi transfer functionnya
H = [1]            % umpan sensor

n = [3.39 30.5778]
d = [1 17.731]
Gc = tf(n,d)
Mc = feedback(Gc*Gp, H)
step(Mc)
grid on


