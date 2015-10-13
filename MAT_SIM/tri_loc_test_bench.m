clc
% clear all
close all

A = 1;
B = 2;
C = 3;
M = 4; 
M1 = 5;

L = struct ('x', {}, 'y', {});

L(M).x  = 149;
L(M).y  = 37;
L(A).x  = -32;
L(A).y  = 108;
L(B).x  = -16;
L(B).y  = -139;
L(C).x  = 309;
L(C).y  = 99;


plot (L(M).x, L(M).y, 'ro'), hold on
plot (L(A).x, L(A).y, 'ko')
plot (L(B).x, L(B).y, 'ko')
plot (L(C).x, L(C).y, 'ko')


r(A) = ((L(M).x - L(A).x)^2 + (L(M).y - L(A).y)^2) ^.5 + 25;
r(B) = ((L(M).x - L(B).x)^2 + (L(M).y - L(B).y)^2) ^.5 + 25;
r(C) = ((L(M).x - L(C).x)^2 + (L(M).y - L(C).y)^2) ^.5 + 25;

for k = A:C
    x = (L(k).x - r(k)):.1:(L(k).x + r(k));
    y1 = L(k).y + (((r(k))^2 - (x - L(k).x).^2)).^.5;
    y2 = L(k).y - (((r(k))^2 - (x - L(k).x).^2)).^.5;
    plot(x, y1, 'g'), hold on, axis equal
    plot(x, y2, 'g')
end

 

L(M1) = tri_loc(L(A:C), r);

plot (L(M1).x, L(M1).y, 'rx')