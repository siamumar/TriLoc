function U = tri_loc( L, r, pnd)

V = struct ('x', {}, 'y', {});

A = 1;
B = 2;
C = 3;
M = 4; 


p = L(C).x - L(B).x;
q = L(B).y - L(C).y;
t = r(B)^2 - r(C)^2 + (L(C).x)^2 - (L(B).x)^2 + (L(C).y)^2 - (L(B).y)^2;
s = 4*p^2*(L(B).y)^2 + t^2 - 4*p*t*L(B).x + 4*p^2*(L(B).x)^2 - 4*p^2*r(B)^2;
u = (q*t - 2*L(B).y*p^2 - 2*p*q*L(B).x);
w_sqr = (u^2 - s*(p^2 + q^2));
w = w_sqr^.5;

y1 = ( p*q*L(B).x + L(B).y*p^2 - .5*q*t + w/2 )/( p^2 + q^2);
y2 = ( p*q*L(B).x + L(B).y*p^2 - .5*q*t - w/2 )/( p^2 + q^2);

z = r(B)^2 - r(C)^2 + (L(C).x)^2 - (L(B).x)^2 + (L(C).y)^2 - (L(B).y)^2;

x1 = (2*y1*(L(B).y - L(C).y) +  z)/(2*(L(C).x - L(B).x));
x2 = (2*y2*(L(B).y - L(C).y) +  z)/(2*(L(C).x - L(B).x));

H = ((x1 - L(A).x)^2 + (y1 - L(A).y)^2);

if (H <= r(A)^2)
    V(A).x = x1;
    V(A).y = y1;
else   
    V(A).x = x2;
    V(A).y = y2;
end

if(pnd)
    disp('Intersections between B and C:');
    disp([x1 y1; x2 y2])
    plot(x1, y1, 'bs'), hold on
    plot(x2, y2, 'bs')
    disp('Intersection in rabge of A:');
    disp([V(A).x V(A).y])
end


p = L(B).x - L(A).x;
q = L(A).y - L(B).y;
t = (r(A))^2 - (r(B))^2 + (L(B).x)^2 - (L(A).x)^2 + (L(B).y)^2 - (L(A).y)^2;
s = 4*p^2*(L(A).y)^2 + t^2 - 4*p*t*L(A).x + 4*p^2*(L(A).x)^2 - 4*p^2*(r(A))^2;
w = (q*t - 2*L(A).y*p^2 - 2*p*q*L(A).x)^2 - s*(p^2 + q^2);

y1 = ( p*q*L(A).x + L(A).y*p^2 - .5*q*t + 0.5*w^.5 )/( p^2 + q^2);
y2 = ( p*q*L(A).x + L(A).y*p^2 - .5*q*t - 0.5*w^.5 )/( p^2 + q^2);

z = r(A)^2 - r(B)^2 + (L(B).x)^2 - (L(A).x)^2 + (L(B).y)^2 - (L(A).y)^2;

x1 = (2*y1*(L(A).y - L(B).y) +  z)/(2*(L(B).x - L(A).x));
x2 = (2*y2*(L(A).y - L(B).y) +  z)/(2*(L(B).x - L(A).x));

H = ((x1 - L(C).x)^2 + (y1 - L(C).y)^2);

if (H <= r(C)^2)
    V(C).x = x1;
    V(C).y = y1;
else    
    V(C).x = x2;
    V(C).y = y2;
end

if(pnd)
    disp('Intersections between A and B:');
    disp([x1 y1; x2 y2])
    plot(x1, y1, 'bs')
    plot(x2, y2, 'bs')
    disp('Intersection in rabge of C:');
    disp([V(C).x V(C).y])
end

p = L(A).x - L(C).x;
q = L(C).y - L(A).y;
t = (r(C))^2 - (r(A))^2 + (L(A).x)^2 - (L(C).x)^2 + (L(A).y)^2 - (L(C).y)^2;
s = 4*p^2*(L(C).y)^2 + t^2 - 4*p*t*L(C).x + 4*p^2*(L(C).x)^2 - 4*p^2*(r(C))^2;
w = (q*t - 2*L(C).y*p^2 - 2*p*q*L(C).x)^2 - s*(p^2 + q^2);

y1 = ( p*q*L(C).x + L(C).y*p^2 - .5*q*t + 0.5*w^.5 )/( p^2 + q^2);
y2 = ( p*q*L(C).x + L(C).y*p^2 - .5*q*t - 0.5*w^.5 )/( p^2 + q^2);

z = r(C)^2 - r(A)^2 + (L(A).x)^2 - (L(C).x)^2 + (L(A).y)^2 - (L(C).y)^2;

x1 = (2*y1*(L(C).y - L(A).y) +  z)/(2*(L(A).x - L(C).x));
x2 = (2*y2*(L(C).y - L(A).y) +  z)/(2*(L(A).x - L(C).x));

H = ((x1 - L(B).x)^2 + (y1 - L(B).y)^2);

if (H <= r(B)^2)
    V(B).x = x1;
    V(B).y = y1;
else    
    V(B).x = x2;
    V(B).y = y2;
end

if(pnd)
    disp('Intersections between C and A:');
    disp([x1 y1; x2 y2])
    plot(x1, y1, 'bs')
    plot(x2, y2, 'bs')
    disp('Intersection in rabge of B:');
    disp([V(B).x V(B).y])
end

V(M).x = mean([V(A).x, V(B).x, V(C).x]);
V(M).y = mean([V(A).y, V(B).y, V(C).y]);

if(pnd) 
    disp('Location of Q:');
    disp([V(M).x V(M).y])
    plot (V(A).x, V(A).y, 'mo')
    plot (V(B).x, V(B).y, 'mo')
    plot (V(C).x, V(C).y, 'mo')
    plot([V(A).x, V(B).x], [V(A).y, V(B).y], 'b')
    plot([V(B).x, V(C).x], [V(B).y, V(C).y], 'b')
    plot([V(C).x, V(A).x], [V(C).y, V(A).y], 'b')
end

U = V(M);
end

