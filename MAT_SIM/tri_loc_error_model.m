% clc
clear all
close all

A = 1;
B = 2;
C = 3;
M = 4; 
M1 = 5;
L = struct ('x', {}, 'y', {});

KK = 500;
err = zeros(1, 9);    
T = 100;
R = T;

L(M).x  = 0;
L(M).y  = 0;

% A: red, B: blue, C: green

for kk = 1:KK

    L(A).x = -T/2 - T*rand;
    L(A).y =  T/2 + T*rand;
    L(B).x = -T/2 - T*rand;
    L(B).y = -T/2 - T*rand;
    L(C).x =  T/2 + T*rand;
    L(C).y =  T*(rand-.5);    
    r(A) = ((L(M).x - L(A).x)^2 + (L(M).y - L(A).y)^2) ^.5 + R;
    r(B) = ((L(M).x - L(B).x)^2 + (L(M).y - L(B).y)^2) ^.5 + R;
    r(C) = ((L(M).x - L(C).x)^2 + (L(M).y - L(C).y)^2) ^.5 + R;    
    L(M1) = tri_loc(L(A:C), r, 0);    
    err(1) = err(1) + ((L(M1).x)^2 + (L(M1).y)^2) ^.5;
    subplot(3,3,1), hold on, axis([-3*T/2, 3*T/2, -3*T/2, 3*T/2]), axis([-3*T/2, 3*T/2, -3*T/2, 3*T/2])
    plot(L(A).x, L(A).y, 'r.')
    plot(L(B).x, L(B).y, 'b.')
    plot(L(C).x, L(C).y, 'g.')
    
    
    L(C).x =  T/2 + T*rand;
    L(C).y =  T/2 + T*rand;    
    r(C) = ((L(M).x - L(C).x)^2 + (L(M).y - L(C).y)^2) ^.5 + R;    
    L(M1) = tri_loc(L(A:C), r, 0);    
    err(2) = err(2) + ((L(M1).x)^2 + (L(M1).y)^2) ^.5;
    subplot(3,3,2), hold on, axis([-3*T/2, 3*T/2, -3*T/2, 3*T/2])
    plot(L(A).x, L(A).y, 'r.')
    plot(L(B).x, L(B).y, 'b.')
    plot(L(C).x, L(C).y, 'g.')
    
    L(C).x =  T*(rand-.5);
    L(C).y =  T/2 + T*rand;
    r(C) = ((L(M).x - L(C).x)^2 + (L(M).y - L(C).y)^2) ^.5 + R;    
    L(M1) = tri_loc(L(A:C), r, 0);    
    err(3) = err(3) + ((L(M1).x)^2 + (L(M1).y)^2) ^.5;
    subplot(3,3,3), hold on, axis([-3*T/2, 3*T/2, -3*T/2, 3*T/2])
    plot(L(A).x, L(A).y, 'r.')
    plot(L(B).x, L(B).y, 'b.')
    plot(L(C).x, L(C).y, 'g.')
    
    L(C).x =  -T/2 - T*rand;
    L(C).y =  T*(rand-.5);  
    r(C) = ((L(M).x - L(C).x)^2 + (L(M).y - L(C).y)^2) ^.5 + R;    
    L(M1) = tri_loc(L(A:C), r, 0);    
    err(4) = err(4) + ((L(M1).x)^2 + (L(M1).y)^2) ^.5;
    subplot(3,3,4), hold on, axis([-3*T/2, 3*T/2, -3*T/2, 3*T/2])
    plot(L(A).x, L(A).y, 'r.')
    plot(L(B).x, L(B).y, 'b.')
    plot(L(C).x, L(C).y, 'g.')
    
    L(B).x = T*(rand-.5);
    L(B).y = -T/2 - T*rand;
    L(C).x =  T/2 + T*rand;
    L(C).y =  T*(rand-.5);    
    r(B) = ((L(M).x - L(B).x)^2 + (L(M).y - L(B).y)^2) ^.5 + R;
    r(C) = ((L(M).x - L(C).x)^2 + (L(M).y - L(C).y)^2) ^.5 + R;    
    L(M1) = tri_loc(L(A:C), r, 0);    
    err(5) = err(5) + ((L(M1).x)^2 + (L(M1).y)^2) ^.5;
    subplot(3,3,5), hold on, axis([-3*T/2, 3*T/2, -3*T/2, 3*T/2])
    plot(L(A).x, L(A).y, 'r.')
    plot(L(B).x, L(B).y, 'b.')
    plot(L(C).x, L(C).y, 'g.')
    
    L(B).x = T/2 + T*rand;
    L(B).y = -T/2 - T*rand;  
    r(B) = ((L(M).x - L(B).x)^2 + (L(M).y - L(B).y)^2) ^.5 + R;  
    L(M1) = tri_loc(L(A:C), r, 0);    
    err(6) = err(6) + ((L(M1).x)^2 + (L(M1).y)^2) ^.5;
    subplot(3,3,6), hold on, axis([-3*T/2, 3*T/2, -3*T/2, 3*T/2])
    plot(L(A).x, L(A).y, 'r.')
    plot(L(B).x, L(B).y, 'b.')
    plot(L(C).x, L(C).y, 'g.')
    
    L(B).x = T/2 + T*rand;
    L(B).y = T/2 + T*rand; 
    r(B) = ((L(M).x - L(B).x)^2 + (L(M).y - L(B).y)^2) ^.5 + R;  
    L(M1) = tri_loc(L(A:C), r, 0);    
    err(7) = err(7) + ((L(M1).x)^2 + (L(M1).y)^2) ^.5;
    subplot(3,3,7), hold on, axis([-3*T/2, 3*T/2, -3*T/2, 3*T/2])
    plot(L(A).x, L(A).y, 'r.')
    plot(L(B).x, L(B).y, 'b.')
    plot(L(C).x, L(C).y, 'g.')
    
    L(B).x = T*(rand-.5);
    L(B).y = T/2 + T*rand; 
    r(B) = ((L(M).x - L(B).x)^2 + (L(M).y - L(B).y)^2) ^.5 + R;  
    L(M1) = tri_loc(L(A:C), r, 0);    
    err(8) = err(8) + ((L(M1).x)^2 + (L(M1).y)^2) ^.5;
    subplot(3,3,8), hold on, axis([-3*T/2, 3*T/2, -3*T/2, 3*T/2])
    plot(L(A).x, L(A).y, 'r.')
    plot(L(B).x, L(B).y, 'b.')
    plot(L(C).x, L(C).y, 'g.')
    
    L(B).x = -T/2 - T*rand;
    L(B).y =  T*(rand-.5); 
    r(B) = ((L(M).x - L(B).x)^2 + (L(M).y - L(B).y)^2) ^.5 + R;  
    L(M1) = tri_loc(L(A:C), r, 0);    
    err(9) = err(9) + ((L(M1).x)^2 + (L(M1).y)^2) ^.5;
    subplot(3,3,9), hold on, axis([-3*T/2, 3*T/2, -3*T/2, 3*T/2])
    plot(L(A).x, L(A).y, 'r.')
    plot(L(B).x, L(B).y, 'b.')
    plot(L(C).x, L(C).y, 'g.')

end

err/KK/T*100/3*2

for k = 1:9
    subplot(3,3,k)
    title(num2str(err(k)/KK/T*100/3*2))
end

