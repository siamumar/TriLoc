`timescale 1ns / 1ps

module TriLoc #(parameter N = 8)(
	input	signed	[N-1:0]	xA, yA, xB, yB, xC, yC,
	input	signed	[N:0]	rA, rB, rC,
	output 	signed	[N+3:0]	xM, yM
);

	wire	signed	[N+1:0]	xD, yD,	xE, yE,	xF, yF;  

	one_vertex  D (
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
	
	one_vertex  E (
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
	
	one_vertex  F (
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
	
	median_x_3  M(
		.xD(xD),
		.yD(yD),
		.xE(xE),
		.yE(yE),
		.xF(xF),
		.yF(yF),
		.xM(xM),
		.yM(yM)
	);
	
endmodule