#include <iostream>
#include <vector>
#include <cstring>
#include <cstdlib>
#include <unistd.h>
#include "tri_loc.h"
#include "util.h"
#include "tcpip.h"

using namespace std;

int main(int argc, char* argv[]){
	if(argc != 4){
		cout << "Usage: " << argv[0] << "<port_0> <port_1> <port_2>" << endl;
		return -1;
	} 	
	
	vector<int> port(3);
	for (int i = 0; i < 3; i++)
		port[i] = atoi(argv[i+1]);
	
	lost_car(port);
}

int lost_car(vector<int> &port){
	
	vector<int> connfd(3);
	for (int i = 0; i < 3; i++)
		if ((connfd[i] = server_init(port[i])) == -1) {
			cout << "Cannot open the socket in port " << port[i] << " with Car " << i << endl;
			return -1;
		}
	
	vector<int> h_port(3);	
	for (int id = 0; id < 3; id++){
		write(connfd[id], &id, sizeof(int));
		read(connfd[id], &h_port[id], sizeof(int));
	}
	
	for (int id = 0; id < 3; id++){
		write(connfd[id], &h_port[(id+2)%3], sizeof(int));
	}
	
	int done; 
	int init = 0, comp = 1, chk = 2;
	for (int id = 0; id < 3; id++){
		write(connfd[id], &init, sizeof(int));
		
		write(connfd[(id+1)%3], &comp, sizeof(int));
		read(connfd[(id+1)%3], &done, sizeof(int));
		
		write(connfd[(id+2)%3], &chk, sizeof(int));
		
		read(connfd[(id+1)%3], &done, sizeof(int));
	}
	
	rect Q, M;
	
	M.x = rand()%255 + rand()/255;
	M.y = rand()%255 + rand()/255;
	
	write(connfd[0], &M.x, sizeof(double));
	write(connfd[0], &M.y, sizeof(double));
	
	read(connfd[2], &Q.x, sizeof(double));
	read(connfd[2], &Q.y, sizeof(double));
	
	Q.x = (Q.x - M.x)/3;
	Q.y = (Q.y - M.y)/3;
	
	print_rect(Q);
	
	
	
	for (int i = 0; i < 3; i++)
		close(connfd[i]);
	
	return 0;
	
}