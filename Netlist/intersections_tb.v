`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:44:37 09/10/2015
// Design Name:   intersections
// Module Name:   C:/Users/Rice/Dropbox/TriangleLocalization/NetList/intersections/intersections_tb.v
// Project Name:  intersections
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: intersections
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module intersections_tb;

parameter N = 8;

	// Inputs
	
	wire					[3*N:0]		g_input;
	wire					[3*N:0]		e_input;
	
	reg [N-1:0] xB;
	reg [N-1:0] yB;
	reg [N-1:0] xC;
	reg [N-1:0] yC;
	reg [N:0] rB;
	reg [N:0] rC;

	// Outputs
	wire					[14*N+33:0]	o;
	
	wire	signed	[4*N+9:0]	x1D;
	wire	signed	[3*N+6:0]	y1D;
	wire	signed	[4*N+9:0]	x2D;
	wire	signed	[3*N+6:0]	y2D;
	
	assign	g_input[3*N:2*N+1]	=	xB;		
	assign	g_input[2*N:N+1]		=	yB;		
	assign	g_input[N:0]			=	rB;		
	assign	e_input[3*N:2*N+1]	=	xC;		
	assign	e_input[2*N:N+1]		=	yC;		
	assign	e_input[N:0]			=	rC;		
	assign	x1D	=	o[14*N+33:10*N+24];
	assign	y1D	=	o[10*N+23:7*N+17];
	assign	x2D	=	o[7*N+16:3*N+7];
	assign	y2D	=	o[3*N+6:0];

		// Instantiate the Unit Under Test (UUT)
	intersections #(.N(N)) uut (
		.g_input(g_input),
		.e_input(e_input),
		.o(o)	);

	initial begin
		// Initialize Inputs
		xB = 0;
		yB = 0;
		xC = 0;
		yC = 0;
		rB = 0;
		rC = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		xB = -32;
		yB = 108;
		xC = -16;
		yC = -111;
		rB = 215;
		rC = 236;
		
		#100;
		
		xB = -16;
		yB = -111;
		xC = 109;
		yC = -99;
		rB = 236;
		rC = 183;
		
		#100;
		
		xB = 109;
		yB = -99;
		xC = -32;
		yC = 108;
		rB = 183;
		rC = 215;


	end

      
endmodule

