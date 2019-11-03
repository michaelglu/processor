module stallController(in1,in2,inM,stall,multOngoing);

input [31:0]in1, in2,inM;
input multOngoing;
output stall;

wire isLW,isMult1;
assign isLW=~in2[31]&in2[30]&~in2[29]&~in2[28]&~in2[27];
assign isMult1 = (~in1[31]&~in1[30]&~in1[29]&~in1[28]&~in1[27])&(~in1[6]&~in1[5]&in1[4]&in1[3]);



wire dx_sll,dx_srr,dx_sw,dx_bne,dx_jr,dx_blt, usesRT,usesRD;
assign dx_sll= (~in1[31]&~in1[30]&~in1[29]&~in1[28]&~in1[27])&(~in1[6]&~in1[5]&in1[4]&~in1[3]&~in1[2]);
assign dx_srr= (~in1[31]&~in1[30]&~in1[29]&~in1[28]&~in1[27])&(~in1[6]&~in1[5]&in1[4]&~in1[3]&in1[2]);
assign usesRT=(~in1[31]&~in1[30]&~in1[29]&~in1[28]&~in1[27])&~dx_sll&~dx_srr;

assign dx_sw=(~in1[31]&~in1[30]&in1[29]&in1[28]&in1[27]);
assign dx_bne=(~in1[31]&~in1[30]&~in1[29]&in1[28]&~in1[27]);
assign dx_blt=(~in1[31]&~in1[30]&in1[29]&in1[28]&~in1[27]);
assign dx_jr=(~in1[31]&~in1[30]&in1[29]&~in1[28]&~in1[27]);

assign usesRD= (dx_sw|dx_bne|dx_jr|dx_blt);


wire rsMatch, rtMatch, rsMultMatch, rtMultMatch;
wire [4:0]rsBitMatch,rtBitMatch,rs,rt, rsMBitMatch,rtMBitMatch;

assign rs=in1[21:17];
assign rt= usesRD? in1[26:22] :in1[16:12];

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

xnor(rtMBitMatch[0],rt[0],inM[22]);
xnor(rtMBitMatch[1],rt[1],inM[23]);
xnor(rtMBitMatch[2],rt[2],inM[24]);
xnor(rtMBitMatch[3],rt[3],inM[25]);
xnor(rtMBitMatch[4],rt[4],inM[26]);
and(rtMultMatch,rtMBitMatch[0],rtMBitMatch[1],rtMBitMatch[2],rtMBitMatch[3],rtMBitMatch[4]);



wire match, multMatch;
assign match = (rsMatch|(rtMatch&(usesRD|usesRT)));
assign multMatch = (rsMultMatch|(rtMultMatch&(usesRD|usesRT)));

assign stall= (isLW & match)|(multOngoing&multMatch)|(multOngoing&(isMult1));
//assign debugMultMatch=multMatch;

endmodule