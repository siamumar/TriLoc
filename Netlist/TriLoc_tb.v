`timescale 1ns / 1ps

module TriLoc_tb;

parameter N = 8;

	// Inputs	
	reg [N-1:0]	xA, yA, xB, yB, xC, yC;
	reg [N:0]	rA, rB, rC;

	// Outputs	
	wire	signed	[N+3:0]	xM, yM;
	
	// Instantiate the Unit Under Test (UUT)
	TriLoc #(.N(N)) uut (
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
	end
	  
endmodule

