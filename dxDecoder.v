module dxDecoder(instruction_top,pc_top, regA_top,regB_top,overWriteRS_top,overWriteRT_top,
					  xmOVR_top,mwOVR_top,outA_top,outB_top,regBOut_top,aluOp_top,shamt_top,
					  isMult_top,isDiv_top,isJR_top,isBLT_top,isBNE_top,isBEX_top,jrAmt_top,branchPredictedTaken,
					  instruction_bot,pc_bot, regA_bot,regB_bot,overWriteRS_bot,overWriteRT_bot,
					  xmOVR_bot,mwOVR_bot,outA_bot,outB_bot,regBOut_bot,aluOp_bot,shamt_bot,
					  isMult_bot,isDiv_bot,isJR_bot,isBLT_bot,isBNE_bot,isBEX_bot,jrAmt_bot,
					  cross_overWriteRS_top,cross_overWriteRT_top,cross_overWriteRS_bot,cross_overWriteRT_bot
					  );
					  
					  

input[31:0]instruction_top,regA_top,regB_top,xmOVR_top,mwOVR_top,pc_top;
input[1:0]overWriteRS_top,overWriteRT_top;
//bot
input[31:0]instruction_bot,regA_bot,regB_bot,xmOVR_bot,mwOVR_bot,pc_bot;
input[1:0]overWriteRS_bot,overWriteRT_bot,cross_overWriteRS_top,cross_overWriteRT_top,cross_overWriteRS_bot,cross_overWriteRT_bot;
input branchPredictedTaken;


output[31:0]outA_top,outB_top,jrAmt_top,regBOut_top;
output[4:0]aluOp_top,shamt_top;
output isMult_top,isDiv_top,isJR_top,isBNE_top,isBLT_top,isBEX_top;
//bot
output[31:0]outA_bot,outB_bot,jrAmt_bot,regBOut_bot;
output[4:0]aluOp_bot,shamt_bot;
output isMult_bot,isDiv_bot,isJR_bot,isBNE_bot,isBLT_bot,isBEX_bot;

wire itype_top,isJR_top,isBranch_top,isJal_top;

assign itype_top = (~instruction_top[31]&~instruction_top[30]&instruction_top[29]&~instruction_top[28]&instruction_top[27])||//ADDI
					(~instruction_top[31]&~instruction_top[30]&instruction_top[29]&instruction_top[28]&instruction_top[27])||//LW
					(~instruction_top[31]&instruction_top[30]&~instruction_top[29]&~instruction_top[28]&~instruction_top[27]);//SW
					
					
//bot

wire itype_bot,isJR_bot,isBranch_bot,isJal_bot;

assign itype_bot = (~instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&~instruction_bot[28]&instruction_bot[27])||//ADDI
					(~instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&instruction_bot[28]&instruction_bot[27])||//LW
					(~instruction_bot[31]&instruction_bot[30]&~instruction_bot[29]&~instruction_bot[28]&~instruction_bot[27]);//SW
//---------------------------------------------------------------------------------------------------------------------------------------------
 
wire [31:0]sei_top,rs_top,rt_top;

assign sei_top[16:0]=instruction_top[16:0];
assign sei_top[31:17]=instruction_top[16]? {15{1'b1}} : {15{1'b0}};

