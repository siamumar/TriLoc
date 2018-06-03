`timescale 1ns / 1ps

module area_BMR #(parameter N = 8)(
	input	[6*N-1:0]	p_input,	//A, B, C: 2*N
	output				o
    );
	
	wire	signed	[N-1:0]	xA, yA, xB, yB, xC, yC;
	
	assign	xA	=	p_input[6*N-1:5*N];
	assign	yA	=	p_input[5*N-1:4*N];
	assign	xB	=	p_input[4*N-1:3*N];
	assign	yB	=	p_input[3*N-1:2*N];
	assign	xC	=	p_input[2*N-1:1*N];
	assign	yC	=	p_input[1*N-1:0*N];	

	area #(.N(N)) A (
		.xA(xA),
		.yA(yA),
		.xB(xB),
		.yB(yB),
		.xC(xC),
		.yC(yC),
		.pass(o)
	);
		  
endmodule

module area #(parameter N = 8)(
	input	signed	[N-1:0]	xA, yA, xB, yB, xC, yC,
	output 					pass
);

wire [N:0] yB_min_yC, yC_min_yA, yA_min_yB;
SUB_ #(.N(N)) SUB1 (.A(yB), .B(yC), .O(yB_min_yC));
SUB_ #(.N(N)) SUB2 (.A(yC), .B(yA), .O(yC_min_yA));
SUB_ #(.N(N)) SUB3 (.A(yA), .B(yB), .O(yA_min_yB));

wire [2*N:0] xA_yB_min_yC, xB_yC_min_yA, xC_yA_min_yB;
MULT_ #(.N(N+1), .M(N)) MULT1 (.A(yB_min_yC), .B(xA), .O(xA_yB_min_yC));
MULT_ #(.N(N+1), .M(N)) MULT2 (.A(yC_min_yA), .B(xB), .O(xB_yC_min_yA));
MULT_ #(.N(N+1), .M(N)) MULT3 (.A(yA_min_yB), .B(xC), .O(xC_yA_min_yB));

wire [2*N+1:0] AREA_0;
wire [2*N+2:0] AREA_1;
wire [2*N+1:0] AREA, AT;
ADD_ #(.N(2*N+1), .M(2*N+1)) ADD1 (.A(xA_yB_min_yC), .B(xB_yC_min_yA), .O(AREA_0));
ADD_ #(.N(2*N+2), .M(2*N+1)) ADD2 (.A(AREA_0), .B(xC_yA_min_yB), .O(AREA_1));
assign AREA = AREA_1[2*N+2:1];
assign AT = 10000;
COMP #(.N(2*N+2), .M(2*N+2)) COMP1 (.A(AREA), .B(AT), .O(pass));

endmodule