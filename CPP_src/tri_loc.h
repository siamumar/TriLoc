#ifndef TRILOC
#define TRILOC

#include <vector>
#include <cstring>

#define PRIVACY 1
#define SINGLE_THREAD 0
#define SEQUENTIAL 0

#define BIT_LEN 8
	
#define INTERSECTION_SEQ_SCD "../../Netlist/syn/intersections_seq_8.scd"	
#define INTERSECTION_COMB_SCD "../../Netlist/syn/intersections_comb_TG_8.scd"
#define INSIDE_SCD "../../Netlist/syn/inside_TG_8.scd"

using namespace std;

typedef struct rect{
	double x, y;
}rect;

typedef struct int_data{
	int id;
	string input_str_0, input_str_1, output_str, intersection_output_mask;
	int h_connfd;	
}int_data;

void print_rect(rect);
void print_rect(vector<rect>);
void set_rect(rect&, rect);
int get_loc(string, int, rect&, double&);
int get_client_ip(int);
string ip_int2str(int);

#if PRIVACY	
#if (!SINGLE_THREAD)
void *intersection_GC(void*);
void *inside_GC(void*);
#endif
#else
vector <rect> intersection (rect, double, rect, double);
bool inside (rect, rect, double);
#endif
int lost_car(vector<int>&);
int helping_car(string, vector<int>&, string);

#endif


