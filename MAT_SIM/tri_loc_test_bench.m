clc
% clear all
close all

A = 1;
B = 2;
C = 3;
M = 4; 
M1 = 5;

L = struct ('x', {}, 'y', {});

% L(M).x  = rand*20+30;
% L(M).y  = rand*20+30;
% L(A).x  = rand*20+30;
% L(A).y  = rand*20+90;
% L(B).x  = rand*20-30;
% L(B).y  = rand*20-30;
% L(C).x  = rand*20+90;
% L(C).y  = rand*20-10;

L(M).x  = 49;
L(M).y  = 37;
L(A).x  = 32;
L(A).y  = 108;
L(B).x  = -16;
L(B).y  = -24;
L(C).x  = 109;
L(C).y  = -9;


plot (L(M).x, L(M).y, 'o'), hold on
plot (L(A).x, L(A).y, 'kx')
plot (L(B).x, L(B).y, 'kx')
plot (L(C).x, L(C).y, 'kx')


r(A) = ((L(M).x - L(A).x)^2 + (L(M).y - L(A).y)^2) ^.5;
r(B) = ((L(M).x - L(B).x)^2 + (L(M).y - L(B).y)^2) ^.5;
r(C) = ((L(M).x - L(C).x)^2 + (L(M).y - L(C).y)^2) ^.5;

L(M1) = tri_loc(L(A:C), floor(r));

plot (L(M1).x, L(M1).y, 'rx')