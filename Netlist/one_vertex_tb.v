`timescale 1ns / 1ps

module one_vertex_tb;

parameter N = 8;

	// Inputs	
	reg [N-1:0]	xU, yU, xV, yV, xW, yW;
	reg [N:0]	rU, rV, rW;

	// Outputs	
	wire	signed	[N+1:0]	xT, yT;
	
	// Instantiate the Unit Under Test (UUT)
	one_vertex #(.N(N)) uut (
		.xU(xU),
		.yU(yU),
		.xV(xV),
		.yV(yV),
		.xW(xW),
		.yW(yW),
		.rU(rU),
		.rV(rV),
		.rW(rW),
		.xT(xT),
		.yT(yT)
	);

	initial begin
		// Initialize Inputs
		xU = -16;
		yU = -111;
		xV = 109;
		yV = -99;
		xW = -32;
		yW = 108;
		rU = 236;
		rV = 183;
		rW = 215;
	end
	  
endmodule

