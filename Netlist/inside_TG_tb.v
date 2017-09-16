`timescale 1ns / 1ps

module inside_TG_tb;

	parameter N = 8;

	// Inputs	
	wire	[2*N+3:0]	g_input;
	wire	[3*N:0]		e_input;
	
	// Outputs	
	wire				o;
	
	inside_TG #(.N(N)) uut(
		.g_input(g_input),
		.e_input(e_input),
		.o(o)
    );

	 
	reg	signed	[N+1:0]	xP, yP;
	reg	signed	[N-1:0]	xJ, yJ;
	reg	signed	[N:0]	rJ;
	
	wire				in_range;	

	assign 	g_input[2*N+3:N+2]	=	xP;
	assign 	g_input[N+1:0]		=	yP;		
	assign	e_input[3*N:2*N+1]	=	xJ;
	assign	e_input[2*N:N+1]	=	yJ;
	assign	e_input[N:0]		=	rJ;
	assign	in_range		  	=	o;
			
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