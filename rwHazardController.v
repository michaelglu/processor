module rwHazardController(inFD,inDX,inXM,inMW,xmOverwriteDXRS,xmOverwriteDXRT,mwOverwriteDXRS,mwOverwriteDXRT,overWriteXMRD,ovfXM,ovfMW/*,debug_mwWritesRD,debug_xmWritesRD,
debug_rtDXCompXM,debug_rtDXCompMW,debug_rsDXCompXM,debug_rsDXCompMW,debug_rdXMCompMW*/
);



input[31:0]inFD,inDX,inXM,inMW;
input ovfXM,ovfMW;
output xmOverwriteDXRS,xmOverwriteDXRT,mwOverwriteDXRS,mwOverwriteDXRT,overWriteXMRD;

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
wire[4:0] rsFD,rtFD,rdXM,rdMW,rsDX,rsXM,rtDX,rtXM,rdDX,rdXM_NoOVF,rdMW_NoOVF;
wire mwWritesRD,xmWritesRD,xmUsesRT,dxUsesRT,dxMatchRT_MW,dxMatchRT_XM,dxMatchRD_MW,dxMatchRD_XM,dxMatchRS_MW,dxMatchRS_XM,xmMatchRD,dxReadsRD;
wire isMWJal,isXMJal,isMWSetX,isXMSetX,isDXBEX;

assign isMWJal = ~inMW[31]&~inMW[30]&~inMW[29]&inMW[28]&inMW[27];
assign isXMJal = ~inXM[31]&~inXM[30]&~inXM[29]&inXM[28]&inXM[27];
assign isMWSetX = inMW[31]&~inMW[30]&inMW[29]&~inMW[28]&inMW[27];
assign isXMSetX = inXM[31]&~inXM[30]&inXM[29]&~inXM[28]&inXM[27];

