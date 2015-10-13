#ifndef TRILOC
#define TRILOC

#include <vector>

using namespace std;

typedef struct rect{
	double x, y;
}rect;

vector <rect> intersection (rect, double, rect, double);
bool inside (rect, rect, double);
int lost_car(vector<int>&);
int helping_car(vector<int>&);
rect get_loc(int);
double get_dist(int);

#endif


