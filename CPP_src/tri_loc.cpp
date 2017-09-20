#include <iostream>
#include <fstream>
#include <vector>
#include <cstring>
#include <cstdint>
#include <unistd.h>
#include <cmath>
#include <sys/time.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <pthread.h>
#include "CPP_src/tri_loc.h"

#include "garbled_circuit/garbled_circuit.h"
#include "tcpip/tcpip.h"
#include "util/util.h"
#include "util/log.h" 

using namespace std;

#if !SINGLE_THREAD
pthread_mutex_t running_mutex = PTHREAD_MUTEX_INITIALIZER;
volatile int running_threads  = 0;
#endif

void print_rect(rect R){	
	cout << "<" << R.x << "," << R.y << ">\t\t";
	cout << "\n";
}

void print_rect(vector<rect> R){
	for (uint i = 0; i < R.size(); i++)
		cout << "<" << R[i].x << "," << R[i].y << ">\t\t";
	cout << "\n";
}

void set_rect(rect &R, rect R_1){	
	R.x = R_1.x;	
	R.y = R_1.y;
}

int get_loc(string loc_data, int id, rect &R, double &D){
	ifstream loc_file(loc_data);
	if (!loc_file.is_open()) 
		return -1;
	
	double temp;
	for (int i = 0; i < id; i++)
		for (int j = 0; j < 3; j++)
			loc_file >> temp;
	loc_file >>  R.x;
	loc_file >>  R.y;
	loc_file >>  D;
	
	loc_file.close();
	
	return 0;
}

int get_client_ip(int cli_fd){
	struct sockaddr_in cli_addr;
	socklen_t clilen = sizeof(cli_addr);
	getpeername(cli_fd, (struct sockaddr *)(&cli_addr), &clilen);
	int client_ip = cli_addr.sin_addr.s_addr;
	return client_ip;
}

string ip_int2str(int ip_int){
	struct in_addr ip_struct;
    ip_struct.s_addr = ip_int;
	string ip_string = inet_ntoa(ip_struct);
	return ip_string;
}

#if PRIVACY	
#if (!SINGLE_THREAD)
void *intersection_GC(void* I){
	int_data *I_data;
	I_data = (int_data*)I;
	
	if (I_data->id == 0){
		cout << "Core " << I_data->id << " (Garbler) input:\t" << I_data->input_str_0 << endl;
#if SEQUENTIAL
		GarbleStr(INTERSECTION_SEQ_SCD, "", "", I_data->input_str_0, "", 3*BIT_LEN+13, I_data->intersection_output_mask, 0, (OutputMode)2, 0, 0, &(I_data->output_str), I_data->h_connfd);
#else	
		GarbleStr(INTERSECTION_COMB_SCD, "", "", "", I_data->input_str_0, 1, I_data->intersection_output_mask, 0, (OutputMode)0, 0, 0, &(I_data->output_str), I_data->h_connfd);
#endif
		cout << "Core " << I_data->id << " (Garbler) output:\t" << I_data->output_str << endl;
	}
	else {
		cout << "Core " << I_data->id << "(Evaluator) input:\t\t" << I_data->input_str_0 << endl;
#if SEQUENTIAL
		EvaluateStr(INTERSECTION_SEQ_SCD, "", "", I_data->input_str_0, "", 3*BIT_LEN+13, I_data->intersection_output_mask, 0, (OutputMode)2, 0, 0, &(I_data->output_str), I_data->h_connfd);
#else	
		EvaluateStr(INTERSECTION_COMB_SCD, "", "", "", I_data->input_str_0, 1, I_data->intersection_output_mask, 0, (OutputMode)0, 0, 0, &(I_data->output_str), I_data->h_connfd);
#endif
		cout << "Core " << I_data->id << "(Evaluator) output:\t" << I_data->output_str << endl;
	}
	
	pthread_mutex_lock(&running_mutex);
		running_threads--;
	pthread_mutex_unlock(&running_mutex);
	
	return 0;
}

