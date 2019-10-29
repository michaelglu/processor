module dxDecoder(instruction,pc, regA,regB,overWriteRS,overWriteRT,xmOVR,mwOVR,outA,outB,aluOp,shamt,isMult,isDiv,isJump,jumpAmt);
input[31:0]instruction,regA,regB,xmOVR,mwOVR,pc;
input[1:0]overWriteRS,overWriteRT;

output[31:0]outA,outB,jumpAmt;
output[4:0]aluOp,shamt;
output isMult,isDiv,isJump;

wire itype,isJal;

assign itype = (~instruction[31]&~instruction[30]&instruction[29]&~instruction[28]&instruction[27])||
					(~instruction[31]&~instruction[30]&instruction[29]&instruction[28]&instruction[27])||
					(~instruction[31]&instruction[30]&~instruction[29]&~instruction[28]&~instruction[27]);
 
wire [31:0]sei,rs,rt;
assign sei[16:0]=instruction[16:0];
assign sei[31:17]=instruction[16]? {15{1'b1}} : {15{1'b0}};

assign aluOp= (itype|isJump) ? {5{1'b0}} :instruction[6:2];



mux_4 rsMUX(.select(overWriteRS), .in0(regA), .in1(xmOVR), .in2(mwOVR), .in3(xmOVR), .out(rs));
mux_4 rtMUX(.select(overWriteRT), .in0(regB), .in1(xmOVR), .in2(mwOVR), .in3(xmOVR), .out(rt));




assign isMult = (~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&~instruction[27])
					&(~instruction[6]&~instruction[5]&instruction[4]&instruction[3]&~instruction[2]);
					
assign isDiv = (~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&~instruction[27])
				 &(~instruction[6]&~instruction[5]&instruction[4]&instruction[3]&instruction[2]);


assign isJal=(~instruction[31]&~instruction[30]&~instruction[29]&instruction[28]&instruction[27]);


wire[31:0]one, outBNoJump;
assign one[0]=1'b1;
assign one[31:1]={31{1'b0}};


assign outA= isJal ? one :rs;
assign outBNoJump= itype ? sei : rt;
assign outB=isJal ? pc : outBNoJump;
assign shamt=instruction[11:7];



assign isJump = (~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&instruction[27])
              | (~instruction[31]&~instruction[30]&instruction[29]&~instruction[28]&~instruction[27])|isJal;
wire [31:0]jumpImmediate;
assign jumpImmediate[31:27]={5{1'b0}};
assign jumpImmediate [26:0]=instruction[26:0];
 assign jumpAmt = (~instruction[31]&~instruction[30]&instruction[29]&~instruction[28]&~instruction[27]) ? regB:jumpImmediate;
 
endmodule