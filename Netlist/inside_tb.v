`timescale 1ns / 1ps

module inside_tb;

parameter N = 8;

	// Inputs	
	reg [N+1:0]	xP, yP;
	reg [N-1:0]	xJ, yJ;
	reg [N:0]	rJ;

	// Outputs
	wire			in_range;

	// Instantiate the Unit Under Test (UUT)
	inside_ #(.N(N)) uut (
		.xP(xP),
		.yP(yP),
		.xJ(xJ),
		.yJ(yJ),
		.rJ(rJ),
		.in_range(in_range)
	);

	initial begin
		xP = 151;
		yP = -276;
		xJ = -32;
		yJ = 108;
		rJ = 215;
		
		#100;
		
		xP = -231;
		yP = 5;
		xJ = 109;
		yJ = -99;
		rJ = 183;
		
		#100;
		
		xP = -72;
		yP = -102;
		xJ = -16;
		yJ = -111;
		rJ = 236;
	end
      
endmodule

