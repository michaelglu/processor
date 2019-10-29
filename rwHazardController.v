module rwHazardController(inFD,inDX,inXM,inMW,xmOverwriteDXRS,xmOverwriteDXRT,mwOverwriteDXRS,mwOverwriteDXRT,overWriteXMRD,overWriteRegA,overWriteRegB/*,debug_mwWritesRD,debug_xmWritesRD,
debug_rtDXCompXM,debug_rtDXCompMW,debug_rsDXCompXM,debug_rsDXCompMW,debug_rdXMCompMW*/
);



input[31:0]inFD,inDX,inXM,inMW;
output xmOverwriteDXRS,xmOverwriteDXRT,mwOverwriteDXRS,mwOverwriteDXRT,overWriteXMRD,overWriteRegA,overWriteRegB;

//DEBUGS-------------------------
/*
output debug_mwWritesRD,debug_xmWritesRD;
output[4:0]debug_rtDXCompXM,debug_rtDXCompMW,debug_rsDXCompXM,debug_rsDXCompMW,debug_rdXMCompMW;
assign debug_rtDXCompXM=rtDXCompXM;
assign debug_rtDXCompMW=rtDXCompMW;
assign debug_rsDXCompXM=rsDXCompXM;
assign debug_rsDXCompMW=rsDXCompMW;
assign debug_rdXMCompMW=rdXMCompMW;


assign debug_mwWritesRD=mwWritesRD;
assign debug_xmWritesRD=xmWritesRD;
*/
//---------------------------------------
wire[4:0] rsFD,rtFD,rdXM,rdMW,rsDX,rsXM,rtDX,rtXM;
wire mwWritesRD,xmWritesRD,xmUsesRT,dxUsesRT,dxMatchRT_MW,dxMatchRT_XM,dxMatchRS_MW,dxMatchRS_XM,xmMatchRD,rsFDMatch,rtFDMatch;

assign rdXM=inXM[26:22];
assign rdMW=inMW[26:22];

assign rsDX=inDX[21:17];

assign rtDX=inDX[16:12];

assign rsFD=inFD[21:17];
assign rtFD=inFD[16:12];

wire mw_sw,mw_j,mw_bne,mw_jal,mw_jr,mw_blt,mw_bex,mw_setx;
assign mw_sw=(~inMW[31]&~inMW[30]&inMW[29]&inMW[28]&inMW[27]);
assign mw_j=(~inMW[31]&~inMW[30]&~inMW[29]&~inMW[28]&inMW[27]);
assign mw_bne=(~inMW[31]&~inMW[30]&~inMW[29]&inMW[28]&~inMW[27]);
assign mw_jal=(~inMW[31]&~inMW[30]&~inMW[29]&inMW[28]&inMW[27]);
assign mw_jr=(~inMW[31]&~inMW[30]&inMW[29]&~inMW[28]&~inMW[27]);
assign mw_blt=(~inMW[31]&~inMW[30]&inMW[29]&inMW[28]&~inMW[27]);
assign mw_bex=(inMW[31]&~inMW[30]&inMW[29]&inMW[28]&~inMW[27]);
assign mw_setx=(inMW[31]&~inMW[30]&inMW[29]&inMW[28]&inMW[27]);

assign mwWritesRD= ~(mw_sw|mw_j|mw_bne|mw_jal|mw_jr|mw_blt|mw_bex|mw_setx);

wire xm_sw,xm_j,xm_bne,xm_jal,xm_jr,xm_blt,xm_bex,xm_setx;
assign xm_sw=(~inXM[31]&~inXM[30]&inXM[29]&inXM[28]&inXM[27]);
assign xm_j=(~inXM[31]&~inXM[30]&~inXM[29]&~inXM[28]&inXM[27]);
assign xm_bne=(~inXM[31]&~inXM[30]&~inXM[29]&inXM[28]&~inXM[27]);
assign xm_jal=(~inXM[31]&~inXM[30]&~inXM[29]&inXM[28]&inXM[27]);
assign xm_jr=(~inXM[31]&~inXM[30]&inXM[29]&~inXM[28]&~inXM[27]);
assign xm_blt=(~inXM[31]&~inXM[30]&inXM[29]&inXM[28]&~inXM[27]);
assign xm_bex=(inXM[31]&~inXM[30]&inXM[29]&inXM[28]&~inXM[27]);
assign xm_setx=(inXM[31]&~inXM[30]&inXM[29]&inXM[28]&inXM[27]);

assign xmWritesRD= ~(xm_sw|xm_j|xm_bne|xm_jal|xm_jr|xm_blt|xm_bex|xm_setx);

wire dx_sll,dx_srr, usesRT;
assign dx_sll= (~inDX[31]&~inDX[30]&~inDX[29]&~inDX[28]&~inDX[27])&(~inDX[6]&~inDX[5]&inDX[4]&~inDX[3]&~inDX[2]);
assign dx_srr= (~inDX[31]&~inDX[30]&~inDX[29]&~inDX[28]&~inDX[27])&(~inDX[6]&~inDX[5]&inDX[4]&~inDX[3]&inDX[2]);
assign usesRT=(~inDX[31]&~inDX[30]&~inDX[29]&~inDX[28]&~inDX[27])&~dx_sll&~dx_srr;

