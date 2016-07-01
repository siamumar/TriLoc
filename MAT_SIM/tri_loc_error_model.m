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

r = zeros(1,3);
theta = zeros(1,3);
  
T = 100;
s = [.5, .7, .9];
S = s*T;


ERR_M = zeros(3, 200);
mean_ERR_M = zeros(3, 200);
median = struct ('x', {}, 'y', {});
DIST = zeros(1, 200);

% A: red, B: blue, C: green
tic;
K = 10e3;
k = 1;
while (k <= K)

    L(A).x = 2*T*(rand(1,1)-.5);
    L(B).x = 2*T*(rand(1,1)-.5);
    L(C).x = 2*T*(rand(1,1)-.5);
    L(A).y = 2*T*(rand(1,1)-.5);
    L(B).y = 2*T*(rand(1,1)-.5);
    L(C).y = 2*T*(rand(1,1)-.5);    
    
    P = [L(A).x, L(A).y, 0];
    Q = [L(B).x, L(B).y, 0];
    R = [L(C).x, L(C).y, 0];
    
    median(1).x = (L(A).x + L(B).x + L(C).x)/3; 
    median(1).y = (L(A).y + L(B).y + L(C).y)/3; 
    dist = round(((median(1).x)^2 + (median(1).y)^2) ^.5)+1;
    if(dist > 101 || DIST(dist) >= K/95)
        continue;
    end
    DIST(dist) = DIST(dist) + 1;
    
    r(A) = ((L(M).x - L(A).x)^2 + (L(M).y - L(A).y)^2) ^.5;
    r(B) = ((L(M).x - L(B).x)^2 + (L(M).y - L(B).y)^2) ^.5;
    r(C) = ((L(M).x - L(C).x)^2 + (L(M).y - L(C).y)^2) ^.5;
    
    for l = 1:3
        L(M1) = tri_loc(L(A:C), r+S(l), 0);
        err = ((L(M1).x)^2 + (L(M1).y)^2) ^.5;
        ERR_M(l, dist) = ERR_M(l, dist) + err;        
    end
    
    if (~mod(k,100))
        clc
        t = toc;
        p = k/K;
        fprintf(1,'Progress: %3.1f%% Time Elapsed : %.0fs Time Remaining : %.0fs End Time : %.0fs\n', p*100, t, t/p-t, t/p);
    end
    
    k = k + 1;
end

for l = 1:3
    mean_ERR_M(l, :) = ERR_M(l, :)./DIST/T/2;
end

figure(3)
plot(DIST)

save mean_ERR_M