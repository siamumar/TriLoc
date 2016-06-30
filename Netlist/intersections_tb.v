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

//------- RUN SIMULATION FOR 3N+13 CLOCK CYCLES -------

module intersections_tb;

parameter N = 8;

	// Inputs
	reg 									clk, rst;
	wire					[3*N:0]		g_init;
	wire					[3*N:0]		e_init;
	
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
	
	assign	g_init[3*N:2*N+1]	=	xB;		
	assign	g_init[2*N:N+1]		=	yB;		
	assign	g_init[N:0]			=	rB;		
	assign	e_init[3*N:2*N+1]	=	xC;		
	assign	e_init[2*N:N+1]		=	yC;		
	assign	e_init[N:0]			=	rC;		
	assign	x1D	=	o[14*N+33:10*N+24];
	assign	y1D	=	o[10*N+23:7*N+17];
	assign	x2D	=	o[7*N+16:3*N+7];
	assign	y2D	=	o[3*N+6:0];

		// Instantiate the Unit Under Test (UUT)
	intersections #(.N(N)) uut (
		.clk(clk),
		.rst(rst),
		.g_init(g_init),
		.e_init(e_init),
		.o(o)	);
		
	reg [15:0] counter;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		xB = -16;
		yB = -111;
		xC = 109;
		yC = -99;
		rB = 236;
		rC = 183;
		
		#100;
		rst = 0;
	end
	
	always begin
		#50;
		clk = ~clk;
	end
	
	always @(posedge clk)
	if (rst) counter = 0;
	else counter = counter + 1;

      
endmodule

