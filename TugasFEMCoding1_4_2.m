% Tugas Finite Element Analysis dengan MATLAB
% Disusun oleh Muhammad Hurricane 1906356191
clc              % clear
clear            % clear variabel di Workspace
format shortG    % menampilkan lebih dari 4 digit
format compact

%______________ SETUP ______________
% Untuk assign unit yang digunakan dalam tiap besaran
length_unit = 'm';
force_unit = 'N';
stress_unit = 'Pa';

disp('TUGAS FINITE ELEMENT ANALYSIS');
disp('Dikerjakan oleh Muhammad Hurricane 1906356191');
disp('               ');
%{
%______________ PROPERTIES ______________
nElm = input("Berapa jumlah elemennya? = ");
nNode = input("Berapa jumlah node-nya? = ");
nodes = zeros(nElm,2);
coor = zeros(nNode,2);

disp('      ');
disp('<!> INSTRUKSI: Pertama, pengguna dimohon untuk menggambar sistem mekanikanya,');
disp('lalu menentukan index node beserta koordinatnya untuk selanjutnya diinput ke kalkulator ini');
for i=1:nElm
    disp('     ');
    disp(['INPUT DATA ELEMEN ', num2str(i)]);
    disp(['Elemen ', num2str(i), ' terletak di antara 2 node dinotasikan i dan j, yaitu']);
    nodes(i,1) = input("Node i = ");
    nodes(i,2) = input("Node j = ");
end

for i=1:nNode
    disp('     ');
    disp(['INPUT DATA KOORDINAT NODE ', num2str(i)]);
    disp(['Node ', num2str(i), ' terletak pada koordinat ']);
    coor(i,1) = input("Koordinat X = ");
    coor(i,2) = input("Koordinat Y = ");
end

disp('      ');
nPinNode = input("Berapa jumlah node yang dibuat fix ke dinding penyangga? = ");
pinnedNodes = zeros(nPinNode,1);
disp('Silakan masukkan node yang fix.');
for i=1:nPinNode
    pinnedNodes(i,1) = input('Node ke ');
end

disp('      ');
nNotPinNode = input("Berapa jumlah node yang dibuat tidak fix? = ");
notPin = zeros(nNotPinNode,1);
disp('Silakan masukkan node yang tidak fix tersebut.');
for i=1:nNotPinNode
    notPin(i,1) = input('Node ke ');
end

disp('      ');
AEL = zeros(nElm,1);
disp('Silakan masukkan data mengenai konstanta elastisitas masing-masing elemen');
for i=1:nElm
    disp(['Nilai k untuk elemen ke-', num2str(i)]);
    AEL(i,1) = input('k = ');
end

disp('      ');
load = zeros(2*nNode,1);
disp('Silakan masukkan data mengenai pembebanan pada masing-masing node');
for i=1:nNode
    disp(['Besar pembebanan untuk node ke-', num2str(i)]);
    load(2*i-1,1) = input('Beban pada arah X positif = ');
    load(2*i,1) = input('Beban pada arah Y positif = ');
end
%}
%______________ PRE-PROCESSING ______________
%
nElm = 2;
nNode = 3;
nodes = [1    3;            % Nodes pada elemen 1
         2    3];           % Nodes pada elemen 2
coor  = [0    0;            % Koordinat nodes 1
         0    40;           % Koordinat nodes 2
         40   40];          % Koordinat nodes 3
pinnedNodes = [1;2];
notPin = [3];
load  = [0;0;0;0;200;100];
AEL = [1;2];
%
N = 2*nNode;                % jumlah axis komponen gaya per nodes
lengths = zeros(1,nElm);    % Bikin blank space untuk panjang elemen
angles = zeros(1,nElm);     % Bikin blank space untuk sudut elemen thd x-axis
% Bikin blank space untuk menampung [K], [u], dan [F]
K = zeros(N,N);             % stiffness
u = zeros(N,1);             % displacement
% Akumulator bantu dari nilai K global
g = zeros(N,N);
G_star = zeros(N,N);

% ____________________________________________

disp('        ');
disp('        ');
disp('=============================================================');
disp('Berikut adalah hasil analisis yang telah diproses.');
disp('        ');

