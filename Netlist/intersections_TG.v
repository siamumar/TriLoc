`timescale 1ns / 1ps

module intersections_TG #(parameter N = 8)(
	input	[3*N:0]		g_input,
	input	[3*N:0]		e_input,
	output	[4*N+7:0]	o
    );
	
	wire	signed	[N-1:0]	xK, yK, xL, yL;
	wire	signed	[N:0]	rK, rL;	
	wire	signed	[N+1:0]	x1P, y1P, x2P, y2P;
	
	assign	xK	=	g_input[3*N:2*N+1];
	assign	yK	=	g_input[2*N:N+1];
	assign	rK	=	g_input[N:0];			
	assign	xL	=	e_input[3*N:2*N+1];
	assign	yL	=	e_input[2*N:N+1];
	assign	rL	=	e_input[N:0];
	
	assign	o[4*N+7:3*N+6]	=	x1P;
	assign	o[3*N+5:2*N+4]	=	y1P;
	assign	o[2*N+3:N+2]  	=	x2P;
	assign	o[N+1:0]	   	=	y2P;
	

	intersections #(.N(N)) intersections (
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
	  
endmodule