void *inside_GC(void* I){
	int_data *I_data;
	I_data = (int_data*)I;
	string in_range_dummy;
	
	if (I_data->id == 0){
		cout << "Core " << I_data->id << " input:\t" << I_data->input_str_1 << endl;
		GarbleStr(INSIDE_SCD, "", "", "", I_data->input_str_1, 1, "1", 0, (OutputMode)0, 0, 0, &(I_data->output_str), I_data->h_connfd);
		cout << "Core " << I_data->id << " output:\t" << I_data->output_str << endl;
	}
	else {
		cout << "Core " << I_data->id << " input:\t" << I_data->input_str_0 << endl;
		EvaluateStr(INSIDE_SCD, "", "", "", I_data->input_str_0, 1, "1", 0, (OutputMode)0, 0, 0, &in_range_dummy, I_data->h_connfd);
	}
	
	pthread_mutex_lock(&running_mutex);
		running_threads--;
	pthread_mutex_unlock(&running_mutex);
	
	return 0;
}
#endif //(!SINGLE_THREAD)
#else //PRIVACY
vector <rect> intersection (rect B, double rB, rect C, double rC){	
	vector <rect> E(2);	
	double p, q, t, s, u, w, z;
	
	p = C.x - B.x;
	q = B.y - C.y;
	t = rB*rB - rC*rC + (C.x)*(C.x) - (B.x)*(B.x) + (C.y)*(C.y) - (B.y)*(B.y);
	s = 4*p*p*(B.y)*(B.y) + t*t - 4*p*t*B.x + 4*p*p*(B.x)*(B.x) - 4*p*p*rB*rB;
	u = (q*t - 2*B.y*p*p - 2*p*q*B.x);
	w = sqrt(u*u - s*(p*p + q*q));

	E[0].y = ( p*q*B.x + B.y*p*p - .5*q*t + w/2 )/( p*p + q*q);
	E[1].y = ( p*q*B.x + B.y*p*p - .5*q*t - w/2 )/( p*p + q*q);

	z = rB*rB - rC*rC + (C.x)*(C.x) - (B.x)*(B.x) + (C.y)*(C.y) - (B.y)*(B.y);

	E[0].x = (2*E[0].y*(B.y - C.y) +  z)/(2*(C.x - B.x));
	E[1].x = (2*E[1].y*(B.y - C.y) +  z)/(2*(C.x - B.x));
	
	return E;
}	

bool inside (rect D, rect A, double rA){
	bool in;
	double H;
	
	H = ((D.x - A.x)*(D.x - A.x) + (D.y - A.y)*(D.y - A.y));	
	in = (H <= rA*rA);
	
	return in;
}
#endif //PRIVACY

int lost_car(vector<int> &port){
	
	int id;
	//establish connection with three helping cars 
	vector<int> connfd(3);
	for (id = 0; id < 3; id++)
		if ((connfd[id] = ServerInit(port[id])) == -1) {
			cout << "Cannot open the socket in port " << port[id] << " with Car " << id << endl;
			return -1;
		}
	
	uint64_t delta_time = RDTSC;
	struct timeval tp;
	double t0, t1;
	gettimeofday(&tp, NULL);
	t0 = (tp.tv_sec)*1000 + (tp.tv_usec)/1000;
	
	//provide each car an id and get server ips and port numbers they use to establish connection with other cars
	vector<int> h_client_ip(3);
	vector<int> h_port(3);	
	for (id = 0; id < 3; id++){
		SendData(connfd[id], &id, sizeof(int));
		h_client_ip[id] = get_client_ip(connfd[id]);
		RecvData(connfd[id], &h_port[id], sizeof(int));
	}
	
	//provide each car server ip and port number of its server car
	for (id = 0; id < 3; id++){
		SendData(connfd[id], &h_client_ip[(id+2)%3], sizeof(int));
		SendData(connfd[id], &h_port[(id+2)%3], sizeof(int));
	}
	
	//manage connection establishment of the helping cars
	int done, ser = 0, cli = 1; 
	for (id = 0; id < 3; id++){
		SendData(connfd[id], &ser, sizeof(int));
		SendData(connfd[(id+1)%3], &cli, sizeof(int));
		RecvData(connfd[(id+1)%3], &done, sizeof(int));
	}
	
	//compute median through secure sum protocol
	rect Q, M;
	
	M.x = rand()%255 + rand()/255;
	M.y = rand()%255 + rand()/255;
	
	SendData(connfd[0], &M.x, sizeof(double));
	SendData(connfd[0], &M.y, sizeof(double));
	
	RecvData(connfd[2], &Q.x, sizeof(double));
	RecvData(connfd[2], &Q.y, sizeof(double));
	
	Q.x = (Q.x - M.x)/3;
	Q.y = (Q.y - M.y)/3;
	
	cout << "\nLocation of lost car: ";
	print_rect(Q);	
	
	for (id = 0; id < 3; id++)
		ServerClose(connfd[id]);
	
	delta_time = RDTSC - delta_time;	
	gettimeofday(&tp, NULL);
	t1 = (tp.tv_sec)*1000 + ((double)tp.tv_usec)/1000;
	cout << "total time: " << delta_time << " cc, " << (t1 - t0) << " ms" << endl << endl; 
	
	return 0;	
}

