`timescale 1ns / 1ps

module median_x_3 #(parameter N = 8)(
	input	signed	[N+1:0]	xD, yD,	xE, yE,	xF, yF,
	output	signed	[N+3:0]	xM, yM
);

	wire	signed	[N+2:0]	xM_1, yM_1;
	
	ADD_ #(.N(N+2), .M(N+2)) ADD_x1 (.A(xD), .B(xE), .O(xM_1));
	ADD_ #(.N(N+2), .M(N+2)) ADD_y1 (.A(yD), .B(yE), .O(yM_1));
	ADD_ #(.N(N+3), .M(N+2)) ADD_x2 (.A(xM_1), .B(xF), .O(xM));
	ADD_ #(.N(N+3), .M(N+2)) ADD_y2 (.A(yM_1), .B(yF), .O(yM));
	
endmodule 