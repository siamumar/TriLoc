/////////////////////////////////////////////////////////////
// Created by: Synopsys Design Compiler(R)
// Version   : K-2015.06-SP2
// Date      : Fri May 18 14:27:31 2018
/////////////////////////////////////////////////////////////


module MUX_N1_0 ( A, B, S, O );
  input [0:0] A;
  input [0:0] B;
  output [0:0] O;
  input S;
  wire   n1, n2;

  XOR U1 ( .A(A[0]), .B(n1), .Z(O[0]) );
  AND U2 ( .A(S), .B(n2), .Z(n1) );
  XOR U3 ( .A(B[0]), .B(A[0]), .Z(n2) );
endmodule


module FA_0 ( A, B, CI, S, CO );
  input A, B, CI;
  output S, CO;
  wire   n1, n2, n3, n4;

  IV U1 ( .A(CI), .Z(n1) );
  XOR U2 ( .A(B), .B(n2), .Z(S) );
  XOR U3 ( .A(CI), .B(n3), .Z(CO) );
  AND U4 ( .A(n2), .B(n4), .Z(n3) );
  XNOR U5 ( .A(n1), .B(B), .Z(n4) );
  XOR U6 ( .A(CI), .B(A), .Z(n2) );
endmodule


module ADD_N10_0 ( A, B, CI, CO, S );
  input [9:0] A;
  input [9:0] B;
  output [9:0] S;
  input CI;
  output CO;

  wire   [9:1] C;

  FA_0 \FA_IF2.FAINST[0].FA_  ( .A(A[0]), .B(B[0]), .CI(CI), .S(S[0]), .CO(
        C[1]) );
  FA_0 \FA_IF2.FAINST[1].FA_  ( .A(A[1]), .B(B[1]), .CI(C[1]), .S(S[1]), .CO(
        C[2]) );
  FA_0 \FA_IF2.FAINST[2].FA_  ( .A(A[2]), .B(B[2]), .CI(C[2]), .S(S[2]), .CO(
        C[3]) );
  FA_0 \FA_IF2.FAINST[3].FA_  ( .A(A[3]), .B(B[3]), .CI(C[3]), .S(S[3]), .CO(
        C[4]) );
  FA_0 \FA_IF2.FAINST[4].FA_  ( .A(A[4]), .B(B[4]), .CI(C[4]), .S(S[4]), .CO(
        C[5]) );
  FA_0 \FA_IF2.FAINST[5].FA_  ( .A(A[5]), .B(B[5]), .CI(C[5]), .S(S[5]), .CO(
        C[6]) );
  FA_0 \FA_IF2.FAINST[6].FA_  ( .A(A[6]), .B(B[6]), .CI(C[6]), .S(S[6]), .CO(
        C[7]) );
  FA_0 \FA_IF2.FAINST[7].FA_  ( .A(A[7]), .B(B[7]), .CI(C[7]), .S(S[7]), .CO(
        C[8]) );
  FA_0 \FA_IF2.FAINST[8].FA_  ( .A(A[8]), .B(B[8]), .CI(C[8]), .S(S[8]), .CO(
        C[9]) );
  FA_0 \FA_IF2.FAINST[9].FA_  ( .A(A[9]), .B(B[9]), .CI(C[9]), .S(S[9]), .CO(
        CO) );
endmodule


module ADD__N10_M10_0 ( A, B, O );
  input [9:0] A;
  input [9:0] B;
  output [10:0] O;
  wire   CO, _0_net_;

  MUX_N1_0 MUX ( .A(CO), .B(O[9]), .S(_0_net_), .O(O[10]) );
  ADD_N10_0 ADD ( .A(A), .B(B), .CI(1'b0), .CO(CO), .S(O[9:0]) );
  XOR U2 ( .A(B[9]), .B(A[9]), .Z(_0_net_) );
endmodule


module ADD_N11_0 ( A, B, CI, CO, S );
  input [10:0] A;
  input [10:0] B;
  output [10:0] S;
  input CI;
  output CO;

  wire   [10:1] C;

  FA_0 \FA_IF2.FAINST[0].FA_  ( .A(A[0]), .B(B[0]), .CI(CI), .S(S[0]), .CO(
        C[1]) );
  FA_0 \FA_IF2.FAINST[1].FA_  ( .A(A[1]), .B(B[1]), .CI(C[1]), .S(S[1]), .CO(
        C[2]) );
  FA_0 \FA_IF2.FAINST[2].FA_  ( .A(A[2]), .B(B[2]), .CI(C[2]), .S(S[2]), .CO(
        C[3]) );
  FA_0 \FA_IF2.FAINST[3].FA_  ( .A(A[3]), .B(B[3]), .CI(C[3]), .S(S[3]), .CO(
        C[4]) );
  FA_0 \FA_IF2.FAINST[4].FA_  ( .A(A[4]), .B(B[4]), .CI(C[4]), .S(S[4]), .CO(
        C[5]) );
  FA_0 \FA_IF2.FAINST[5].FA_  ( .A(A[5]), .B(B[5]), .CI(C[5]), .S(S[5]), .CO(
        C[6]) );
  FA_0 \FA_IF2.FAINST[6].FA_  ( .A(A[6]), .B(B[6]), .CI(C[6]), .S(S[6]), .CO(
        C[7]) );
  FA_0 \FA_IF2.FAINST[7].FA_  ( .A(A[7]), .B(B[7]), .CI(C[7]), .S(S[7]), .CO(
        C[8]) );
  FA_0 \FA_IF2.FAINST[8].FA_  ( .A(A[8]), .B(B[8]), .CI(C[8]), .S(S[8]), .CO(
        C[9]) );
  FA_0 \FA_IF2.FAINST[9].FA_  ( .A(A[9]), .B(B[9]), .CI(C[9]), .S(S[9]), .CO(
        C[10]) );
  FA_0 \FA_IF2.FAINST[10].FA_  ( .A(A[10]), .B(B[10]), .CI(C[10]), .S(S[10]), 
        .CO(CO) );
endmodule


module ADD__N11_M10_0 ( A, B, O );
  input [10:0] A;
  input [9:0] B;
  output [11:0] O;
  wire   CO, _0_net_;

  MUX_N1_0 MUX ( .A(CO), .B(O[10]), .S(_0_net_), .O(O[11]) );
  ADD_N11_0 ADD ( .A(A), .B({B[9], B}), .CI(1'b0), .CO(CO), .S(O[10:0]) );
  XOR U2 ( .A(B[9]), .B(A[10]), .Z(_0_net_) );
endmodule


module median_x_3 ( xD, yD, xE, yE, xF, yF, xM, yM );
  input [9:0] xD;
  input [9:0] yD;
  input [9:0] xE;
  input [9:0] yE;
  input [9:0] xF;
  input [9:0] yF;
  output [11:0] xM;
  output [11:0] yM;

  wire   [10:0] xM_1;
  wire   [10:0] yM_1;

  ADD__N10_M10_0 ADD_x1 ( .A(xD), .B(xE), .O(xM_1) );
  ADD__N10_M10_0 ADD_y1 ( .A(yD), .B(yE), .O(yM_1) );
  ADD__N11_M10_0 ADD_x2 ( .A(xM_1), .B(xF), .O(xM) );
  ADD__N11_M10_0 ADD_y2 ( .A(yM_1), .B(yF), .O(yM) );
endmodule