int helping_car(string l_server_ip, vector<int> &port, string loc_data){
	
	int i;
	
	//connect to lost car
	int connfd;
	if ((connfd = ClientInit(l_server_ip.c_str(), port[0])) == -1) {
      cout << "Cannot connect to " << l_server_ip << ":" << port[0] << endl;
      return -1;
    }
	
	//get id from lost car, provide port number for its server for other helping car and get server ip and port number of the car to which its a client
	int h_server_ip_int;
	string h_server_ip;
	vector<int> h_port(2);
	h_port[0] = port[1];	
	int id;
	RecvData(connfd, &id, sizeof(int));
	SendData(connfd, &h_port[0], sizeof(int));		
	RecvData(connfd, &h_server_ip_int, sizeof(int));
	h_server_ip = ip_int2str(h_server_ip_int);
	RecvData(connfd, &h_port[1], sizeof(int));
	
	//establish connection with the two other helping cars
	int ser_cli, done = 1;
	vector<int> h_connfd(2);
	
	for (i = 0; i < 2; i++){
		RecvData(connfd, &ser_cli, sizeof(int));
		if (ser_cli == 0){
			if ((h_connfd[0] = ServerInit(h_port[0])) == -1) {
				cout << "Cannot open the socket in port " << h_port[0] << " with Car " << (id+1)%3 << endl;
				return -1;
			}
			SendData(h_connfd[0], &id, sizeof(int));
		}
		else{
			if ((h_connfd[1] = ClientInit(h_server_ip.c_str(), h_port[1])) == -1) {
					cout << "Cannot connect to " << h_server_ip << ":" << h_port[1] << " with Car " << (id+2)%3 << endl;
					return -1;
				}
			int other_id;
			RecvData(h_connfd[1], &other_id, sizeof(int));
			cout << "Car " << id << " established connection with car " << other_id << endl;
			SendData(connfd, &done, sizeof(int));
		}
	}

	//set sequence of operation according to id
	vector <int> op(2);
	if (id == 0){
		op[0] = 0;
		op[1] = 1;
	}
	else{
		op[0] = 1;
		op[1] = 0;
	}	
	
	//triangle localization	
	rect loc; // location of the assisting car, 
	double dist; // distance from the lost car
	vector <rect> intersect(2); // two intersections with two assisting cars (one from each pair of intersection with each car)
	vector <int> in(2); // whether or not the intersection known to this assisting car forms one vertex of the triangle
	if (get_loc(loc_data, id, loc, dist) < 0){
		cout << "Error can't open location data file: " << loc_data << endl;
		return -1;
	}
	cout << "\nLocation of assisting car " << id << ": ";
	print_rect(loc);
	cout << "Distance from lost car: " << dist << endl << endl;

#if PRIVACY	
	vector<uint64_t> input(3);
	vector<uint16_t> input_bit_len(3);
	input[0] = loc.x;
	input[1] = loc.y;
	input[2] = dist;
	input_bit_len[0] = BIT_LEN;
	input_bit_len[1] = BIT_LEN;
	input_bit_len[2] = BIT_LEN+1;
	string input_str = formatGCInputString(input, input_bit_len);
	
	vector <string> output_str_int(2);
	string in_range, in_range_dummy;
	string intersection_output_mask = formatGCOutputMask(2*BIT_LEN+4, 2*BIT_LEN+4, true);	

#if SINGLE_THREAD		
	for (i = 0; i < 2; i++){		
		if (op[i] == 0){// initiate computation of one pair of intersections			
			cout << "Garbler input: " << input_str << endl;
#if SEQUENTIAL
			CHECK(GarbleStr(INTERSECTION_SEQ_SCD, "", "", input_str, "", 3*BIT_LEN+13, intersection_output_mask, 0, (OutputMode)2, 0, 0, &output_str_int[0], h_connfd[0]));
#else
			CHECK(GarbleStr(INTERSECTION_COMB_SCD, "", "", "", input_str, 1, intersection_output_mask, 0, (OutputMode)0, 0, 0, &output_str_int[0], h_connfd[0]));
#endif
			cout << "Garbler output: " << output_str_int[0] << endl;
		}
		else if (op[i] == 1){ // compute intersections						
			cout << "Evaluator input: " << input_str << endl;
#if SEQUENTIAL
			CHECK(EvaluateStr(INTERSECTION_SEQ_SCD, "", "", input_str, "", 3*BIT_LEN+13, intersection_output_mask, 0, (OutputMode)2, 0, 0, &output_str_int[1], h_connfd[1]));
#else	
			CHECK(EvaluateStr(INTERSECTION_COMB_SCD, "", "", "", input_str, 1, intersection_output_mask, 0, (OutputMode)0, 0, 0, &output_str_int[1], h_connfd[1]));
#endif	
			cout << "Evaluator output: " << output_str_int[1] << endl;				
		}
	}
	
	for (i = 0; i < 2; i++){		
		if (op[i] == 0){// check which one is valid				
			cout << "Garbler input: " << output_str_int[1] << endl;
			CHECK(GarbleStr(INSIDE_SCD, "", "", "", output_str_int[1], 1, "1", 0, (OutputMode)0, 0, 0, &in_range, h_connfd[0]));
			cout << "Garbler output: " << in_range << endl;				
		}
		else if (op[i] == 1){ // help check validity of the intersections			
			cout << "Evaluator input: " << input_str << endl;
			CHECK(EvaluateStr(INSIDE_SCD, "", "", "", input_str, 1, "1", 0, (OutputMode)0, 0, 0, &in_range_dummy, h_connfd[1]));	
			cout << "Evaluator output: " << endl;
		}
	}
#else	//SINGLE_THREAD	
	int_data *I_data = new int_data[2];	
	pthread_t *threads = new pthread_t[2];

	for (i = 0; i < 2; i++){
		I_data[i].id = i;
		I_data[i].input_str_0 = input_str;
		I_data[i].h_connfd = h_connfd[i];
		I_data[i].intersection_output_mask = intersection_output_mask;
	}
	
	for (i = 0; i < 2; i++){
		pthread_mutex_lock(&running_mutex);
		running_threads++;
		pthread_mutex_unlock(&running_mutex);
		pthread_create(&threads[i], NULL, intersection_GC, (void *)&I_data[i]);
	}
	
	while (running_threads > 0);	
	
	for (i = 0; i < 2; i++)
		output_str_int[i] = I_data[i].output_str;
	
	for (i = 0; i < 2; i++){
		I_data[i].input_str_1 = I_data[1].output_str;
	}
	
	for (i = 0; i < 2; i++){
		pthread_mutex_lock(&running_mutex);
		running_threads++;
		pthread_mutex_unlock(&running_mutex);
		pthread_create(&threads[i], NULL, inside_GC, (void *)&I_data[i]);
	}
	
	while (running_threads > 0);	
	
	in_range = I_data[0].output_str;
#endif	//SINGLE_THREAD	

	vector<uint16_t> offset(2); //offset from right
	offset[0] = 2*BIT_LEN+4;
	offset[1] = 0;
	vector<int64_t> output(2);
	vector<uint16_t> ourput_bit_len(2);
	ourput_bit_len[0] = BIT_LEN+2;
	ourput_bit_len[1] = BIT_LEN+2;
	for (i = 0; i < 2; i++){
		parseGCOutputString(output, output_str_int[i], ourput_bit_len, offset[i]);
		intersect[i].x = output[0];
		intersect[i].y = output[1];
	}
	
	in[1] = atoi(in_range.c_str());
	
#else	//PRIVACY
	vector <rect> intersect_temp(2);
	vector <rect> L(2); 
	vector <double> D(2);
	L[0] = loc;
	D[0] = dist;
	
	for (i = 0; i < 2; i++){		
		if (op[i] == 0){// initiate computation of one pair of intersections			
			SendData(h_connfd[0], &(L[0].x), sizeof(double));
			SendData(h_connfd[0], &(L[0].y), sizeof(double));
			SendData(h_connfd[0], &D[0], sizeof(double));			
			RecvData(h_connfd[0], &(intersect[0].x), sizeof(double));
			RecvData(h_connfd[0], &(intersect[0].y), sizeof(double));	
		}
		else if (op[i] == 1){ // compute intersections		
			RecvData(h_connfd[1], &(L[1].x), sizeof(double));
			RecvData(h_connfd[1], &(L[1].y), sizeof(double));
			RecvData(h_connfd[1], &D[1], sizeof(double)); 			
			intersect_temp = intersection(L[0], D[0], L[1], D[1]);
			set_rect(intersect[1], intersect_temp[1]);			
			SendData(h_connfd[1], &(intersect_temp[0].x), sizeof(double));
			SendData(h_connfd[1], &(intersect_temp[0].y), sizeof(double));					
		}
	}
	
	for (i = 0; i < 2; i++){		
		if (op[i] == 0){// check which one is valid				
			RecvData(h_connfd[0], &(L[1].x), sizeof(double));
			RecvData(h_connfd[0], &(L[1].y), sizeof(double));
			RecvData(h_connfd[0], &(D[1]), sizeof(double));			
			in[1] = (int)(inside(intersect[1], L[1], D[1]));			
		}
		else if (op[i] == 1){ // help check validity of the intersections	
			SendData(h_connfd[1], &(L[0].x), sizeof(double));
			SendData(h_connfd[1], &(L[0].y), sizeof(double));
			SendData(h_connfd[1], &(D[0]), sizeof(double));	
		}
	}
#endif //PRIVACY

	for (i = 0; i < 2; i++){		
		if (op[i] == 0){ // receive validity info									
			RecvData(h_connfd[0], &in[0], sizeof(int));
		}
		else if (op[i] == 1){ // send validity info	
			SendData(h_connfd[1], &in[1], sizeof(int));
		}
	}
	
	cout << "\nIntersection computed as garbler: ";
	print_rect(intersect[0]);
	if (!in[0]) cout << "Intersection is in range" << endl;
	else cout << "Intersection is not in range" << endl;
	cout << "Intersection computed as evaluator: ";
	print_rect(intersect[1]);
	if (in[1]) cout << "Intersection is in range" << endl << endl;
	else cout << "Intersection is not in range" << endl << endl;
		
	//secure sum protocol
	
	rect S;
	S.x = 0;
	S.y = 0;
	if(!in[0]){
		S.x = S.x + intersect[0].x;
		S.y = S.y + intersect[0].y;
	}				
	if(in[1]){
		S.x = S.x + intersect[1].x;
		S.y = S.y + intersect[1].y;
	}
	
	rect T;
	
	if (id == 0){
		RecvData(connfd, &T.x, sizeof(double));
		RecvData(connfd, &T.y, sizeof(double));
	}
	else{
		RecvData(h_connfd[1], &T.x, sizeof(double));
		RecvData(h_connfd[1], &T.y, sizeof(double));
	}
		
	T.x = T.x + S.x;
	T.y = T.y + S.y;		
		
	if (id == 2){
		SendData(connfd, &T.x, sizeof(double));
		SendData(connfd, &T.y, sizeof(double));
	}
	else{
		SendData(h_connfd[0], &T.x, sizeof(double));
		SendData(h_connfd[0], &T.y, sizeof(double));
	}
	
	ClientClose(connfd);
	ServerClose(h_connfd[0]);
	ClientClose(h_connfd[1]);
	
	return 0;
}
