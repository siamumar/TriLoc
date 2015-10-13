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
	
	vector <rect> M_1(2), M(2);
	vector <rect> R(2);
	vector <double> D(2);
	R[0] = get_loc(id);
	D[0] = get_dist(id);
	
	int h_port;
	read(connfd, &h_port, sizeof(int));
	
	int op, done = 1;
	vector <int> in(2);
	bool ser_init = 0, cli_init = 0;
	vector<int> h_connfd(2);
	
	rect S;
	S.x = 0;
	S.y = 0;
	
	for (int i = 0; i < 3; i++){
		read(connfd, &op, sizeof(int));
		
		if (op == 0){
			if (!ser_init){
				if ((h_connfd[0] = server_init(port[1])) == -1) {
					cout << "Cannot open the socket in port " << port[1] << " with Car " << (id+1)%3 << endl;
					return -1;
				}
				ser_init = 1;
			}
			write(h_connfd[0], &id, sizeof(int));
			
			write(h_connfd[0], &(R[0].x), sizeof(double));
			write(h_connfd[0], &(R[0].y), sizeof(double));
			write(h_connfd[0], &D[0], sizeof(double));
			
			read(h_connfd[0], &(M[1].x), sizeof(double));
			read(h_connfd[0], &(M[1].y), sizeof(double));
						
			read(h_connfd[0], &in[1], sizeof(int));
			
			if(!in[1]){
				S.x = S.x + M[1].x;
				S.y = S.y + M[1].y;
			}	
		}
		else if (op == 1){	
			if (!cli_init){
				if ((h_connfd[1] = client_init(server_ip.c_str(), h_port)) == -1) {
					cout << "Cannot connect to " << server_ip << ":" << h_port << " with Car " << (id+2)%3 << endl;
					return -1;
				}
				cli_init = 1;
			}
			int other_id;
			read(h_connfd[1], &other_id, sizeof(int));
			
			read(h_connfd[1], &(R[1].x), sizeof(double));
			read(h_connfd[1], &(R[1].y), sizeof(double));
			read(h_connfd[1], &D[1], sizeof(double)); 
			
			M_1 = intersection(R[0], D[0], R[1], D[1]);
			set_rect(M[0], M_1[0]);
			
			write(h_connfd[1], &(M_1[1].x), sizeof(double));
			write(h_connfd[1], &(M_1[1].y), sizeof(double));
			
			write(connfd, &done, sizeof(int));
			
			if (!ser_init){
				if ((h_connfd[0] = server_init(port[1])) == -1) {
					cout << "Cannot open the socket in port " << port[1] << " with Car " << (id+1)%3 << endl;
					return -1;
				}
				ser_init = 1;
			}			
			read(h_connfd[0], &(R[1].x), sizeof(double));
			read(h_connfd[0], &(R[1].y), sizeof(double));
			read(h_connfd[0], &(D[1]), sizeof(double));
			
			in[0] = (int)(inside(M[0], R[1], D[1]));
			
			if(in[0]){
				S.x = S.x + M[0].x;
				S.y = S.y + M[0].y;
			}				
			
			write(h_connfd[1], &in[0], sizeof(int));
			
			write(connfd, &done, sizeof(int));
			
		}
		else{
			if (!cli_init){
				if ((h_connfd[1] = client_init(server_ip.c_str(), h_port)) == -1) {
					cout << "Cannot connect to " << server_ip << ":" << h_port << " with Car " << (id+2)%3 << endl;
					return -1;
				}
				cli_init = 1;
			}
			write(h_connfd[1], &(R[0].x), sizeof(double));
			write(h_connfd[1], &(R[0].y), sizeof(double));
			write(h_connfd[1], &(D[0]), sizeof(double));
		}
	}	
	
	rect T;
	
	if (id == 0){
		read(connfd, &T.x, sizeof(double));
		read(connfd, &T.y, sizeof(double));
	}
	else{
		read(h_connfd[1], &T.x, sizeof(double));
		read(h_connfd[1], &T.y, sizeof(double));
	}
		
	T.x = T.x + S.x;
	T.y = T.y + S.y;		
		
	if (id == 2){
		write(connfd, &T.x, sizeof(double));
		write(connfd, &T.y, sizeof(double));
	}
	else{
		write(h_connfd[0], &T.x, sizeof(double));
		write(h_connfd[0], &T.y, sizeof(double));
	}
	
	close(connfd);
	return 0;
}