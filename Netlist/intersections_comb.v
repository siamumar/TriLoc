`timescale 1ns / 1ps

module intersections_comb #(parameter N = 8)(
	input	signed	[N-1:0]	xK, yK, xL, yL,
	input	signed	[N:0]	rK, rL,
	output	signed	[N+1:0]	x1P, y1P, x2P, y2P    
);
	

	wire	signed	[N:0]		p, q;
	wire	signed	[2*N+3:0]	t;
	wire	signed	[4*N+9:0]	s;
	wire	signed	[3*N+5:0]	u;
	wire	signed	[6*N+13:0]	w_sqr;
	wire	signed	[3*N+6:0]	w;
	wire	signed	[2*N+5:0]	z;
	
	wire	signed	[2*N-1:0]	xK_sqr, yK_sqr, xL_sqr, yL_sqr;
 	wire	signed	[2*N+1:0]	rK_sqr, rL_sqr;
	wire	signed	[2*N+1:0]	p_sqr, q_sqr;
	wire	signed	[4*N+7:0]	t_sqr;
	wire	signed	[6*N+11:0]	u_sqr;	
	
	wire	signed	[4*N+1:0]	pxK_sqr, pyK_sqr;
	wire	signed	[4*N+3:0] 	prK_sqr;
	wire	signed	[4*N+4:0] 	ptxK;
	wire	signed	[3*N+4:0]	qt;
	wire	signed	[3*N+1:0]	yK_p_sqr;
	wire	signed	[2*N:0]		pxK;
	wire	signed	[3*N+1:0]	pqxK;
	
	wire	signed	[2*N+2:0]	rK_min_rL_sqr;
	wire	signed	[2*N:0]		xL_min_xK_sqr;
	wire	signed	[2*N:0]		yL_min_yK_sqr;
	wire	signed	[2*N+1:0]	xL_min_xK_plus_yL_min_yK_sqr;
					
	wire	signed	[4*N+2:0]	pyK_sqr_plus_pxK_sqr;
	wire	signed	[4*N+5:0]	prK_sqr_plus_ptxK;
	wire	signed	[4*N+6:0]	pyK_sqr_plus_pxK_sqr_min_prK_sqr_plus_ptxK;
	wire	signed	[3*N+2:0]	yK_p_sqr_plus_pqxK;
			
	wire	signed	[3*N+5:0]	yK_p_sqr_plus_pqxK_min_qt_by_2;
	wire	signed	[3*N+6:0]	y1P_top, y2P_top;
	wire	signed	[3*N+6:0]	y1P_ext, y2P_ext;  
	
	wire	signed	[2*N+2:0]	p_sqr_plus_q_sqr;
	wire	signed	[6*N+12:0]	s_times_p_sqr_plus_q_sqr;  
	wire	signed	[2*N+2:0]	y1Pq, y2Pq;
	wire	signed	[2*N+4:0]	x1P_top, x2P_top;
	wire	signed	[2*N+4:0]	x1P_ext, x2P_ext;
				

	MULT_ #(.N(N), .M(N)) MUL1 (.A(xK), .B(xK), .O(xK_sqr)); //xK_sqr : 2N
	MULT_ #(.N(N), .M(N)) MUL2 (.A(yK), .B(yK), .O(yK_sqr)); //yK_sqr : 2N
	MULT_ #(.N(N), .M(N)) MUL3 (.A(xL), .B(xL), .O(xL_sqr)); //xL_sqr : 2N
	MULT_ #(.N(N), .M(N)) MUL4 (.A(yL), .B(yL), .O(yL_sqr)); // yL_sqr :2N
	MULT_ #(.N(N+1), .M(N+1)) MUL5 (.A(rK), .B(rK), .O(rK_sqr)); //rK_sqr : 2N+2
	MULT_ #(.N(N+1), .M(N+1)) MUL6 (.A(rL), .B(rL), .O(rL_sqr)); //rL_sqr : 2N+2
			
	SUB_ #(.N(N), .M(N)) SUB1 (.A(xL), .B(xK), .O(p)); //P : N+1
	SUB_ #(.N(N), .M(N)) SUB2 (.A(yK), .B(yL), .O(q));	//q: N+1
	MULT_ #(.N(N+1), .M(N+1)) MUL7 (.A(p), .B(p), .O(p_sqr)); //p_sqr : 2N+2
	MULT_ #(.N(N+1), .M(N+1)) MUL8 (.A(q), .B(q), .O(q_sqr)); //q_sqr : 2N+2
	MULT_ #(.N(2*N+2), .M(2*N)) MUL9 (.A(p_sqr), .B(yK_sqr), .O(pyK_sqr)); //pyK_sqr : 4N+2
	MULT_ #(.N(2*N+2), .M(2*N)) MUL10 (.A(p_sqr), .B(xK_sqr), .O(pxK_sqr)); //pxK_sqr : 4N+2
	MULT_ #(.N(2*N+2), .M(2*N+2)) MUL11 (.A(p_sqr), .B(rK_sqr), .O(prK_sqr)); // prK_sqr : 4N+4
	MULT_ #(.N(N), .M(2*N+2)) MUL12 (.A(yK), .B(p_sqr), .O(yK_p_sqr)); //yK_p_sqr : 3N+2
	MULT_ #(.N(N+1), .M(N)) MUL13 (.A(p), .B(xK), .O(pxK)); //pxK : 2N+1
	MULT_ #(.N(2*N+1), .M(N+1)) MUL14 (.A(pxK), .B(q), .O(pqxK)); //pqxK : 3N+2

	SUB_ #(.N(2*N+2), .M(2*N+2)) SUB3 (.A(rK_sqr), .B(rL_sqr), .O(rK_min_rL_sqr)); //rK_min_rL_sqr : 2N+3
	SUB_ #(.N(2*N), .M(2*N)) SUB4 (.A(xL_sqr), .B(xK_sqr), .O(xL_min_xK_sqr)); //xL_min_xK_sqr : 2N+1
	SUB_ #(.N(2*N), .M(2*N)) SUB5 (.A(yL_sqr), .B(yK_sqr), .O(yL_min_yK_sqr)); //yL_min_yK_sqr : 2N+1
	ADD_ #(.N(2*N+1), .M(2*N+1)) ADD1 (.A(xL_min_xK_sqr), .B(yL_min_yK_sqr), .O(xL_min_xK_plus_yL_min_yK_sqr)); // xL_min_xK_plus_yL_min_yK_sqr : 2N+2
	ADD_ #(.N(2*N+3), .M(2*N+2)) ADD2 (.A(rK_min_rL_sqr), .B(xL_min_xK_plus_yL_min_yK_sqr), .O(t)); //t : 2N+4
	MULT_ #(.N(2*N+4), .M(2*N+4)) MUL15 (.A(t), .B(t), .O(t_sqr)); //t_sqr : 4N+8
	MULT_ #(.N(2*N+1), .M(2*N+4)) MUL16 (.A(pxK), .B(t), .O(ptxK));	//ptxK : 4N+5
	MULT_ #(.N(N+1), .M(2*N+4)) MUL17 (.A(q), .B(t), .O(qt)); //qt : 3N+5

	ADD_ #(.N(4*N+2), .M(4*N+2)) ADD3 (.A(pyK_sqr), .B(pxK_sqr), .O(pyK_sqr_plus_pxK_sqr)); //pyK_sqr_plus_pxK_sqr : 4N+3
	ADD_ #(.N(4*N+5), .M(4*N+4)) ADD4 (.A(ptxK), .B(prK_sqr), .O(prK_sqr_plus_ptxK)); //prK_sqr_plus_ptxK : 4N+6 
	SUB_ #(.N(4*N+6), .M(4*N+6)) SUB6 (.A({3'b0,pyK_sqr_plus_pxK_sqr}), .B(prK_sqr_plus_ptxK), .O(pyK_sqr_plus_pxK_sqr_min_prK_sqr_plus_ptxK)); //pyK_sqr_plus_pxK_sqr_min_prK_sqr_plus_ptxK : 4N+7
	ADD_ #(.N(4*N+9), .M(4*N+8)) ADD5 (.A({pyK_sqr_plus_pxK_sqr_min_prK_sqr_plus_ptxK, 2'b0}), .B(t_sqr), .O(s)); //s : 4N+10
	ADD_ #(.N(2*N+2), .M(2*N+2)) ADD6 (.A(p_sqr), .B(q_sqr), .O(p_sqr_plus_q_sqr)); //p_sqr_plus_q_sqr : 2N+3
	MULT_ #(.N(4*N+10), .M(2*N+3)) MUL18 (.A(s), .B(p_sqr_plus_q_sqr), .O(s_times_p_sqr_plus_q_sqr)); //s_times_p_sqr_plus_q_sqr : 6N+13
	
	ADD_ #(.N(3*N+2), .M(3*N+2)) ADD7 (.A(yK_p_sqr ), .B(pqxK), .O(yK_p_sqr_plus_pqxK)); //yK_p_sqr_plus_pqxK : 3N+3
	SUB_ #(.N(3*N+5), .M(3*N+4)) SUB7 (.A(qt), .B({yK_p_sqr_plus_pqxK, 1'b0}), .O(u));	//u : 3N+6
	MULT_ #(.N(3*N+6), .M(3*N+6)) MUL19 (.A(u), .B(u), .O(u_sqr)); //u_sqr : 6N+12

	SUB_ #(.N(6*N+13), .M(6*N+13)) SUB8 (.A({1'b0,u_sqr}), .B(s_times_p_sqr_plus_q_sqr), .O(w_sqr)); //w_sqr : 6N+14
	
	square_root_comb #(.N(6*N+14), .M(3*N+6)) square_root_comb(
		.A(w_sqr),
		.O(w)
	); //w : 3N+7
		
	SUB_ #(.N(3*N+5), .M(3*N+4)) SUB9 (.A({{2{yK_p_sqr_plus_pqxK[3*N+2]}}, yK_p_sqr_plus_pqxK}), .B(qt[3*N+4:1]), .O(yK_p_sqr_plus_pqxK_min_qt_by_2));	//yK_p_sqr_plus_pqxK_min_qt_by_2 : 3N+6
	ADD_ #(.N(3*N+6), .M(3*N+6)) ADD8 (.A(yK_p_sqr_plus_pqxK_min_qt_by_2), .B(w[3*N+6:1]), .O(y1P_top)); //y1P_top : 3N+7
	SUB_ #(.N(3*N+6), .M(3*N+6)) SUB10 (.A(yK_p_sqr_plus_pqxK_min_qt_by_2), .B(w[3*N+6:1]), .O(y2P_top));	//y2P_top : 3N+7
	
	DIV_ #(.N(3*N+7), .M(2*N+3)) DIV1 (.A(y1P_top), .B(p_sqr_plus_q_sqr), .O(y1P_ext)); //y1P_ext : 3*N+7
	DIV_ #(.N(3*N+7), .M(2*N+3)) DIV2 (.A(y2P_top), .B(p_sqr_plus_q_sqr), .O(y2P_ext)); //y2P_ext : 3*N+7
	
	assign y1P = y1P_ext[N+1:0]; //y1P : N+2
	assign y2P = y2P_ext[N+1:0]; //y2P : N+2
	
	MULT_ #(.N(N+2), .M(N+1)) MUL20 (.A(y1P), .B(q), .O(y1Pq)); //y1Pq : 2N+3
	MULT_ #(.N(N+2), .M(N+1)) MUL21 (.A(y2P), .B(q), .O(y2Pq)); //y2Pq : 2N+3

	ADD_ #(.N(2*N+4), .M(2*N+4)) ADD9 (.A(t), .B({y1Pq, 1'b0}), .O(x1P_top)); //x1P_top : 2N+5
	ADD_ #(.N(2*N+4), .M(2*N+4)) ADD10 (.A(t), .B({y2Pq, 1'b0}), .O(x2P_top)); //x2P_top : 2N+5
		
	DIV_ #(.N(2*N+5), .M(N+2)) DIV3 (.A(x1P_top), .B({p, 1'b0}), .O(x1P_ext)); //x1P_ext : 2N+5
	DIV_ #(.N(2*N+5), .M(N+2)) DIV4 (.A(x2P_top), .B({p, 1'b0}), .O(x2P_ext)); //x2P_ext : 2N+5
	
	assign x1P =  x1P_ext[N+1:0]; //x1P : N+2
	assign x2P =  x2P_ext[N+1:0]; //x2P : N+2


endmodule
