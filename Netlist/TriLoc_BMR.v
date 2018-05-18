`timescale 1ns / 1ps

module TriLoc_BMR #(parameter N = 8)(
	input	[9*N+2:0]	p_input,	//A, B, C: 2*N; Q:3*(N+1) 
	//input	[2*N-1:0]	p0_input, //A
	//input	[2*N-1:0]	p1_input, //B
	//input	[2*N-1:0]	p2_input, //C
	//input	[3*N+2:0]	p3_input, //Q
	output	[2*N+7:0]	o
    );
	
	wire	signed	[N-1:0]	xA, yA, xB, yB, xC, yC;
	wire	signed	[N:0]	rA, rB, rC;
	
	wire	signed	[N+3:0]	xM, yM;
	
	assign	xA	=	p_input[9*N+2:8*N+3];//p0_input[2*N-1:N];
	assign	yA	=	p_input[8*N+2:7*N+3];//p0_input[N-1:0];
	assign	xB	=	p_input[7*N+2:6*N+3];//p1_input[2*N-1:N];
	assign	yB	=	p_input[6*N+2:5*N+3];//p1_input[N-1:0];
	assign	xC	=	p_input[5*N+2:4*N+3];//p2_input[2*N-1:N];
	assign	yC	=	p_input[4*N+2:3*N+3];//p2_input[N-1:0];
	assign	rA	=	p_input[3*N+2:2*N+2];//p3_input[3*N+2:2*N+2];
	assign	rB	=	p_input[2*N+1:N+1];//p3_input[2*N+1:N+1];
	assign	rC	=	p_input[N:0];//p3_input[N:0];
	
	assign	o[2*N+7:N+4]	=	xM;
	assign	o[N+3:0]		=	yM;
	

	TriLoc #(.N(N)) T (
		.xA(xA),
		.yA(yA),
		.xB(xB),
		.yB(yB),
		.xC(xC),
		.yC(yC),
		.rA(rA),
		.rB(rB),
		.rC(rC),
		.xM(xM),
		.yM(yM)
	);
		  
endmodule