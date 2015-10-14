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
	wire					[4*N-1:0]	o;
	
	wire [N-1:0] x1D;
	wire [N-1:0] y1D;
	wire [N-1:0] x2D;
	wire [N-1:0] y2D;
	
	assign	g_input[3*N:2*N+1]	=	xB;		
	assign	g_input[2*N:N+1]	=	yB;		
	assign	g_input[N:0]		=	rB;		
	assign	e_input[3*N:2*N+1]	=	xC;		
	assign	e_input[2*N:N+1]	=	yC;		
	assign	e_input[N:0]		=	rC;		
	assign	x1D	=	o[4*N-1:3*N];
	assign	y1D	=	o[3*N-1:2*N];
	assign	x2D	=	o[2*N-1:N];
	assign	y2D	=	o[N-1:0];

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
        
		// Add stimulus here
		xB = -16;
		yB = -24;
		xC = 109;
		yC = -9;
		rB = 89;
		rC = 75;
		
		#100;

	end

      
endmodule

