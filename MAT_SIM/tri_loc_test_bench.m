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

% R = 75;
% r(A) = ((L(M).x - L(A).x)^2 + (L(M).y - L(A).y)^2) ^.5 + R;
% r(B) = ((L(M).x - L(B).x)^2 + (L(M).y - L(B).y)^2) ^.5 + R;
% r(C) = ((L(M).x - L(C).x)^2 + (L(M).y - L(C).y)^2) ^.5 + R;

r(A) = 215; 
r(B) = 236;
r(C) = 183;

L(M1) = tri_loc(L(A:C), r, 1);

plot (L(M).x, L(M).y, 'ro'), hold on
plot (L(A).x, L(A).y, 'ko')
plot (L(B).x, L(B).y, 'ko')
plot (L(C).x, L(C).y, 'ko')

fprintf(1, 'init hex strings:\n');
for k = A:C 
    fprintf(1, '\t%s \n', dec2hex(bin2dec([dec2bin(typecast(int8(L(k).x),'uint8'),8), dec2bin(typecast(int8(L(k).y),'uint8'),8), dec2bin(typecast(int16(r(k)),'uint16'),9)])));
end
fprintf(1, '\n');

for k = A:C
    x = (L(k).x - r(k)):.01:(L(k).x + r(k));
    y1 = L(k).y + (((r(k))^2 - (x - L(k).x).^2)).^.5;
    y2 = L(k).y - (((r(k))^2 - (x - L(k).x).^2)).^.5;
    plot(x, y1, 'g'), hold on, axis equal
    plot(x, y2, 'g')
end 

plot (L(M1).x, L(M1).y, 'rx')

fprintf(1, 'output hex string:\n');
fprintf(1, '\t%s \n', dec2hex(bin2dec([dec2bin(typecast(int8(L(M1).x),'uint8'),8), dec2bin(typecast(int8(L(M1).y),'uint8'),8)])));