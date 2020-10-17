module fdDecoder(instruction,readRegA,readRegB,isJB,pcOut,pcIn,instructionOut,shouldBranchOrJump);

input[31:0]instruction,pcIn;
output[4:0]readRegA,readRegB;
output isJB,shouldBranchOrJump;
output[31:0]pcOut,instructionOut;


wire isSw, isJumpRegister,isBNE,isBLT,overflow,isJump,isJal,isBEX;
wire[31:0]pcWire,branchWire,jumpWire,adder1;

assign isJumpRegister = (~instruction[31]&~instruction[30]&instruction[29]&~instruction[28]&~instruction[27]);
assign isBNE=(~instruction[31]&~instruction[30]&~instruction[29]&instruction[28]&~instruction[27]);
assign isBLT=(~instruction[31]&~instruction[30]&instruction[29]&instruction[28]&~instruction[27]);
assign isJump=(~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&instruction[27]);
assign isJal=(~instruction[31]&~instruction[30]&~instruction[29]&instruction[28]&instruction[27]);
assign isBEX=(instruction[31]&~instruction[30]&instruction[29]&instruction[28]&~instruction[27]);



assign isSw=~instruction[31]&~instruction[30]&instruction[29]&instruction[28]&instruction[27];


wire [4:0]readRegB_NOBEX;
assign readRegA=instruction[21:17];
assign readRegB_NOBEX= (isSw|isJumpRegister|isBNE|isBLT) ? instruction[26:22] : instruction[16:12];
assign readRegB = isBEX ? {5{1'b1}} : readRegB_NOBEX;

assign isJB=isBNE|isBLT|isJump|isJal|isBEX;

assign jumpWire [31:27] ={5{1'b0}};
assign jumpWire [26:0]=instruction[26:0];

assign branchWire[31:16]= instruction[16] ? {16{1'b1}}:{16{1'b0}};
assign branchWire[15:0]=instruction[15:0];

assign pcWire= (isBNE|isBLT) ?branchWire : jumpWire;
assign adder1 = (isBNE|isBLT) ? pcIn : {32{1'b0}};



adder_cla_32_bit adder (.in1(adder1),.in2(pcWire),.cin(isBNE|isBLT),.sum(pcOut),.overflow(overflow));
assign instructionOut = (isJump) ? {32{1'b0}} : instruction;
 
 
//BRANCH PREDICTOR
wire shouldTakeBranch;
predictor myPredictor (.shouldTakeBranch(shouldTakeBranch));
assign shouldBranchOrJump = (isJal|isJump) ? 1'b1 : (isBNE|isBLT|isBEX)&shouldTakeBranch; 

endmodule