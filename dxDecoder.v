module dxDecoder(instruction,pc, regA,regB,overWriteRS,overWriteRT,xmOVR,mwOVR,outA,outB,regBOut,aluOp,shamt,isMult,isDiv,isJR,isBLT,isBNE,isBEX,jrAmt,branchPredictedTaken);
input[31:0]instruction,regA,regB,xmOVR,mwOVR,pc;
input[1:0]overWriteRS,overWriteRT;
input branchPredictedTaken;
output[31:0]outA,outB,jrAmt,regBOut;
output[4:0]aluOp,shamt;
output isMult,isDiv,isJR,isBNE,isBLT,isBEX;

wire itype,isJR,isBranch,isJal;

assign itype = (~instruction[31]&~instruction[30]&instruction[29]&~instruction[28]&instruction[27])||//ADDI
					(~instruction[31]&~instruction[30]&instruction[29]&instruction[28]&instruction[27])||//LW
					(~instruction[31]&instruction[30]&~instruction[29]&~instruction[28]&~instruction[27]);//SW
 
wire [31:0]sei,rs,rt;
assign sei[16:0]=instruction[16:0];
assign sei[31:17]=instruction[16]? {15{1'b1}} : {15{1'b0}};

assign aluOp= (itype|isJal|isBranch) ? {5{1'b0}} :instruction[6:2];


assign isJR = (~instruction[31]&~instruction[30]&instruction[29]&~instruction[28]&~instruction[27]);
assign isBNE=(~instruction[31]&~instruction[30]&~instruction[29]&instruction[28]&~instruction[27]);
assign isBLT=(~instruction[31]&~instruction[30]&instruction[29]&instruction[28]&~instruction[27]);
assign isBEX=(instruction[31]&~instruction[30]&instruction[29]&instruction[28]&~instruction[27]);
assign isBranch=isBNE|isBLT|isBEX;


mux_4 rsMUX(.select(overWriteRS), .in0(regA), .in1(xmOVR), .in2(mwOVR), .in3(xmOVR), .out(rs));
mux_4 rtMUX(.select(overWriteRT), .in0(regB), .in1(xmOVR), .in2(mwOVR), .in3(xmOVR), .out(rt));




assign isMult = (~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&~instruction[27])
					&(~instruction[6]&~instruction[5]&instruction[4]&instruction[3]&~instruction[2]);
					
assign isDiv = (~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&~instruction[27])
				 &(~instruction[6]&~instruction[5]&instruction[4]&instruction[3]&instruction[2]);


assign isJal=(~instruction[31]&~instruction[30]&~instruction[29]&instruction[28]&instruction[27]);


wire[31:0]one, outBNoJump,aBranch,bBranch,outB_NOBEX;
assign one[0]=1'b1;
assign one[31:1]={31{1'b0}};

assign aBranch = isBranch ? rt :rs;
assign bBranch = isBranch ? rs : rt;
assign outA= (isJal) ? one :aBranch;

assign outBNoJump= itype ? sei : bBranch;
assign outB_NOBEX=(isJal) ? pc : outBNoJump;
assign outB = isBEX? {32{1'b0}}:outB_NOBEX;

assign shamt=instruction[11:7];
assign regBOut=bBranch;



wire [31:0]jumpImmediate;

assign adder1=pc;

wire overflow, cin;
assign cin = 1'b1;
// Need to recover from mispredicts both ways

wire [31:0] adder_in1,adder_in2,branchTarget;
assign branchTarget[31:16]= instruction[16] ? {16{1'b1}}:{16{1'b0}};
assign branchTarget[15:0]=instruction[15:0];

assign adder_in1= pc;
assign adder_in2= (isBranch&branchPredictedTaken) ? {32{1'b0}}:branchTarget;

adder_cla_32_bit adder (.in1(pc),.in2(adder_in2),.cin((isBranch&branchPredictedTaken)),.sum(jumpImmediate),.overflow(overflow));


assign jrAmt= isJR ? regB :jumpImmediate;

endmodule