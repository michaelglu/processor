module rwCrossLaneHazardController(/*inDX_Y,inXM_Y, inXM,inMW,ovf_DX_Y,ovf_XM_Y,ovfXM,ovfMW,
XMoDX,MWoDX,MWoXM*/
);

//input [31:0] inDX_Y,inXM_Y, inXM,inMW;
//input ovf_DX_Y,ovf_XM_Y,ovf_XM,ovf_MW;
//output XMoDX,MWoDX,MWoXM;
//
//
//
//wire mwWritesRD;
//
//wire mw_sw,mw_j,mw_bne,mw_jal,mw_jr,mw_blt,mw_bex,mw_setx,mw_noop;
//
//assign mw_sw=(~inMW[31]&~inMW[30]&inMW[29]&inMW[28]&inMW[27]);
//assign mw_j=(~inMW[31]&~inMW[30]&~inMW[29]&~inMW[28]&inMW[27]);
//assign mw_bne=(~inMW[31]&~inMW[30]&~inMW[29]&inMW[28]&~inMW[27]);
//assign mw_jal=(~inMW[31]&~inMW[30]&~inMW[29]&inMW[28]&inMW[27]);
//assign mw_jr=(~inMW[31]&~inMW[30]&inMW[29]&~inMW[28]&~inMW[27]);
//assign mw_blt=(~inMW[31]&~inMW[30]&inMW[29]&inMW[28]&~inMW[27]);
//assign mw_bex=(inMW[31]&~inMW[30]&inMW[29]&inMW[28]&~inMW[27]);
//assign mw_setx=(inMW[31]&~inMW[30]&inMW[29]&inMW[28]&inMW[27]);
//assign mw_noop=(~inMW[31]&~inMW[30]&~inMW[29]&~inMW[28]&~inMW[27]&
//					 ~inMW[26]&~inMW[25]&~inMW[24]&~inMW[23]&~inMW[22]&
//					 ~inMW[21]&~inMW[20]&~inMW[19]&~inMW[18]&~inMW[17]&
//					 ~inMW[16]&~inMW[15]&~inMW[14]&~inMW[13]&~inMW[12]&
//					 ~inMW[11]&~inMW[10]&~inMW[9]&~inMW[8]&~inMW[7]&~
//					 inMW[6]&~inMW[5]&~inMW[4]&~inMW[3]&~inMW[2]&~inMW[1]&~inMW[0]);
//
//assign mwWritesRD= (~(mw_sw|mw_j|mw_bne|mw_jal|mw_jr|mw_blt|mw_bex|mw_noop)) & (inMW[26]|inMW[25]|inMW[24]|inMW[23]|inMW[22]);
//
//wire XMWritesRD;
//
//wire xm_sw,xm_j,xm_bne,xm_jal,xm_jr,xm_blt,xm_bex,xm_setx,xm_noop;
//assign xm_sw=(~inXM[31]&~inXM[30]&inXM[29]&inXM[28]&inXM[27]);
//assign xm_j=(~inXM[31]&~inXM[30]&~inXM[29]&~inXM[28]&inXM[27]);
//assign xm_bne=(~inXM[31]&~inXM[30]&~inXM[29]&inXM[28]&~inXM[27]);
//assign xm_jal=(~inXM[31]&~inXM[30]&~inXM[29]&inXM[28]&inXM[27]);
//assign xm_jr=(~inXM[31]&~inXM[30]&inXM[29]&~inXM[28]&~inXM[27]);
//assign xm_blt=(~inXM[31]&~inXM[30]&inXM[29]&inXM[28]&~inXM[27]);
//assign xm_bex=(inXM[31]&~inXM[30]&inXM[29]&inXM[28]&~inXM[27]);
//assign xm_setx=(inXM[31]&~inXM[30]&inXM[29]&inXM[28]&inXM[27]);
//assign xm_noop=(~inXM[31]&~inXM[30]&~inXM[29]&~inXM[28]&~inXM[27]&
//					 ~inXM[26]&~inXM[25]&~inXM[24]&~inXM[23]&~inXM[22]&
//					 ~inXM[21]&~inXM[20]&~inXM[19]&~inXM[18]&~inXM[17]&
//					 ~inXM[16]&~inXM[15]&~inXM[14]&~inXM[13]&~inXM[12]&
//					 ~inXM[11]&~inXM[10]&~inXM[9]&~inXM[8]&~inXM[7]&
//					 ~inXM[6]&~inXM[5]&~inXM[4]&~inXM[3]&~inXM[2]&~inXM[1]&~inXM[0]);
//
//assign xmWritesRD= (~(xm_sw|xm_j|xm_bne|xm_jal|xm_jr|xm_blt|xm_noop))&(inXM[26]|inXM[25]|inXM[24]|inXM[23]|inXM[22]);


endmodule