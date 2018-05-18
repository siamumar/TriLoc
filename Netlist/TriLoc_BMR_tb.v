`timescale 1ns / 1ps

module TriLoc_BMR_tb;

    parameter N = 8;

	// Inputs	
	wire	[9*N+2:0]	p_input;	//A, B, C: 2*N; Q:3*(N+1) 
	//wire	[2*N-1:0]	p0_input; //A
	//wire	[2*N-1:0]	p1_input; //B
	//wire	[2*N-1:0]	p2_input; //C
	//wire	[3*N+2:0]	p3_input; //Q

	// Outputs	
	wire	[2*N+7:0]	o;
	
	// Instantiate the Unit Under Test (UUT)
	TriLoc_BMR #(.N(N)) uut(
		.p_input(p_input),
		//.p0_input(p0_input),
		//.p1_input(p1_input),
		//.p2_input(p2_input),
		//.p3_input(p3_input),
		.o(o)
    );
	
	reg [N-1:0]	xA, yA, xB, yB, xC, yC;
	reg [N:0]	rA, rB, rC;

	wire	signed	[N+3:0]	xM, yM;	
	
	assign	p_input[9*N+2:8*N+3]	=	xA;//p0_input[2*N-1:N]    	=	xA;
	assign	p_input[8*N+2:7*N+3]	=	yA;//p0_input[N-1:0]      	=	yA;
	assign	p_input[7*N+2:6*N+3]	=	xB;//p1_input[2*N-1:N]    	=	xB;
	assign	p_input[6*N+2:5*N+3]	=	yB;//p1_input[N-1:0]      	=	yB;
	assign	p_input[5*N+2:4*N+3]	=	xC;//p2_input[2*N-1:N]    	=	xC;
	assign	p_input[4*N+2:3*N+3]	=	yC;//p2_input[N-1:0]      	=	yC;
	assign	p_input[3*N+2:2*N+2]	=	rA;//p3_input[3*N+2:2*N+2]	=	rA;
	assign	p_input[2*N+1:N+1]  	=	rB;//p3_input[2*N+1:N+1]  	=	rB;
	assign	p_input[N:0]			=	rC;//p3_input[N:0]        	=	rC;
	
	assign	xM	=	o[2*N+7:N+4];
	assign	yM	=	o[N+3:0];
	
	wire signed	[N+3:0]	xM_3, yM_3;
	
	assign xM_3 = xM/3;
	assign yM_3 = yM/3;

	initial begin
		// Initialize Inputs
		xA = -16;
		yA = -111;
		xB = 109;
		yB = -99;
		xC = -32;
		yC = 108;
		rA = 236;
		rB = 183;
		rC = 215;
		
		#100;
		$display("%d\t%d", xM_3, yM_3);
	end
	  
endmodule

