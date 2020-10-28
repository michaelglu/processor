module fdDecoder(instruction_top,readRegA_top,readRegB_top,isJB_top,pcOut_top,pcIn_top,instructionOut_top,shouldBranchOrJump,
					  instruction_bot,readRegA_bot,readRegB_bot,isJB_bot,pcOut_bot,pcIn_bot,instructionOut_bot);

input[31:0]instruction_top,instruction_bot,pcIn_top,pcIn_bot;
output[4:0]readRegA_top,readRegB_top,readRegA_bot,readRegB_bot;
output isJB_top,isJB_bot,shouldBranchOrJump;
output[31:0]pcOut_top,pcOut_bot,instructionOut_top,instructionOut_bot;


wire isSw, isJumpRegister,isBNE,isBLT,overflow,isJump,isJal,isBEX;
wire isSw_bot, isJumpRegister_bot,isBNE_bot,isBLT_bot,overflow_bot,isJump_bot,isJal_bot,isBEX_bot;
wire[31:0]pcWire,branchWire,jumpWire,adder1;
wire[31:0]pcWire_bot,branchWire_bot,jumpWire_bot,adder1_bot;


//top
assign isJumpRegister = (~instruction_top[31]&~instruction_top[30]&instruction_top[29]&~instruction_top[28]&~instruction_top[27]);
assign isBNE=(~instruction_top[31]&~instruction_top[30]&~instruction_top[29]&instruction_top[28]&~instruction_top[27]);
assign isBLT=(~instruction_top[31]&~instruction_top[30]&instruction_top[29]&instruction_top[28]&~instruction_top[27]);
assign isJump=(~instruction_top[31]&~instruction_top[30]&~instruction_top[29]&~instruction_top[28]&instruction_top[27]);
assign isJal=(~instruction_top[31]&~instruction_top[30]&~instruction_top[29]&instruction_top[28]&instruction_top[27]);
assign isBEX=(instruction_top[31]&~instruction_top[30]&instruction_top[29]&instruction_top[28]&~instruction_top[27]);
//bot
assign isJumpRegister_bot = (~instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&~instruction_bot[28]&~instruction_bot[27]);
assign isBNE_bot=(~instruction_bot[31]&~instruction_bot[30]&~instruction_bot[29]&instruction_bot[28]&~instruction_bot[27]);
assign isBLT_bot=(~instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&instruction_bot[28]&~instruction_bot[27]);
assign isJump_bot=(~instruction_bot[31]&~instruction_bot[30]&~instruction_bot[29]&~instruction_bot[28]&instruction_bot[27]);
assign isJal_bot=(~instruction_bot[31]&~instruction_bot[30]&~instruction_bot[29]&instruction_bot[28]&instruction_bot[27]);
assign isBEX_bot=(instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&instruction_bot[28]&~instruction_bot[27]);



assign isSw=~instruction_top[31]&~instruction_top[30]&instruction_top[29]&instruction_top[28]&instruction_top[27];
assign isSw_bot=~instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&instruction_bot[28]&instruction_bot[27];


wire [4:0]readRegB_NOBEX;
assign readRegA_top=instruction_top[21:17];
assign readRegB_NOBEX= (isSw|isJumpRegister|isBNE|isBLT) ? instruction_top[26:22] : instruction_top[16:12];
assign readRegB_top = isBEX ? {5{1'b1}} : readRegB_NOBEX;
//bot
wire [4:0]readRegB_NOBEX_bot;
assign readRegA_bot=instruction_bot[21:17];
assign readRegB_NOBEX_bot= (isSw_bot|isJumpRegister_bot|isBNE_bot|isBLT_bot) ? instruction_bot[26:22] : instruction_bot[16:12];
assign readRegB_bot = isBEX_bot ? {5{1'b1}} : readRegB_NOBEX_bot;



assign isJB_top=isBNE|isBLT|isJump|isJal|isBEX;
assign isJB_bot=isBNE_bot|isBLT_bot|isJump_bot|isJal_bot|isBEX_bot;

assign jumpWire [31:27] ={5{1'b0}};
assign jumpWire [26:0]=instruction_top[26:0];
//bot
assign jumpWire_bot [31:27] ={5{1'b0}};
assign jumpWire_bot [26:0]=instruction_bot[26:0];

assign branchWire[31:16]= instruction_top[16] ? {16{1'b1}}:{16{1'b0}};
assign branchWire[15:0]=instruction_top[15:0];
//bot
assign branchWire_bot[31:16]= instruction_bot[16] ? {16{1'b1}}:{16{1'b0}};
assign branchWire_bot[15:0]=instruction_bot[15:0];

assign pcWire= (isBNE|isBLT) ?branchWire : jumpWire;
assign adder1 = (isBNE|isBLT) ? pcIn_top : {32{1'b0}};
//bot
assign pcWire_bot= (isBNE_bot|isBLT_bot) ?branchWire_bot : jumpWire_bot;
assign adder1_bot = (isBNE_bot|isBLT_bot) ? pcIn_bot : {32{1'b0}};



adder_cla_32_bit adder (.in1(adder1),.in2(pcWire),.cin(isBNE|isBLT),.sum(pcOut_top),.overflow(overflow));
assign instructionOut_top = (isJump) ? {32{1'b0}} : instruction_top;
//bot
adder_cla_32_bit adder_bot (.in1(adder1_bot),.in2(pcWire_bot),.cin(isBNE_bot|isBLT_bot),.sum(pcOut_bot),.overflow(overflow_bot));
assign instructionOut_bot = (isJump_bot) ? {32{1'b0}} : instruction_bot;
 
 
//BRANCH PREDICTOR
wire shouldTakeBranch;
predictor myPredictor (.shouldTakeBranch(shouldTakeBranch));
assign shouldBranchOrJump = (isJal|isJump) ? 1'b1 : (isBNE|isBLT|isBEX)&shouldTakeBranch; 

endmodule