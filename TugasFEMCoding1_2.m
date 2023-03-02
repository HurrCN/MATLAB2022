% Finite Element Analysis with MATLAB
% Coded by Muhammad Hurricane

clear all

nNodes = 2;
nElms = 1;
A = 0.000001; % m2
E = 0.002; % N/m
yield = 230e6;

force(nNodes*2) = [0; 100];
Nodes(nElms,2)= [1,2];
Coor(nNodes,2)= [0,0;
                 1,0];
matZeros(2,2)=[0,0;
               0,0];
L(nElms) = [2];



