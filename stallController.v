module stallController(in1,in2,inM,stall,multOngoing);

input [31:0]in1, in2,inM;
input multOngoing;
output stall;

wire isLW,isMult1;
assign isLW=~in2[31]&in2[30]&~in2[29]&~in2[28]&~in2[27];
assign isMult1 = (~in1[31]&~in1[30]&~in1[29]&~in1[28]&~in1[27])&(~in1[6]&~in1[5]&in1[4]&in1[3]);



wire dx_sll,dx_srr,dx_sw,dx_bne,dx_jr,dx_blt, usesRT,usesRD,isJal;
assign dx_sll= (~in1[31]&~in1[30]&~in1[29]&~in1[28]&~in1[27])&(~in1[6]&~in1[5]&in1[4]&~in1[3]&~in1[2]);
assign dx_srr= (~in1[31]&~in1[30]&~in1[29]&~in1[28]&~in1[27])&(~in1[6]&~in1[5]&in1[4]&~in1[3]&in1[2]);
assign usesRT=(~in1[31]&~in1[30]&~in1[29]&~in1[28]&~in1[27])&~dx_sll&~dx_srr;

assign dx_sw=(~in1[31]&~in1[30]&in1[29]&in1[28]&in1[27]);
assign dx_bne=(~in1[31]&~in1[30]&~in1[29]&in1[28]&~in1[27]);
assign dx_blt=(~in1[31]&~in1[30]&in1[29]&in1[28]&~in1[27]);
assign dx_jr=(~in1[31]&~in1[30]&in1[29]&~in1[28]&~in1[27]);

assign isJal =(~in1[31]&~in1[30]&~in1[29]&in1[28]&in1[27]);

assign usesRD= (dx_sw|dx_bne|dx_jr|dx_blt);





wire in1_sw,in1_j,in1_bne,in1_jal,in1_jr,in1_blt,in1_bex,in1_setx,in1_noop;
assign in1_sw=(~in1[31]&~in1[30]&in1[29]&in1[28]&in1[27]);
assign in1_j=(~in1[31]&~in1[30]&~in1[29]&~in1[28]&in1[27]);
assign in1_bne=(~in1[31]&~in1[30]&~in1[29]&in1[28]&~in1[27]);
assign in1_jal=(~in1[31]&~in1[30]&~in1[29]&in1[28]&in1[27]);
assign in1_jr=(~in1[31]&~in1[30]&in1[29]&~in1[28]&~in1[27]);
assign in1_blt=(~in1[31]&~in1[30]&in1[29]&in1[28]&~in1[27]);
assign in1_bex=(in1[31]&~in1[30]&in1[29]&in1[28]&~in1[27]);
assign in1_setx=(in1[31]&~in1[30]&in1[29]&in1[28]&in1[27]);
assign in1_noop=(~in1[31]&~in1[30]&~in1[29]&~in1[28]&~in1[27]&
					 ~in1[26]&~in1[25]&~in1[24]&~in1[23]&~in1[22]&
					 ~in1[21]&~in1[20]&~in1[19]&~in1[18]&~in1[17]&
					 ~in1[16]&~in1[15]&~in1[14]&~in1[13]&~in1[12]&
					 ~in1[11]&~in1[10]&~in1[9]&~in1[8]&~in1[7]&~
					 in1[6]&~in1[5]&~in1[4]&~in1[3]&~in1[2]&~in1[1]&~in1[0]);

assign in1WritesRD= ~(in1_sw|in1_j|in1_bne|in1_jr|in1_blt|in1_bex|in1_setx|in1_noop);







wire rsMatch, rtMatch, rsMultMatch, rtMultMatch,rdMultMatch;
wire [4:0]rsBitMatch,rtBitMatch,rs,rt,rd, rsMBitMatch, rdMBitMatch,rtMBitMatch;

assign rs=in1[21:17];
assign rt= usesRD? in1[26:22] :in1[16:12];
assign rd= isJal ?{32{1'b1}} :in1[26:22];

xnor(rsBitMatch[0],rs[0],in2[22]);
xnor(rsBitMatch[1],rs[1],in2[23]);
xnor(rsBitMatch[2],rs[2],in2[24]);
xnor(rsBitMatch[3],rs[3],in2[25]);
xnor(rsBitMatch[4],rs[4],in2[26]);
and(rsMatch,rsBitMatch[0],rsBitMatch[1],rsBitMatch[2],rsBitMatch[3],rsBitMatch[4]);

xnor(rtBitMatch[0],rt[0],in2[22]);
xnor(rtBitMatch[1],rt[1],in2[23]);
xnor(rtBitMatch[2],rt[2],in2[24]);
xnor(rtBitMatch[3],rt[3],in2[25]);
xnor(rtBitMatch[4],rt[4],in2[26]);
and(rtMatch,rtBitMatch[0],rtBitMatch[1],rtBitMatch[2],rtBitMatch[3],rtBitMatch[4]);


xnor(rsMBitMatch[0],rs[0],inM[22]);
xnor(rsMBitMatch[1],rs[1],inM[23]);
xnor(rsMBitMatch[2],rs[2],inM[24]);
xnor(rsMBitMatch[3],rs[3],inM[25]);
xnor(rsMBitMatch[4],rs[4],inM[26]);
and(rsMultMatch,rsMBitMatch[0],rsMBitMatch[1],rsMBitMatch[2],rsMBitMatch[3],rsMBitMatch[4]);

xnor(rdMBitMatch[0],rd[0],inM[22]);
xnor(rdMBitMatch[1],rd[1],inM[23]);
xnor(rdMBitMatch[2],rd[2],inM[24]);
xnor(rdMBitMatch[3],rd[3],inM[25]);
xnor(rdMBitMatch[4],rd[4],inM[26]);
and(rdMultMatch,rdMBitMatch[0],rdMBitMatch[1],rdMBitMatch[2],rdMBitMatch[3],rdMBitMatch[4]);

xnor(rtMBitMatch[0],rt[0],inM[22]);
xnor(rtMBitMatch[1],rt[1],inM[23]);
xnor(rtMBitMatch[2],rt[2],inM[24]);
xnor(rtMBitMatch[3],rt[3],inM[25]);
xnor(rtMBitMatch[4],rt[4],inM[26]);
and(rtMultMatch,rtMBitMatch[0],rtMBitMatch[1],rtMBitMatch[2],rtMBitMatch[3],rtMBitMatch[4]);



wire match, multMatch;
assign match = (rsMatch|(rtMatch&(usesRD|usesRT)));
assign multMatch = (rsMultMatch|(rtMultMatch&(usesRD|usesRT))|(in1WritesRD&rdMultMatch));

assign stall= (isLW & match)|(multOngoing&multMatch)|(multOngoing&(isMult1));
//assign debugMultMatch=multMatch;

endmodule