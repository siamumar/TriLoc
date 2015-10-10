#include <iostream>
#include <vector>
#include <string>
#include <unistd.h>
#include "tri_loc.h"
#include "util.h"
#include "../TinyGarbled/eval_netlist/tcpip.h"

using namespace std;

int main(int argc, char* argv[]){
	if(argc != 3){
		cout << "Usage: " << argv[0] << "<port> <h_port>" << endl;
		return -1;
	} 	
	
	vector<int> port(2);
	port[0] = atoi(argv[1]);
	port[1] = atoi(argv[2]);
	
	helping_car(port);
}

int helping_car(vector<int> &port){
	
	string server_ip = "127.0.0.1";
	
	int connfd;
	if ((connfd = client_init(server_ip.c_str(), port[0])) == -1) {
      cout << "Cannot connect to " << server_ip << ":" << port[0] << endl;
      return -1;
    }
	
	int id;
	read(connfd, &id, sizeof(int));
	write(connfd, &port[1], sizeof(int));
	
	int h_port;
	read(connfd, &h_port, sizeof(int));
	
	cout << h_port << endl;
	
	int ser_cli;
	int done = 1;	
	vector<int> h_connfd(2);
	
	for (int i = 0; i < 2; i++){
		read(connfd, &ser_cli, sizeof(int));
		
		if (ser_cli == 0){
			if ((h_connfd[0] = server_init(port[1])) == -1) {
				cout << "Cannot open the socket in port " << port[1] << " with Car " << (id+1)%3 << endl;
				return -1;
			}
			write(h_connfd[0], &id, sizeof(int));
		}
		else{		
			if ((h_connfd[1] = client_init(server_ip.c_str(), h_port)) == -1) {
				cout << "Cannot connect to " << server_ip << ":" << h_port << " with Car " << (id+2)%3 << endl;
				return -1;
			}
			int other_id;
			read(h_connfd[1], &other_id, sizeof(int));
			cout << "car " << id << " received from car " << other_id << endl;
			write(connfd, &done, sizeof(int));
		}
	}
		
	
	close(connfd);
	return 0;
}