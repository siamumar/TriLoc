clc
clear all
close all

A = 1;
B = 2;
C = 3;
M = 4; 
M1 = 5;

L = struct ('x', {}, 'y', {});

L(M).x  = 0;
L(M).y  = 0;
L(A).x  = -32;
L(A).y  = 108;
L(B).x  = -16;
L(B).y  = -111;
L(C).x  = 109;
L(C).y  = -99;

r(A) = 215; 
r(B) = 236;
r(C) = 183;

L(M1) = tri_loc(L(A:C), r, 1);

plot (L(M).x, L(M).y, 'ro'), hold on
plot (L(A).x, L(A).y, 'ko')
plot (L(B).x, L(B).y, 'ko')
plot (L(C).x, L(C).y, 'ko')


for k = A:C
    x = (L(k).x - r(k)):.01:(L(k).x + r(k));
    y1 = L(k).y + (((r(k))^2 - (x - L(k).x).^2)).^.5;
    y2 = L(k).y - (((r(k))^2 - (x - L(k).x).^2)).^.5;
    plot(x, y1, 'g'), hold on, axis equal
    plot(x, y2, 'g')
end 

plot (L(M1).x, L(M1).y, 'rx')


L1 = struct ('x', {}, 'y', {});
L2 = struct ('x', {}, 'y', {});

for k = A:C
L1(k).x = mod(L(k).x,4);
L1(k).y = mod(L(k).y,4);
L2(k).x = floor(L(k).x/4);
L2(k).y = floor(L(k).y/4);
r1(k) = mod(r(k),8);
r2(k) = floor(r(k)/4);
end

L1(M1) = tri_loc(L1(A:C), r1, 1);
L2(M1) = tri_loc(L2(A:C), r2, 1);


