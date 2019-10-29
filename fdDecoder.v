module fdDecoder(instruction,readRegA,readRegB);

input[31:0]instruction;
output[4:0]readRegA,readRegB;

wire isSW, isJumpRegister,isBNE,isBLT;

assign isJumpRegister = (~instruction[31]&~instruction[30]&instruction[29]&~instruction[28]&~instruction[27]);
assign isBNE=(~instruction[31]&~instruction[30]&~instruction[29]&instruction[28]&~instruction[27]);
assign isBLT=(~instruction[31]&~instruction[30]&instruction[29]&instruction[28]&~instruction[27]);

assign isSw=~instruction[31]&~instruction[30]&instruction[29]&instruction[28]&instruction[27];

assign readRegA=instruction[21:17];
assign readRegB= (isSw|isJumpRegister|isBNE|isBLT) ? instruction[26:22] : instruction[16:12];


endmodule