wire [4:0]r30;
assign r30[4:1]={4{1'b1}};
assign r30[0]=1'b0;


assign rdXM_NoOVF= isXMJal ? {5{1'b1}} : inXM[26:22];
assign rdMW_NoOVF= isMWJal ? {5{1'b1}} : inMW[26:22];

assign rdXM=(ovfXM|isXMSetX) ? r30 : rdXM_NoOVF;
assign rdMW = (ovfMW|isMWSetX) ? r30:rdMW_NoOVF;


assign rsDX=inDX[21:17];
assign rdDX=inDX[26:22];
assign rtDX=dx_bex ?{5{1'b1}} :inDX[16:12];

assign rsFD=inFD[21:17];
assign rtFD=inFD[16:12];

wire dx_sw,dx_j,dx_bne,dx_jal,dx_jr,dx_blt,dx_bex,dx_setx;
assign dx_sw=(~inDX[31]&~inDX[30]&inDX[29]&inDX[28]&inDX[27]);
assign dx_j=(~inDX[31]&~inDX[30]&~inDX[29]&~inDX[28]&inDX[27]);
assign dx_bne=(~inDX[31]&~inDX[30]&~inDX[29]&inDX[28]&~inDX[27]);
assign dx_jal=(~inDX[31]&~inDX[30]&~inDX[29]&inDX[28]&inDX[27]);
assign dx_jr=(~inDX[31]&~inDX[30]&inDX[29]&~inDX[28]&~inDX[27]);
assign dx_blt=(~inDX[31]&~inDX[30]&inDX[29]&inDX[28]&~inDX[27]);
assign dx_bex=(inDX[31]&~inDX[30]&inDX[29]&inDX[28]&~inDX[27]);
assign dx_setx=(inDX[31]&~inDX[30]&inDX[29]&inDX[28]&inDX[27]);

assign dxReadsRD= (dx_sw|dx_bne|dx_jr|dx_blt);


wire mw_sw,mw_j,mw_bne,mw_jal,mw_jr,mw_blt,mw_bex,mw_setx,mw_noop;
assign mw_sw=(~inMW[31]&~inMW[30]&inMW[29]&inMW[28]&inMW[27]);
assign mw_j=(~inMW[31]&~inMW[30]&~inMW[29]&~inMW[28]&inMW[27]);
assign mw_bne=(~inMW[31]&~inMW[30]&~inMW[29]&inMW[28]&~inMW[27]);
assign mw_jal=(~inMW[31]&~inMW[30]&~inMW[29]&inMW[28]&inMW[27]);
assign mw_jr=(~inMW[31]&~inMW[30]&inMW[29]&~inMW[28]&~inMW[27]);
assign mw_blt=(~inMW[31]&~inMW[30]&inMW[29]&inMW[28]&~inMW[27]);
assign mw_bex=(inMW[31]&~inMW[30]&inMW[29]&inMW[28]&~inMW[27]);
assign mw_setx=(inMW[31]&~inMW[30]&inMW[29]&inMW[28]&inMW[27]);
assign mw_noop=(~inMW[31]&~inMW[30]&~inMW[29]&~inMW[28]&~inMW[27]&
					 ~inMW[26]&~inMW[25]&~inMW[24]&~inMW[23]&~inMW[22]&
					 ~inMW[21]&~inMW[20]&~inMW[19]&~inMW[18]&~inMW[17]&
					 ~inMW[16]&~inMW[15]&~inMW[14]&~inMW[13]&~inMW[12]&
					 ~inMW[11]&~inMW[10]&~inMW[9]&~inMW[8]&~inMW[7]&~
					 inMW[6]&~inMW[5]&~inMW[4]&~inMW[3]&~inMW[2]&~inMW[1]&~inMW[0]);

assign mwWritesRD= (~(mw_sw|mw_j|mw_bne|mw_jal|mw_jr|mw_blt|mw_bex|mw_noop)) & (inMW[26]|inMW[25]|inMW[24]|inMW[23]|inMW[22]);

wire xm_sw,xm_j,xm_bne,xm_jal,xm_jr,xm_blt,xm_bex,xm_setx,xm_noop;
assign xm_sw=(~inXM[31]&~inXM[30]&inXM[29]&inXM[28]&inXM[27]);
assign xm_j=(~inXM[31]&~inXM[30]&~inXM[29]&~inXM[28]&inXM[27]);
assign xm_bne=(~inXM[31]&~inXM[30]&~inXM[29]&inXM[28]&~inXM[27]);
assign xm_jal=(~inXM[31]&~inXM[30]&~inXM[29]&inXM[28]&inXM[27]);
assign xm_jr=(~inXM[31]&~inXM[30]&inXM[29]&~inXM[28]&~inXM[27]);
assign xm_blt=(~inXM[31]&~inXM[30]&inXM[29]&inXM[28]&~inXM[27]);
assign xm_bex=(inXM[31]&~inXM[30]&inXM[29]&inXM[28]&~inXM[27]);
assign xm_setx=(inXM[31]&~inXM[30]&inXM[29]&inXM[28]&inXM[27]);
assign xm_noop=(~inXM[31]&~inXM[30]&~inXM[29]&~inXM[28]&~inXM[27]&
					 ~inXM[26]&~inXM[25]&~inXM[24]&~inXM[23]&~inXM[22]&
					 ~inXM[21]&~inXM[20]&~inXM[19]&~inXM[18]&~inXM[17]&
					 ~inXM[16]&~inXM[15]&~inXM[14]&~inXM[13]&~inXM[12]&
					 ~inXM[11]&~inXM[10]&~inXM[9]&~inXM[8]&~inXM[7]&
					 ~inXM[6]&~inXM[5]&~inXM[4]&~inXM[3]&~inXM[2]&~inXM[1]&~inXM[0]);

assign xmWritesRD= (~(xm_sw|xm_j|xm_bne|xm_jal|xm_jr|xm_blt|xm_noop))&(inXM[26]|inXM[25]|inXM[24]|inXM[23]|inXM[22]);

wire dx_sll,dx_srr, usesRT;
assign dx_sll= (~inDX[31]&~inDX[30]&~inDX[29]&~inDX[28]&~inDX[27])&(~inDX[6]&~inDX[5]&inDX[4]&~inDX[3]&~inDX[2]);
assign dx_srr= (~inDX[31]&~inDX[30]&~inDX[29]&~inDX[28]&~inDX[27])&(~inDX[6]&~inDX[5]&inDX[4]&~inDX[3]&inDX[2]);
assign usesRT=dx_bex|(~inDX[31]&~inDX[30]&~inDX[29]&~inDX[28]&~inDX[27])&~dx_sll&~dx_srr;

wire [4:0]rtDXCompXM,rtDXCompMW,rsDXCompXM,rsDXCompMW,rdXMCompMW,rsFDComp,rtFDComp,rdDXCompXM,rdDXCompMW;


xnor(rdDXCompXM[0],rdXM[0],rdDX[0]);
xnor(rdDXCompXM[1],rdXM[1],rdDX[1]);
xnor(rdDXCompXM[2],rdXM[2],rdDX[2]);
xnor(rdDXCompXM[3],rdXM[3],rdDX[3]);
xnor(rdDXCompXM[4],rdXM[4],rdDX[4]);

xnor(rdDXCompMW[0],rdMW[0],rdDX[0]);
xnor(rdDXCompMW[1],rdMW[1],rdDX[1]);
xnor(rdDXCompMW[2],rdMW[2],rdDX[2]);
xnor(rdDXCompMW[3],rdMW[3],rdDX[3]);
xnor(rdDXCompMW[4],rdMW[4],rdDX[4]);


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


and(dxMatchRD_XM,rdDXCompXM[0],rdDXCompXM[1],rdDXCompXM[2],rdDXCompXM[3],rdDXCompXM[4]);
and(dxMatchRD_MW,rdDXCompMW[0],rdDXCompMW[1],rdDXCompMW[2],rdDXCompMW[3],rdDXCompMW[4]);

and(dxMatchRT_XM,rtDXCompXM[0],rtDXCompXM[1],rtDXCompXM[2],rtDXCompXM[3],rtDXCompXM[4]);
and(dxMatchRT_MW,rtDXCompMW[0],rtDXCompMW[1],rtDXCompMW[2],rtDXCompMW[3],rtDXCompMW[4]);
and(dxMatchRS_XM,rsDXCompXM[0],rsDXCompXM[1],rsDXCompXM[2],rsDXCompXM[3],rsDXCompXM[4]);
and(dxMatchRS_MW,rsDXCompMW[0],rsDXCompMW[1],rsDXCompMW[2],rsDXCompMW[3],rsDXCompMW[4]);
and(xmMatchRD,rdXMCompMW[0],rdXMCompMW[1],rdXMCompMW[2],rdXMCompMW[3],rdXMCompMW[4]);


wire isSW,isMWLW;
assign isLMWW=(~inMW[31]&inMW[30]&~inMW[29]&~inMW[28]&~inMW[27]);

assign isSW=(~inXM[31]&~inXM[30]&inXM[29]&inXM[28]&inXM[27]);

assign overWriteXMRD= isSW & xmMatchRD & mwWritesRD;
assign xmOverwriteDXRS = xmWritesRD & dxMatchRS_XM;
assign xmOverwriteDXRT = xmWritesRD & ((dxMatchRT_XM & usesRT)|(dxMatchRD_XM & dxReadsRD));
assign mwOverwriteDXRS = mwWritesRD & dxMatchRS_MW;
assign mwOverwriteDXRT = mwWritesRD & ((dxMatchRT_MW & usesRT)|(dxMatchRD_MW & dxReadsRD));


endmodule

