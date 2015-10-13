#include <iostream>
#include <vector>
#include <cmath>
#include "tri_loc.h"
#include "util.h"

using namespace std;

int main(){
	rect A, B, C, Q;
	double rA, rB, rC;
	vector <rect> D(2), E(2), F(2), M(3);
	
	Q.x  = 149;
	Q.y  = 37;
	A.x  = -32;
	A.y  = 108;
	B.x  = -16;
	B.y  = -111;
	C.x  = 109;
	C.y  = -9;

	rA = sqrt((Q.x - A.x)*(Q.x - A.x) + (Q.y - A.y)*(Q.y - A.y));
	rB = sqrt((Q.x - B.x)*(Q.x - B.x) + (Q.y - B.y)*(Q.y - B.y));
	rC = sqrt((Q.x - C.x)*(Q.x - C.x) + (Q.y - C.y)*(Q.y - C.y));
	
	cout << rA << "\t" << rB << "\t" << rC << endl;
	
	D = intersection(B, rB, C, rC);
	print_rect(D);
	if (inside(D[0], A, rA)) M[0] = D[0];
	else M[0] = D[1];
	
	E = intersection(C, rC, A, rA);
	print_rect(E);
	if (inside(E[0], B, rB)) M[1] = E[0];
	else M[1] = E[1];
	
	F = intersection(A, rA, B, rB);
	print_rect(F);
	if (inside(F[0], A, rA)) M[2] = F[0];
	else M[2] = F[1];
	
	print_rect(M);
	
	Q.x = 0;
	Q.y = 0;
	for (int i = 0; i < M.size(); i++){
		Q.x = Q.x + M[i].x;
		Q.y = Q.y + M[i].y;
	}
	Q.x = Q.x/3;
	Q.y = Q.y/3;
	
	print_rect(Q);
	
}

