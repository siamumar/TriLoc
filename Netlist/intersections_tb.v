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

	// Inputs
	
	reg [7:0] xB;
	reg [7:0] yB;
	reg [7:0] xC;
	reg [7:0] yC;
	reg [8:0] rB;
	reg [8:0] rC;

	// Outputs
	wire [7:0] x1E;
	wire [7:0] y1E;
	wire [7:0] x2E;
	wire [7:0] y2E;

	// Instantiate the Unit Under Test (UUT)
	intersections uut (
		.xB(xB), 
		.yB(yB), 
		.xC(xC), 
		.yC(yC), 
		.rB(rB), 
		.rC(rC), 
		.x1E(x1E), 
		.y1E(y1E), 
		.x2E(x2E), 
		.y2E(y2E)
	);

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