%K = id;
for i=1:nElm
  n1 = nodes(i,1);
  n2 = nodes(i,2);
  x1 = coor(n1,1);
  x2 = coor(n2,1);
  y1 = coor(n1,2);
  y2 = coor(n2,2);
  dx = x2-x1;
  dy = y2-y1;
  lengths(i) = sqrt((dx^2)+(dy^2));
  angles(i)  = atan2(dy,dx);
  cosDEG = cosd(angles(i)*180/pi);
  sinDEG = sind(angles(i)*180/pi);
  k = AEL(i,1)*[cosDEG^2,       sinDEG*cosDEG;
                sinDEG*cosDEG,  sinDEG^2];
  disp(['i = ', num2str(i)]);
  disp([k]);
  disp(['Sudut elemen ', num2str(i), ' = ', num2str(angles(i)*180/pi), ' deg']);
  disp(['cosDEG = ', num2str(cosDEG)]);
  disp(['sinDEG = ', num2str(sinDEG)]);
  disp(['sinDEG*cosDEG = ', num2str(sinDEG*cosDEG)]);
  g = zeros(N,N);
    for m=1:2
      for n=1:2
        g(2*(nodes(i,1)-1)+m, 2*(nodes(i,1)-1)+n)=k(m,n);
        g(2*(nodes(i,2)-1)+m, 2*(nodes(i,2)-1)+n)=k(m,n);
        g(2*(nodes(i,2)-1)+m, 2*(nodes(i,1)-1)+n)=-k(m,n);
        g(2*(nodes(i,1)-1)+m, 2*(nodes(i,2)-1)+n)=-k(m,n);
        disp(['m = ', num2str(m), ' n = ', num2str(n)]);
        disp([g]);
      end
    end
    G_star = K+g;
    K = G_star;
    disp('K kumulatif sementara =');
    disp([K]);
end
%{
for i=1:length(angles)
  disp(['Panjang elemen ', num2str(i), ' = ', num2str(lengths(i)), length_unit])
  disp(['Sudut elemen ', num2str(i), ' = ', num2str(angles(i)*180/pi), ' deg'])
  disp(' ')
  end
%}
disp('Global K = ');
disp([K]);
K_reduced = K;
for i=pinnedNodes
    for j=1:6
        K_reduced(2*i-1,j) = 0;
        K_reduced(2*i,j) = 0;
        K_reduced(j,2*i-1) = 0;
        K_reduced(j,2*i) = 0;
    end
end
disp('        ');
disp('K tereduksi =');
disp([K_reduced]);
s = length(notPin);
K_newSmall_1 = zeros(s,s);
load_small = zeros(s,1);
u_small = zeros(s,1);
for j=1:length(notPin)
    i = notPin(j,1);
    K_newSmall_1(2*j-1,2*j-1) = K_reduced(2*i-1,2*i-1);
    K_newSmall_1(2*j-1,2*j) = K_reduced(2*i-1,2*i);
    K_newSmall_1(2*j,2*j-1) = K_reduced(2*i,2*i-1);
    K_newSmall_1(2*j,2*j) = K_reduced(2*i,2*i);
    load_small(2*j-1,1) = load(2*i-1,1);
    load_small(2*j,1) = load(2*i,1);
end

disp('        ');
disp('Program kemudian hanya mengambil nilai matriks nonzero dari Global K');
disp('K tereduksi kecil 1 = ');
disp([K_newSmall_1]);
disp('Beban tereduksi kecil = ');
disp([load_small]);
u_small = K_newSmall_1\load_small; % ini sama seperti Kinv*load, suggested by Mathworks
disp('        ');
disp('Displacement = K_kecilInverse x Beban');
disp(u_small);
K_newSmall_2 = zeros(2*length(pinnedNodes),2*length(notPin));
for p=1:length(notPin)
    for q=1:length(pinnedNodes)
        m = notPin(p);
        n = pinnedNodes(q);
        K_newSmall_2(2*q-1,2*p-1) = K(2*n-1,2*m-1);
        K_newSmall_2(2*q-1,2*p) = K(2*n-1,2*m);
        K_newSmall_2(2*q,2*p-1) = K(2*n,2*m-1);
        K_newSmall_2(2*q,2*p) = K(2*n,2*m);
    end
end
disp('        ');
disp('K tereduksi kecil 2 = ');
disp([K_newSmall_2]);

react_small = zeros(length(K_newSmall_2),1);
react_small = K_newSmall_2 * u_small;
disp('        ');
disp('Gaya reaksi = ');
disp([react_small]);

%{
reaction = zeros(N,1);
for i=1:nNode
    reaction(2*i-1,1) = react_small(2*i-1,1);
end
for i
%}
