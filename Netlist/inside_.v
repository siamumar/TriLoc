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
	input							[7*N+16:0]	g_input,
	input							[3*N:0]		e_input,
	output										o
    );
	 
				wire	signed	[4*N+9:0]	xD;
				wire	signed	[3*N+6:0]	yD;
				wire	signed	[N-1:0]		xA;
				wire	signed	[N-1:0]		yA;
				wire	signed	[N:0]		rA;
				wire						in_range;	

	assign 	xD	=	g_input[7*N+16:3*N+7];
	assign 	yD	=	g_input[3*N+6:0];			
	assign	xA	=	e_input[3*N:2*N+1];
	assign	yA	=	e_input[2*N:N+1];
	assign	rA	=	e_input[N:0];
	assign	o	=	~in_range;

				wire	signed	[8*N+22:0]	H;
				wire	signed	[2*N+1:0]	rA_sqr;
				wire	signed	[4*N+10:0]	xD_min_xA;
				wire	signed	[3*N+7:0]	yD_min_yA;
				wire	signed	[8*N+21:0]	xD_min_xA_sqr;
				wire	signed	[6*N+15:0]	yD_min_yA_sqr;

	
	//assign	xD_min_xA = xD - xA;
	SUB_ #(.N(4*N+10), .M(N)) SUB1 (.A(xD), .B(xA), .O(xD_min_xA));
	//assign	yD_min_yA = yD - yA;
	SUB_ #(.N(3*N+7), .M(N)) SUB2 (.A(yD), .B(yA), .O(yD_min_yA));
	//assign	xD_min_xA_sqr = xD_min_xA*xD_min_xA;
	MULT_ #(.N(4*N+11), .M(4*N+11)) MULT1 (.A(xD_min_xA), .B(xD_min_xA), .O(xD_min_xA_sqr));
	//assign	yD_min_yA_sqr = yD_min_yA*yD_min_yA;
	MULT_ #(.N(3*N+8), .M(3*N+8)) MULT2 (.A(yD_min_yA), .B(yD_min_yA), .O(yD_min_yA_sqr));
		
	//assign	H = xD_min_xA_sqr + yD_min_yA_sqr;
	ADD_ #(.N(8*N+22), .M(6*N+16)) ADD1 (.A(xD_min_xA_sqr), .B(yD_min_yA_sqr), .O(H));
		
	//assign	rA_sqr = rA*rA;	
	MULT_ #(.N(N+1), .M(N+1)) MULT3 (.A(rA), .B(rA), .O(rA_sqr));
		
	//assign	in_range = H <= rA_sqr;
	COMP #(.N(8*N+23), .M(2*N+2)) COMP1 (.A(H), .B(rA_sqr), .O(in_range));

		
endmodule
