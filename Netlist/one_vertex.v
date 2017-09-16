`timescale 1ns / 1ps

module one_vertex #(parameter N = 8)(
	input	signed	[N-1:0]	xU, yU, xV, yV, xW, yW,
	input	signed	[N:0]	rU, rV, rW,
	output	signed	[N+1:0]	xT, yT   
);

	wire	signed	[N+1:0]	x1S, y1S, x2S, y2S;

	intersections_comb #(.N(N)) intersectionsUV(
		.xK(xU),
		.yK(yU),
		.xL(xV),
		.yL(yV),
		.rK(rU),
		.rL(rV),
		.x1P(x1S),
		.y1P(y1S),
		.x2P(x2S),
		.y2P(y2S)
	);
	
	wire in_range;
	
	inside_ #(.N(N)) inside2S(
		.xP(x2S),
		.yP(y2S),
		.xJ(xW),
		.yJ(yW),
		.rJ(rW),
		.in_range(in_range)
	);
	
	MUX #(.N(N+2)) MUX_X(
		.A(x1S),
		.B(x2S),
		.S(in_range),
		.O(xT)
	);
	
	MUX #(.N(N+2)) MUX_Y(
		.A(y1S),
		.B(y2S),
		.S(in_range),
		.O(yT)
	);
	
endmodule 