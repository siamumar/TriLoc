#include <iostream>
#include <vector>
#include <string>
#include <unistd.h>
#include "tri_loc.h"
#include "util.h"
#include "../TinyGarbled/eval_netlist/tcpip.h"

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
			cout << "Cannot open the socket in port " << port[i] << "with Car " << i << endl;
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
	int ser = 0, cli = 1;
	for (int id = 0; id < 3; id++){
		write(connfd[id], &ser, sizeof(int));
		write(connfd[(id+1)%3], &cli, sizeof(int));
		read(connfd[(id+1)%3], &done, sizeof(int));
	}
	
	for (int i = 0; i < 3; i++)
		close(connfd[i]);
	
	return 0;
	
}