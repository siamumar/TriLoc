`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:42:57 09/11/2015
// Design Name:   decision
// Module Name:   C:/Users/Rice/Dropbox/TriangleLocalization/NetList/decision/decision_tb.v
// Project Name:  decision
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: decision
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module inside_tb;

parameter N = 8;

	// Inputs
	wire					[7*N+16:0]	g_input;
	wire					[3*N:0]		e_input;
	
	reg [N-1:0] xD;
	reg [N-1:0] yD;
	reg [N-1:0] xA;
	reg [N-1:0] yA;
	reg [N:0] rA;

	// Outputs
	wire 									o;
	
	wire in_range;
	
	assign 	g_input[7*N+16:3*N+7]	=	xD;	
	assign 	g_input[3*N+6:0]		=	yD;		
	assign	e_input[3*N:2*N+1]		=	xA;	
	assign	e_input[2*N:N+1]		=	yA;	
	assign	e_input[N:0]			=	rA;	
	assign	in_range				=	o;	

	// Instantiate the Unit Under Test (UUT)
	inside_ #(.N(N)) uut (
		.g_input(g_input),
		.e_input(e_input),
		.o(o)	);

	initial begin
		// Initialize Inputs
		xD = 0;
		yD = 0;
		xA = 0;
		yA = 0;
		rA = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		xD = 117;
		yD = 83;
		xA = -32;
		yA = 108;
		rA = 215;
		
		#100;
		
		xD = 170;
		yD = 34;
		xA = 109;
		yA = -99;
		rA = 183;
		
		#100;
		
		xD = 180;
		yD = 70;
		xA = -16;
		yA = -111;
		rA = 236;
		

	end
      
endmodule

