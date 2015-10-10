#include <iostream>
#include "tri_loc.h"

using namespace std;

void print_rect(rect R){	
	cout << "<" << R.x << "," << R.y << ">\t\t";
	cout << "\n";
}

void print_rect(vector<rect> R){
	for (int i = 0; i < R.size(); i++)
		cout << "<" << R[i].x << "," << R[i].y << ">\t\t";
	cout << "\n";
}