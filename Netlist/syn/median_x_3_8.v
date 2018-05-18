/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP2
// Date      : Fri May 18 16:40:42 2018
/////////////////////////////////////////////////////////////


module median_x_3 ( xD, yD, xE, yE, xF, yF, xM, yM );
  input [9:0] xD;
  input [9:0] yD;
  input [9:0] xE;
  input [9:0] yE;
  input [9:0] xF;
  input [9:0] yF;
  output [11:0] xM;
  output [11:0] yM;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158, n159, n160, n161, n162, n163, n164, n165, n166,
         n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, n177,
         n178, n179, n180, n181, n182, n183, n184, n185, n186, n187, n188;

  XOR U1 ( .A(yF[9]), .B(n1), .Z(yM[9]) );
  XOR U2 ( .A(yF[8]), .B(n2), .Z(yM[8]) );
  XOR U3 ( .A(yF[7]), .B(n3), .Z(yM[7]) );
  XOR U4 ( .A(yF[6]), .B(n4), .Z(yM[6]) );
  XOR U5 ( .A(yF[5]), .B(n5), .Z(yM[5]) );
  XOR U6 ( .A(yF[4]), .B(n6), .Z(yM[4]) );
  XOR U7 ( .A(yF[3]), .B(n7), .Z(yM[3]) );
  XOR U8 ( .A(yF[2]), .B(n8), .Z(yM[2]) );
  XNOR U9 ( .A(yF[1]), .B(n9), .Z(yM[1]) );
  XOR U10 ( .A(n10), .B(n11), .Z(yM[11]) );
  XNOR U11 ( .A(n12), .B(n13), .Z(n11) );
  XOR U12 ( .A(yF[9]), .B(n14), .Z(n10) );
  AND U13 ( .A(n15), .B(n16), .Z(n14) );
  XNOR U14 ( .A(yF[9]), .B(n17), .Z(n16) );
  XOR U15 ( .A(yF[9]), .B(n15), .Z(yM[10]) );
  XOR U16 ( .A(n17), .B(n12), .Z(n15) );
  XOR U17 ( .A(n18), .B(n19), .Z(n12) );
  XOR U18 ( .A(yE[9]), .B(yD[9]), .Z(n19) );
  XNOR U19 ( .A(n20), .B(n21), .Z(n18) );
  AND U20 ( .A(n22), .B(n23), .Z(n21) );
  XNOR U21 ( .A(yE[9]), .B(n24), .Z(n22) );
  IV U22 ( .A(n20), .Z(n24) );
  IV U23 ( .A(n13), .Z(n17) );
  XNOR U24 ( .A(n25), .B(n26), .Z(n13) );
  AND U25 ( .A(n27), .B(n1), .Z(n26) );
  XOR U26 ( .A(n28), .B(n25), .Z(n1) );
  XNOR U27 ( .A(n23), .B(yE[9]), .Z(n28) );
  XOR U28 ( .A(n20), .B(yD[9]), .Z(n23) );
  XNOR U29 ( .A(n29), .B(n30), .Z(n20) );
  NOR U30 ( .A(n31), .B(n32), .Z(n30) );
  XOR U31 ( .A(yE[8]), .B(n29), .Z(n31) );
  XNOR U32 ( .A(yF[9]), .B(n25), .Z(n27) );
  XOR U33 ( .A(n33), .B(n34), .Z(n25) );
  AND U34 ( .A(n2), .B(n35), .Z(n34) );
  XNOR U35 ( .A(yF[8]), .B(n33), .Z(n35) );
  XOR U36 ( .A(n36), .B(n33), .Z(n2) );
  XOR U37 ( .A(n32), .B(yE[8]), .Z(n36) );
  XOR U38 ( .A(n29), .B(yD[8]), .Z(n32) );
  XOR U39 ( .A(n37), .B(n38), .Z(n29) );
  NOR U40 ( .A(n39), .B(n40), .Z(n38) );
  XOR U41 ( .A(yE[7]), .B(n37), .Z(n39) );
  XOR U42 ( .A(n41), .B(n42), .Z(n33) );
  AND U43 ( .A(n3), .B(n43), .Z(n42) );
  XNOR U44 ( .A(yF[7]), .B(n41), .Z(n43) );
  XOR U45 ( .A(n44), .B(n41), .Z(n3) );
  XOR U46 ( .A(n40), .B(yE[7]), .Z(n44) );
  XOR U47 ( .A(n37), .B(yD[7]), .Z(n40) );
  XOR U48 ( .A(n45), .B(n46), .Z(n37) );
  NOR U49 ( .A(n47), .B(n48), .Z(n46) );
  XOR U50 ( .A(yE[6]), .B(n45), .Z(n47) );
  XOR U51 ( .A(n49), .B(n50), .Z(n41) );
  AND U52 ( .A(n4), .B(n51), .Z(n50) );
  XNOR U53 ( .A(yF[6]), .B(n49), .Z(n51) );
  XOR U54 ( .A(n52), .B(n49), .Z(n4) );
  XOR U55 ( .A(n48), .B(yE[6]), .Z(n52) );
  XOR U56 ( .A(n45), .B(yD[6]), .Z(n48) );
  XOR U57 ( .A(n53), .B(n54), .Z(n45) );
  NOR U58 ( .A(n55), .B(n56), .Z(n54) );
  XOR U59 ( .A(yE[5]), .B(n53), .Z(n55) );
  XOR U60 ( .A(n57), .B(n58), .Z(n49) );
  AND U61 ( .A(n5), .B(n59), .Z(n58) );
  XNOR U62 ( .A(yF[5]), .B(n57), .Z(n59) );
  XOR U63 ( .A(n60), .B(n57), .Z(n5) );
  XOR U64 ( .A(n56), .B(yE[5]), .Z(n60) );
  XOR U65 ( .A(n53), .B(yD[5]), .Z(n56) );
  XOR U66 ( .A(n61), .B(n62), .Z(n53) );
  NOR U67 ( .A(n63), .B(n64), .Z(n62) );
  XOR U68 ( .A(yE[4]), .B(n61), .Z(n63) );
  XOR U69 ( .A(n65), .B(n66), .Z(n57) );
  AND U70 ( .A(n6), .B(n67), .Z(n66) );
  XNOR U71 ( .A(yF[4]), .B(n65), .Z(n67) );
  XOR U72 ( .A(n68), .B(n65), .Z(n6) );
  XOR U73 ( .A(n64), .B(yE[4]), .Z(n68) );
  XOR U74 ( .A(n61), .B(yD[4]), .Z(n64) );
  XOR U75 ( .A(n69), .B(n70), .Z(n61) );
  NOR U76 ( .A(n71), .B(n72), .Z(n70) );
  XOR U77 ( .A(yE[3]), .B(n69), .Z(n71) );
  XOR U78 ( .A(n73), .B(n74), .Z(n65) );
  AND U79 ( .A(n7), .B(n75), .Z(n74) );
  XNOR U80 ( .A(yF[3]), .B(n73), .Z(n75) );
  XOR U81 ( .A(n76), .B(n73), .Z(n7) );
  XOR U82 ( .A(n72), .B(yE[3]), .Z(n76) );
  XOR U83 ( .A(n69), .B(yD[3]), .Z(n72) );
  XOR U84 ( .A(n77), .B(n78), .Z(n69) );
  NOR U85 ( .A(n79), .B(n80), .Z(n78) );
  XOR U86 ( .A(yE[2]), .B(n77), .Z(n79) );
  XOR U87 ( .A(n81), .B(n82), .Z(n73) );
  AND U88 ( .A(n8), .B(n83), .Z(n82) );
  XNOR U89 ( .A(yF[2]), .B(n81), .Z(n83) );
  XOR U90 ( .A(n84), .B(n81), .Z(n8) );
  XOR U91 ( .A(n80), .B(yE[2]), .Z(n84) );
  XOR U92 ( .A(n77), .B(yD[2]), .Z(n80) );
  XNOR U93 ( .A(n85), .B(n86), .Z(n77) );
  NOR U94 ( .A(n87), .B(n88), .Z(n86) );
  XNOR U95 ( .A(yE[1]), .B(n85), .Z(n87) );
  XNOR U96 ( .A(n89), .B(n90), .Z(n81) );
  NOR U97 ( .A(n9), .B(n91), .Z(n90) );
  XNOR U98 ( .A(yF[1]), .B(n89), .Z(n91) );
  XNOR U99 ( .A(n92), .B(n88), .Z(n9) );
  XOR U100 ( .A(n93), .B(yD[1]), .Z(n88) );
  IV U101 ( .A(n85), .Z(n93) );
  AND U102 ( .A(yE[0]), .B(yD[0]), .Z(n85) );
  XNOR U103 ( .A(yE[1]), .B(n89), .Z(n92) );
  AND U104 ( .A(yF[0]), .B(n94), .Z(n89) );
  XOR U105 ( .A(yF[0]), .B(n94), .Z(yM[0]) );
  XOR U106 ( .A(yD[0]), .B(yE[0]), .Z(n94) );
  XOR U107 ( .A(xF[9]), .B(n95), .Z(xM[9]) );
  XOR U108 ( .A(xF[8]), .B(n96), .Z(xM[8]) );
  XOR U109 ( .A(xF[7]), .B(n97), .Z(xM[7]) );
  XOR U110 ( .A(xF[6]), .B(n98), .Z(xM[6]) );
  XOR U111 ( .A(xF[5]), .B(n99), .Z(xM[5]) );
  XOR U112 ( .A(xF[4]), .B(n100), .Z(xM[4]) );
  XOR U113 ( .A(xF[3]), .B(n101), .Z(xM[3]) );
  XOR U114 ( .A(xF[2]), .B(n102), .Z(xM[2]) );
  XNOR U115 ( .A(xF[1]), .B(n103), .Z(xM[1]) );
  XOR U116 ( .A(n104), .B(n105), .Z(xM[11]) );
  XNOR U117 ( .A(n106), .B(n107), .Z(n105) );
  XOR U118 ( .A(xF[9]), .B(n108), .Z(n104) );
  AND U119 ( .A(n109), .B(n110), .Z(n108) );
  XNOR U120 ( .A(xF[9]), .B(n111), .Z(n110) );
  XOR U121 ( .A(xF[9]), .B(n109), .Z(xM[10]) );
  XOR U122 ( .A(n111), .B(n106), .Z(n109) );
  XOR U123 ( .A(n112), .B(n113), .Z(n106) );
  XOR U124 ( .A(xE[9]), .B(xD[9]), .Z(n113) );
  XNOR U125 ( .A(n114), .B(n115), .Z(n112) );
  AND U126 ( .A(n116), .B(n117), .Z(n115) );
  XNOR U127 ( .A(xE[9]), .B(n118), .Z(n116) );
  IV U128 ( .A(n114), .Z(n118) );
  IV U129 ( .A(n107), .Z(n111) );
  XNOR U130 ( .A(n119), .B(n120), .Z(n107) );
  AND U131 ( .A(n121), .B(n95), .Z(n120) );
  XOR U132 ( .A(n122), .B(n119), .Z(n95) );
  XNOR U133 ( .A(n117), .B(xE[9]), .Z(n122) );
  XOR U134 ( .A(n114), .B(xD[9]), .Z(n117) );
  XNOR U135 ( .A(n123), .B(n124), .Z(n114) );
  NOR U136 ( .A(n125), .B(n126), .Z(n124) );
  XOR U137 ( .A(xE[8]), .B(n123), .Z(n125) );
  XNOR U138 ( .A(xF[9]), .B(n119), .Z(n121) );
  XOR U139 ( .A(n127), .B(n128), .Z(n119) );
  AND U140 ( .A(n96), .B(n129), .Z(n128) );
  XNOR U141 ( .A(xF[8]), .B(n127), .Z(n129) );
  XOR U142 ( .A(n130), .B(n127), .Z(n96) );
  XOR U143 ( .A(n126), .B(xE[8]), .Z(n130) );
  XOR U144 ( .A(n123), .B(xD[8]), .Z(n126) );
  XOR U145 ( .A(n131), .B(n132), .Z(n123) );
  NOR U146 ( .A(n133), .B(n134), .Z(n132) );
  XOR U147 ( .A(xE[7]), .B(n131), .Z(n133) );
  XOR U148 ( .A(n135), .B(n136), .Z(n127) );
  AND U149 ( .A(n97), .B(n137), .Z(n136) );
  XNOR U150 ( .A(xF[7]), .B(n135), .Z(n137) );
  XOR U151 ( .A(n138), .B(n135), .Z(n97) );
  XOR U152 ( .A(n134), .B(xE[7]), .Z(n138) );
  XOR U153 ( .A(n131), .B(xD[7]), .Z(n134) );
  XOR U154 ( .A(n139), .B(n140), .Z(n131) );
  NOR U155 ( .A(n141), .B(n142), .Z(n140) );
  XOR U156 ( .A(xE[6]), .B(n139), .Z(n141) );
  XOR U157 ( .A(n143), .B(n144), .Z(n135) );
  AND U158 ( .A(n98), .B(n145), .Z(n144) );
  XNOR U159 ( .A(xF[6]), .B(n143), .Z(n145) );
  XOR U160 ( .A(n146), .B(n143), .Z(n98) );
  XOR U161 ( .A(n142), .B(xE[6]), .Z(n146) );
  XOR U162 ( .A(n139), .B(xD[6]), .Z(n142) );
  XOR U163 ( .A(n147), .B(n148), .Z(n139) );
  NOR U164 ( .A(n149), .B(n150), .Z(n148) );
  XOR U165 ( .A(xE[5]), .B(n147), .Z(n149) );
  XOR U166 ( .A(n151), .B(n152), .Z(n143) );
  AND U167 ( .A(n99), .B(n153), .Z(n152) );
  XNOR U168 ( .A(xF[5]), .B(n151), .Z(n153) );
  XOR U169 ( .A(n154), .B(n151), .Z(n99) );
  XOR U170 ( .A(n150), .B(xE[5]), .Z(n154) );
  XOR U171 ( .A(n147), .B(xD[5]), .Z(n150) );
  XOR U172 ( .A(n155), .B(n156), .Z(n147) );
  NOR U173 ( .A(n157), .B(n158), .Z(n156) );
  XOR U174 ( .A(xE[4]), .B(n155), .Z(n157) );
  XOR U175 ( .A(n159), .B(n160), .Z(n151) );
  AND U176 ( .A(n100), .B(n161), .Z(n160) );
  XNOR U177 ( .A(xF[4]), .B(n159), .Z(n161) );
  XOR U178 ( .A(n162), .B(n159), .Z(n100) );
  XOR U179 ( .A(n158), .B(xE[4]), .Z(n162) );
  XOR U180 ( .A(n155), .B(xD[4]), .Z(n158) );
  XOR U181 ( .A(n163), .B(n164), .Z(n155) );
  NOR U182 ( .A(n165), .B(n166), .Z(n164) );
  XOR U183 ( .A(xE[3]), .B(n163), .Z(n165) );
  XOR U184 ( .A(n167), .B(n168), .Z(n159) );
  AND U185 ( .A(n101), .B(n169), .Z(n168) );
  XNOR U186 ( .A(xF[3]), .B(n167), .Z(n169) );
  XOR U187 ( .A(n170), .B(n167), .Z(n101) );
  XOR U188 ( .A(n166), .B(xE[3]), .Z(n170) );
  XOR U189 ( .A(n163), .B(xD[3]), .Z(n166) );
  XOR U190 ( .A(n171), .B(n172), .Z(n163) );
  NOR U191 ( .A(n173), .B(n174), .Z(n172) );
  XOR U192 ( .A(xE[2]), .B(n171), .Z(n173) );
  XOR U193 ( .A(n175), .B(n176), .Z(n167) );
  AND U194 ( .A(n102), .B(n177), .Z(n176) );
  XNOR U195 ( .A(xF[2]), .B(n175), .Z(n177) );
  XOR U196 ( .A(n178), .B(n175), .Z(n102) );
  XOR U197 ( .A(n174), .B(xE[2]), .Z(n178) );
  XOR U198 ( .A(n171), .B(xD[2]), .Z(n174) );
  XNOR U199 ( .A(n179), .B(n180), .Z(n171) );
  NOR U200 ( .A(n181), .B(n182), .Z(n180) );
  XNOR U201 ( .A(xE[1]), .B(n179), .Z(n181) );
  XNOR U202 ( .A(n183), .B(n184), .Z(n175) );
  NOR U203 ( .A(n103), .B(n185), .Z(n184) );
  XNOR U204 ( .A(xF[1]), .B(n183), .Z(n185) );
  XNOR U205 ( .A(n186), .B(n182), .Z(n103) );
  XOR U206 ( .A(n187), .B(xD[1]), .Z(n182) );
  IV U207 ( .A(n179), .Z(n187) );
  AND U208 ( .A(xE[0]), .B(xD[0]), .Z(n179) );
  XNOR U209 ( .A(xE[1]), .B(n183), .Z(n186) );
  AND U210 ( .A(xF[0]), .B(n188), .Z(n183) );
  XOR U211 ( .A(xF[0]), .B(n188), .Z(xM[0]) );
  XOR U212 ( .A(xD[0]), .B(xE[0]), .Z(n188) );
endmodule

