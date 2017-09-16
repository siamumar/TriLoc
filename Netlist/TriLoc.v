`timescale 1ns / 1ps

module TriLoc #(parameter N = 8)(
	input	signed	[N-1:0]	xA, yA, xB, yB, xC, yC,
	input	signed	[N:0]	rA, rB, rC,
	output	signed	[N+1:0]	xD, yD,	xE, yE,	xF, yF  
);

	one_vertex #(.N(N)) vertex_D (
		.xU(xB),
		.yU(yB),
		.xV(xC),
		.yV(yC),
		.xW(xA),
		.yW(yA),
		.rU(rB),
		.rV(rC),
		.rW(rA),
		.xT(xD),
		.yT(yD)
	);
	
	one_vertex #(.N(N)) vertex_E (
		.xU(xC),
		.yU(yC),
		.xV(xA),
		.yV(yA),
		.xW(xB),
		.yW(yB),
		.rU(rC),
		.rV(rA),
		.rW(rB),
		.xT(xE),
		.yT(yE)
	);
	
	one_vertex #(.N(N)) vertex_F (
		.xU(xA),
		.yU(yA),
		.xV(xB),
		.yV(yB),
		.xW(xC),
		.yW(yC),
		.rU(rA),
		.rV(rB),
		.rW(rC),
		.xT(xF),
		.yT(yF)
	);
	
endmodule