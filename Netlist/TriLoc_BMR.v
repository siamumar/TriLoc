`timescale 1ns / 1ps

module TriLoc_BMR #(parameter N = 8)(
	input	[2*N-1:0]	p0_input, //A
	input	[2*N-1:0]	p1_input, //B
	input	[2*N-1:0]	p2_input, //C
	input	[3*N+2:0]	p3_input, //Q
	output	[2*N+7:0]	o
    );
	
	wire	signed	[N-1:0]	xA, yA, xB, yB, xC, yC;
	wire	signed	[N:0]	rA, rB, rC;
	
	wire	signed	[N+3:0]	xM, yM;
	
	assign	xA	=	p0_input[2*N-1:N];
	assign	yA	=	p0_input[N-1:0];
	assign	xB	=	p1_input[2*N-1:N];
	assign	yB	=	p1_input[N-1:0];
	assign	xC	=	p2_input[2*N-1:N];
	assign	yC	=	p2_input[N-1:0];
	assign	rA	=	p3_input[3*N+2:2*N+2];
	assign	rB	=	p3_input[2*N+1:N+1];
	assign	rC	=	p3_input[N:0];
	
	assign	o[2*N+7:N+4]	=	xM;
	assign	o[N+3:0]		=	yM;
	

	TriLoc #(.N(N)) TriLoc (
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