wire [4:0]rtDXCompXM,rtDXCompMW,rsDXCompXM,rsDXCompMW,rdXMCompMW,rsFDComp,rtFDComp;
xnor(rtDXCompXM[0],rdXM[0],rtDX[0]);
xnor(rtDXCompXM[1],rdXM[1],rtDX[1]);
xnor(rtDXCompXM[2],rdXM[2],rtDX[2]);
xnor(rtDXCompXM[3],rdXM[3],rtDX[3]);
xnor(rtDXCompXM[4],rdXM[4],rtDX[4]);

xnor(rtDXCompMW[0],rdMW[0],rtDX[0]);
xnor(rtDXCompMW[1],rdMW[1],rtDX[1]);
xnor(rtDXCompMW[2],rdMW[2],rtDX[2]);
xnor(rtDXCompMW[3],rdMW[3],rtDX[3]);
xnor(rtDXCompMW[4],rdMW[4],rtDX[4]);

xnor(rsDXCompXM[0],rdXM[0],rsDX[0]);
xnor(rsDXCompXM[1],rdXM[1],rsDX[1]);
xnor(rsDXCompXM[2],rdXM[2],rsDX[2]);
xnor(rsDXCompXM[3],rdXM[3],rsDX[3]);
xnor(rsDXCompXM[4],rdXM[4],rsDX[4]);

xnor(rsDXCompMW[0],rdMW[0],rsDX[0]);
xnor(rsDXCompMW[1],rdMW[1],rsDX[1]);
xnor(rsDXCompMW[2],rdMW[2],rsDX[2]);
xnor(rsDXCompMW[3],rdMW[3],rsDX[3]);
xnor(rsDXCompMW[4],rdMW[4],rsDX[4]);

xnor(rdXMCompMW[0],rdXM[0],rdXM[0]);
xnor(rdXMCompMW[1],rdXM[1],rdXM[1]);
xnor(rdXMCompMW[2],rdXM[2],rdXM[2]);
xnor(rdXMCompMW[3],rdXM[3],rdXM[3]);
xnor(rdXMCompMW[4],rdXM[4],rdXM[4]);

xnor(rsFDComp[0],rsFD[0],rdMW[0]);
xnor(rsFDComp[1],rsFD[1],rdMW[1]);
xnor(rsFDComp[2],rsFD[2],rdMW[2]);
xnor(rsFDComp[3],rsFD[3],rdMW[3]);
xnor(rsFDComp[4],rsFD[4],rdMW[4]);

xnor(rtFDComp[0],rtFD[0],rdMW[0]);
xnor(rtFDComp[1],rtFD[1],rdMW[1]);
xnor(rtFDComp[2],rtFD[2],rdMW[2]);
xnor(rtFDComp[3],rtFD[3],rdMW[3]);
xnor(rtFDComp[4],rtFD[4],rdMW[4]);


and(dxMatchRT_XM,rtDXCompXM[0],rtDXCompXM[1],rtDXCompXM[2],rtDXCompXM[3],rtDXCompXM[4]);
and(dxMatchRT_MW,rtDXCompMW[0],rtDXCompMW[1],rtDXCompMW[2],rtDXCompMW[3],rtDXCompMW[4]);
and(dxMatchRS_XM,rsDXCompXM[0],rsDXCompXM[1],rsDXCompXM[2],rsDXCompXM[3],rsDXCompXM[4]);
and(dxMatchRS_MW,rsDXCompMW[0],rsDXCompMW[1],rsDXCompMW[2],rsDXCompMW[3],rsDXCompMW[4]);
and(xmMatchRD,rdXMCompMW[0],rdXMCompMW[1],rdXMCompMW[2],rdXMCompMW[3],rdXMCompMW[4]);

and(rsFDMatch,rsFDComp[0],rsFDComp[1],rsFDComp[2],rsFDComp[3],rsFDComp[4]);
and(rtFDMatch,rtFDComp[0],rtFDComp[1],rtFDComp[2],rtFDComp[3],rtFDComp[4]);

wire isSW;
assign isSW=(~inXM[31]&~inXM[30]&inXM[29]&inXM[28]&inXM[27]);

assign overWriteXMRD= isSW & xmMatchRD & mwWritesRD;
assign xmOverwriteDXRS = xmWritesRD & dxMatchRS_XM;
assign xmOverwriteDXRT = xmWritesRD & dxMatchRT_XM & usesRT;
assign mwOverwriteDXRS = mwWritesRD & dxMatchRS_MW;
assign mwOverwriteDXRT = mwWritesRD & dxMatchRT_MW & usesRT;

assign overWriteRegA = mwWritesRD & rsFDMatch;
assign overWriteRegB = mwWritesRD & rtFDMatch;

endmodule

