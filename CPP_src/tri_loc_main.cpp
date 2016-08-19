#include <iostream>
#include <vector>
#include <cstring>
#include <cstdlib>
#include <cstdint>
#include <unistd.h>
#include <cmath>
#include <boost/program_options.hpp>
#include <boost/format.hpp>
#include "CPP_src/tri_loc.h"
#include "crypto/OT_extension.h"
#include "util/util.h"
#include "util/log.h"

using namespace std;
namespace po = boost::program_options;

int main(int argc, char* argv[]){
	
	LogInitial(argc, argv);
	HashInit();
	srand(time(0));  // srand(1);
	SrandSSE(time(0));  // SrandSSE(1111);
	
	
	vector<int> port(3);
	string l_server_ip;
	
	boost::format fmter("Privacy Preserving Localization \nAllowed options");
	po::options_description desc(fmter.str());
	desc.add_options()  //
	("help,h", "produce help message")  //
	("lost,l", "the lost car")  //
	("assisting,a", "an assisting car")  //
	("ports,p", po::value<vector<int>>(&port)->default_value(vector<int>{1111, 2222, 3333}, "1111, 2222, 3333")->multitoken(), "socket ports")  //
	("server_ip,s", po::value<string>(&l_server_ip)->default_value("127.0.0.1"), "server ip of lost car");

	po::variables_map vm;
	try {
		po::parsed_options parsed = po::command_line_parser(argc, argv).options(desc).allow_unregistered().run();
		po::store(parsed, vm);
		if (vm.count("help")) {
			std::cout << desc << endl;
			return SUCCESS;
	}
		po::notify(vm);
	}catch (po::error& e) {
		cout << "ERROR: " << e.what() << endl << endl;
		cout << desc << endl;
		return FAILURE;
	}

	if (vm.count("lost") == 0 && vm.count("assisting") == 0) {
		cout << "One of --lost or --assisting mode flag should be used." << endl<< endl;
		cout << desc << endl;
		return FAILURE;
	}
  
	if (vm.count("lost")){
		cout << "The lost car opening ports at ";
		for (int i = 0; i < 3; i++)
			cout << port[i] << " ";
		cout << endl;
		lost_car(port);
	}
	
	else if (vm.count("assisting")){
		if (port[1] == 0) port[1] = rand()%9000+777;
		cout << "Connecting to lost car at " << l_server_ip << ":" << port[0] << endl;
		cout << "Opening port for another assisting car at " << port[1] << endl << endl;
		helping_car(l_server_ip, port);
	}
}

