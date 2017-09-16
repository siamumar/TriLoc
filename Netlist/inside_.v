`timescale 1ns / 1ps

module inside_ #(parameter N = 8)(
	input	signed	[N+1:0]	xP, yP,
	input	signed	[N-1:0]	xJ, yJ,
	input	signed	[N:0]	rJ,
	output					in_range
);
	wire not_in_range;
	assign in_range = ~not_in_range;

	wire	signed	[2*N+6:0]	H;
	wire	signed	[2*N+1:0]	rJ_sqr;
	wire	signed	[N+2:0]		xP_min_xJ, yP_min_yJ;
	wire	signed	[2*N+5:0]	xP_min_xJ_sqr, yP_min_yJ_sqr;

	
	SUB_ #(.N(N+2), .M(N)) SUB1 (.A(xP), .B(xJ), .O(xP_min_xJ)); //xP_min_xJ : N+3
	SUB_ #(.N(N+2), .M(N)) SUB2 (.A(yP), .B(yJ), .O(yP_min_yJ)); //yP_min_yJ : N+3
	MULT_ #(.N(N+3), .M(N+3)) MULT1 (.A(xP_min_xJ), .B(xP_min_xJ), .O(xP_min_xJ_sqr)); //xP_min_xJ_sqr : 2N+6
	MULT_ #(.N(N+3), .M(N+3)) MULT2 (.A(yP_min_yJ), .B(yP_min_yJ), .O(yP_min_yJ_sqr)); //yP_min_yJ_sqr : 2N+6
		
	ADD_ #(.N(2*N+6), .M(2*N+6)) ADD1 (.A(xP_min_xJ_sqr), .B(yP_min_yJ_sqr), .O(H)); //H: 2N+7
		
	MULT_ #(.N(N+1), .M(N+1)) MULT3 (.A(rJ), .B(rJ), .O(rJ_sqr)); //rJ_sqr : 2N+2
		
	COMP #(.N(2*N+7), .M(2*N+2)) COMP1 (.A(H), .B(rJ_sqr), .O(not_in_range));

		
endmodule
