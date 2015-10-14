`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:52:31 09/11/2015 
// Design Name: 
// Module Name:    decision 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module inside_ #(parameter N = 8)(
	input							[2*N-1:0]	g_input,
	input							[3*N:0]		e_input,
	output										o
    );
	 
				wire	signed	[N-1:0]		xD;
				wire	signed	[N-1:0]		yD;
				wire	signed	[N-1:0]		xA;
				wire	signed	[N-1:0]		yA;
				wire	signed	[N:0]			rA;
				wire								in_range;	

	assign 	xD	=	g_input[2*N-1:N];
	assign 	yD	=	g_input[N-1:0];			
	assign	xA	=	e_input[3*N:2*N+1];
	assign	yA	=	e_input[2*N:N+1];
	assign	rA	=	e_input[N:0];
	assign	o	=	~in_range;

				wire	signed	[2*N+2:0]	H;
				wire	signed	[2*N+1:0]	rA_sqr;
				wire	signed	[N:0]			xD_min_xA, yD_min_yA;
				wire	signed	[2*N+1:0]	xD_min_xA_sqr, yD_min_yA_sqr;

	
	//assign	xD_min_xA = xD - xA;
	SUB_ #(.N(N), .M(N)) SUB1 (.A(xD), .B(xA), .O(xD_min_xA));
	//assign	yD_min_yA = yD - yA;
	SUB_ #(.N(N), .M(N)) SUB2 (.A(yD), .B(yA), .O(yD_min_yA));
	//assign	xD_min_xA_sqr = xD_min_xA*xD_min_xA;
	MULT_ #(.N(N+1), .M(N+1)) MULT1 (.A(xD_min_xA), .B(xD_min_xA), .O(xD_min_xA_sqr));
	//assign	yD_min_yA_sqr = yD_min_yA*yD_min_yA;
	MULT_ #(.N(N+1), .M(N+1)) MULT2 (.A(yD_min_yA), .B(yD_min_yA), .O(yD_min_yA_sqr));
		
	//assign	H = xD_min_xA_sqr + yD_min_yA_sqr;
	ADD_ #(.N(2*N+2), .M(2*N+2)) ADD1 (.A(xD_min_xA_sqr), .B(yD_min_yA_sqr), .O(H));
		
	//assign	rA_sqr = rA*rA;	
	MULT_ #(.N(N+1), .M(N+1)) MULT3 (.A(rA), .B(rA), .O(rA_sqr));
		
	//assign	in_range = H <= rA_sqr;
	COMP #(.N(2*N+3), .M(2*N+2)) COMP1 (.A(H), .B(rA_sqr), .O(in_range));

		
endmodule
