`timescale 1ns / 1ps

module TriLoc_BMR #(parameter N = 8)(
	input	[9*N+2:0]	p_input,	//A, B, C: 2*N; Q:3*(N+1) 
	output	[2*N+7:0]	o
    );
	
	wire	signed	[N-1:0]	xA, yA, xB, yB, xC, yC;
	wire	signed	[N:0]	rA, rB, rC;
	
	wire	signed	[N+3:0]	xM, yM;
	
	assign	xA	=	p_input[9*N+2:8*N+3];
	assign	yA	=	p_input[8*N+2:7*N+3];
	assign	xB	=	p_input[7*N+2:6*N+3];
	assign	yB	=	p_input[6*N+2:5*N+3];
	assign	xC	=	p_input[5*N+2:4*N+3];
	assign	yC	=	p_input[4*N+2:3*N+3];
	assign	rA	=	p_input[3*N+2:2*N+2];
	assign	rB	=	p_input[2*N+1:N+1];
	assign	rC	=	p_input[N:0];
	
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