.PHONY: test_triloc_1fun run_lost run_helping

all: 
	g++ -g -o test_triloc_1fun test_triloc_1fun.cpp intersection.cpp inside.cpp util.cpp
	g++ -g -o run_lost lost_car.cpp ../TinyGarbled/eval_netlist/tcpip.cpp
	g++ -g -o run_helping helping_car.cpp ../TinyGarbled/eval_netlist/tcpip.cpp
	