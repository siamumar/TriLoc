`timescale 1ns / 1ps

module intersections_comb_tb;

parameter N = 8;

	// Inputs	
	reg [N-1:0]	xK, yK, xL, yL;
	reg [N:0]	rK, rL;

	// Outputs	
	wire	signed	[N+1:0]	x1P, y1P, x2P, y2P;
	
	// Instantiate the Unit Under Test (UUT)
	intersections_comb #(.N(N)) uut (
		.xK(xK),
		.yK(yK),
		.xL(xL),
		.yL(yL),
		.rK(rK),
		.rL(rL),
		.x1P(x1P),
		.y1P(y1P),
		.x2P(x2P),
		.y2P(y2P)
	);

	initial begin
		xK = -16;
		yK = -111;
		xL = 109;
		yL = -99;
		rK = 236;
		rL = 183;
	end
	  
endmodule

