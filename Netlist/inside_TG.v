`timescale 1ns / 1ps

module inside_TG #(parameter N = 8)(
	input	[2*N+3:0]	g_input,
	input	[3*N:0]		e_input,
	output				o
    );
	 
	wire	signed	[N+1:0]	xP, yP;
	wire	signed	[N-1:0]	xJ, yJ;
	wire	signed	[N:0]	rJ;
	wire					in_range;	

	assign 	xP	=	g_input[2*N+3:N+2];
	assign 	yP	=	g_input[N+1:0];			
	assign	xJ	=	e_input[3*N:2*N+1];
	assign	yJ	=	e_input[2*N:N+1];
	assign	rJ	=	e_input[N:0];
	assign	o	=	in_range;
	
	inside_ #(.N(N)) inside_ (
		.xP(xP),
		.yP(yP),
		.xJ(xJ),
		.yJ(yJ),
		.rJ(rJ),
		.in_range(in_range)
	);
	
endmodule