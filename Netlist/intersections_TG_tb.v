`timescale 1ns / 1ps

module intersections_TG_tb;

	parameter N = 8;

	// Inputs	
	wire	[3*N:0]		g_input;
	wire	[3*N:0]		e_input;
	
	// Outputs	
	wire	[4*N+7:0]	o;
	
	intersections_TG #(.N(N)) uut(
		.g_input(g_input),
		.e_input(e_input),
		.o(o)
    );

	reg		signed	[N-1:0]	xK, yK, xL, yL;
	reg		signed	[N:0]	rK, rL;	
	
	wire	signed	[N+1:0]	x1P, y1P, x2P, y2P;
	
	assign	g_input[3*N:2*N+1]	=	xK;	
	assign	g_input[2*N:N+1]  	=	yK;	
	assign	g_input[N:0]		=	rK;	
	assign	e_input[3*N:2*N+1]	=	xL;	
	assign	e_input[2*N:N+1]  	=	yL;	
	assign	e_input[N:0]      	=	rL;	
	
	assign	x1P	=	o[4*N+7:3*N+6];
	assign	y1P	=	o[3*N+5:2*N+4];
	assign	x2P	=	o[2*N+3:N+2];
	assign	y2P =	o[N+1:0];
			
	initial begin
		xK = -16;
		yK = -111;
		xL = 109;
		yL = -99;
		rK = 236;
		rL = 183;
	end
	
endmodule