assign aluOp_top= (itype_top|isJal_top|isBranch_top) ? {5{1'b0}} :instruction_top[6:2];


assign isJR_top = (~instruction_top[31]&~instruction_top[30]&instruction_top[29]&~instruction_top[28]&~instruction_top[27]);
assign isBNE_top=(~instruction_top[31]&~instruction_top[30]&~instruction_top[29]&instruction_top[28]&~instruction_top[27]);
assign isBLT_top=(~instruction_top[31]&~instruction_top[30]&instruction_top[29]&instruction_top[28]&~instruction_top[27]);
assign isBEX_top=(instruction_top[31]&~instruction_top[30]&instruction_top[29]&instruction_top[28]&~instruction_top[27]);
assign isBranch_top=isBNE_top|isBLT_top|isBEX_top;


//mux_4 rsMUX_top(.select(overWriteRS_top), .in0(regA_top), .in1(xmOVR_top), .in2(mwOVR_top), .in3(xmOVR_top), .out(rs_top));
//mux_4 rtMUX_top(.select(overWriteRT_top), .in0(regB_top), .in1(xmOVR_top), .in2(mwOVR_top), .in3(xmOVR_top), .out(rt_top));
wire [31:0] rs_1_top,rs_2_top,rs_3_top,rs_1_bot,rs_2_bot,rs_3_bot,rt_1_top,rt_2_top,rt_3_top,rt_1_bot,rt_2_bot,rt_3_bot;

assign rs_1_top= overWriteRS_top[1] ? mwOVR_top:regA_top;
assign rs_2_top = cross_overWriteRS_top[1] ?mwOVR_bot :rs_1_top;
assign rs_3_top = overWriteRS_top[0]?xmOVR_top:rs_2_top;
assign rs_top=cross_overWriteRS_top[0]? xmOVR_bot:rs_3_top;


assign rs_1_bot= cross_overWriteRS_bot[1] ? mwOVR_top:regA_bot;
assign rs_2_bot = overWriteRS_bot[1] ?mwOVR_bot :rs_1_bot;
assign rs_3_bot = cross_overWriteRS_bot[0]?xmOVR_top:rs_2_bot;
assign rs_bot=overWriteRS_bot[0]? xmOVR_bot:rs_3_bot;

assign rt_1_top= overWriteRT_top[1] ? mwOVR_top:regB_top;
assign rt_2_top = cross_overWriteRT_top[1] ?mwOVR_bot :rt_1_top;
assign rt_3_top = overWriteRT_top[0]?xmOVR_top:rt_2_top;
assign rt_top=cross_overWriteRT_top[0]? xmOVR_bot:rt_3_top;


assign rt_1_bot= cross_overWriteRT_bot[1] ? mwOVR_top:regB_bot;
assign rt_2_bot = overWriteRT_bot[1] ?mwOVR_bot :rt_1_bot;
assign rt_3_bot = cross_overWriteRT_bot[0]?xmOVR_top:rt_2_bot;
assign rt_bot=overWriteRT_bot[0]? xmOVR_bot:rt_3_bot;


//bot

wire [31:0]sei_bot,rs_bot,rt_bot;

assign sei_bot[16:0]=instruction_bot[16:0];
assign sei_bot[31:17]=instruction_bot[16]? {15{1'b1}} : {15{1'b0}};

assign aluOp_bot= (itype_bot|isJal_bot|isBranch_bot) ? {5{1'b0}} :instruction_bot[6:2];


assign isJR_bot = (~instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&~instruction_bot[28]&~instruction_bot[27]);
assign isBNE_bot=(~instruction_bot[31]&~instruction_bot[30]&~instruction_bot[29]&instruction_bot[28]&~instruction_bot[27]);
assign isBLT_bot=(~instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&instruction_bot[28]&~instruction_bot[27]);
assign isBEX_bot=(instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&instruction_bot[28]&~instruction_bot[27]);
assign isBranch_bot=isBNE_bot|isBLT_bot|isBEX_bot;


//mux_4 rsMUX_bot(.select(overWriteRS_bot), .in0(regA_bot), .in1(xmOVR_bot), .in2(mwOVR_bot), .in3(xmOVR_bot), .out(rs_bot));
//mux_4 rtMUX_bot(.select(overWriteRT_bot), .in0(regB_bot), .in1(xmOVR_bot), .in2(mwOVR_bot), .in3(xmOVR_bot), .out(rt_bot));
//---------------------------------------------------------------------------------------------------------------------------------------------


assign isMult_top = (~instruction_top[31]&~instruction_top[30]&~instruction_top[29]&~instruction_top[28]&~instruction_top[27])
					&(~instruction_top[6]&~instruction_top[5]&instruction_top[4]&instruction_top[3]&~instruction_top[2]);
					
assign isDiv_top = (~instruction_top[31]&~instruction_top[30]&~instruction_top[29]&~instruction_top[28]&~instruction_top[27])
				 &(~instruction_top[6]&~instruction_top[5]&instruction_top[4]&instruction_top[3]&instruction_top[2]);


assign isJal_top=(~instruction_top[31]&~instruction_top[30]&~instruction_top[29]&instruction_top[28]&instruction_top[27]);

//bot
assign isMult_bot = (~instruction_bot[31]&~instruction_bot[30]&~instruction_bot[29]&~instruction_bot[28]&~instruction_bot[27])
					&(~instruction_bot[6]&~instruction_bot[5]&instruction_bot[4]&instruction_bot[3]&~instruction_bot[2]);
					
assign isDiv_bot = (~instruction_bot[31]&~instruction_bot[30]&~instruction_bot[29]&~instruction_bot[28]&~instruction_bot[27])
				 &(~instruction_bot[6]&~instruction_bot[5]&instruction_bot[4]&instruction_bot[3]&instruction_bot[2]);


assign isJal_bot=(~instruction_bot[31]&~instruction_bot[30]&~instruction_bot[29]&instruction_bot[28]&instruction_bot[27]);
//---------------------------------------------------------------------------------------------------------------------------------------------


wire[31:0]one;
wire[31:0] outB_topNoJump_top,aBranch_top,bBranch_top,outB_top_NOBEX_top;
wire[31:0] outB_botNoJump_bot,aBranch_bot,bBranch_bot,outB_bot_NOBEX_bot;
assign one[0]=1'b1;
assign one[31:1]={31{1'b0}};

assign aBranch_top = isBranch_top ? rt_top :rs_top;
assign bBranch_top = isBranch_top ? rs_top : rt_top;
assign outA_top= (isJal_top) ? one :aBranch_top;

assign outB_topNoJump_top= itype_top ? sei_top : bBranch_top;
assign outB_top_NOBEX_top=(isJal_top) ? pc_top : outB_topNoJump_top;
assign outB_top = isBEX_top? {32{1'b0}}:outB_top_NOBEX_top;

assign shamt_top=instruction_top[11:7];
assign regBOut_top=bBranch_top;

//bot

assign aBranch_bot = isBranch_bot ? rt_bot :rs_bot;
assign bBranch_bot = isBranch_bot ? rs_bot : rt_bot;
assign outA_bot= (isJal_bot) ? one :aBranch_bot;

assign outB_botNoJump_bot= itype_bot ? sei_bot : bBranch_bot;
assign outB_bot_NOBEX_bot=(isJal_bot) ? pc_bot : outB_botNoJump_bot;
assign outB_bot = isBEX_bot? {32{1'b0}}:outB_bot_NOBEX_bot;

assign shamt_bot=instruction_bot[11:7];
assign regBOut_bot=bBranch_bot;//FIX LATER
//---------------------------------------------------------------------------------------------------------------------------------------------


wire [31:0]jumpImmediate_top,jumpImmediate_bot;

wire overflow_top,overflow_bot;
// Need to recover from mispredicts both ways

wire [31:0] adder_in1_top,adder_in2_top,branchTarget_top;
assign branchTarget_top[31:16]= instruction_top[16] ? {16{1'b1}}:{16{1'b0}};
assign branchTarget_top[15:0]=instruction_top[15:0];
//bot
wire [31:0] adder_in1_bot,adder_in2_bot,branchTarget_bot;
assign branchTarget_bot[31:16]= instruction_bot[16] ? {16{1'b1}}:{16{1'b0}};
assign branchTarget_bot[15:0]=instruction_bot[15:0];
//---------------------------------------------------------------------------------------------------------------------------------------------


assign adder_in1_top= pc_top;
assign adder_in2_top= (isBranch_top&branchPredictedTaken) ? {32{1'b0}}:branchTarget_top;

adder_cla_32_bit adder_top (.in1(pc_top),.in2(adder_in2_top),.cin((isBranch_top&branchPredictedTaken)),.sum(jumpImmediate_top),.overflow(overflow_top));

assign jrAmt_top= isJR_top ? regBOut_top :jumpImmediate_top;

//bot
assign adder_in1_bot= rt_bot;
assign adder_in2_bot= (isBranch_bot&branchPredictedTaken) ? {32{1'b0}}:branchTarget_bot;

adder_cla_32_bit adder_bot (.in1(pc_bot),.in2(adder_in2_bot),.cin((isBranch_bot&branchPredictedTaken)),.sum(jumpImmediate_bot),.overflow(overflow_bot));


assign jrAmt_bot= isJR_bot ? regBOut_bot :jumpImmediate_bot;
//---------------------------------------------------------------------------------------------------------------------------------------------

endmodule