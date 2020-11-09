/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem_1,                   // O: The address of the data to get from imem
    q_imem_1,                         // I: The data from imem
	 address_imem_2,                   // O: The address of the data to get from imem
    q_imem_2,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable_1,               // O: Write enable for regfile
    ctrl_writeReg_1,                  // O: Register to write to in regfile
    ctrl_readRegA_1,                  // O: Register to read from port A of regfile
    ctrl_readRegB_1,                  // O: Register to read from port B of regfile
    data_writeReg_1,                  // O: Data to write to for regfile
    data_readRegA_1,                  // I: Data from port A of regfile
    data_readRegB_1   ,                // I: Data from port B of regfile
	 
	 ctrl_writeEnable_2,               // O: Write enable for regfile
    ctrl_writeReg_2,                  // O: Register to write to in regfile
    ctrl_readRegA_2,                  // O: Register to read from port A of regfile
    ctrl_readRegB_2,                  // O: Register to read from port B of regfile
    data_writeReg_2,                  // O: Data to write to for regfile
    data_readRegA_2,                  // I: Data from port A of regfile
    data_readRegB_2   ,                // I: Data from port B of regfile
	 
	 //debug
	 d_FD_T,d_FD_B,
	 d_DX_T,d_DX_B,
	 d_XM_T,d_XM_B,d_XM_O,d_XM_PC,
	 d_MW_T,d_MW_B,
	 d_stall,
	 d_cross_t,

	 d_cross_b,
	 
	 predictorPC, predictor_past_pc,
	 isBranchD, shouldTakeBranch, predictor_past_wrong, branchPredictedTaken, past_is_branch

	
	  
);

//debug
/*
output[31:0] debugFD,debugDX,debugXM,debugMW,debugALUinA,debugALUinB;
output debugStall;*/
output[31:0]	 d_FD_T,d_FD_B,d_DX_T,d_DX_B,d_XM_T,d_XM_B,d_MW_T,d_MW_B,d_XM_O,d_XM_PC;
output d_stall;
output[3:0]d_cross_t,d_cross_b;


//OUTPUTS FOR PRED DEBUG
output[31:0] predictorPC, predictor_past_pc;
output isBranchD, shouldTakeBranch, predictor_past_wrong, branchPredictedTaken, past_is_branch;

assign past_is_branch = dx_isBNE|dx_isBNE_bot|dx_isBLT|dx_isBLT_bot|dx_BEX|dx_BEX_bot;

//OUTPUTS FOR PRED DEBUG


assign d_stall=overWriteDX;


    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem_1,address_imem_2;
    input [31:0] q_imem_1,q_imem_2;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable_1,ctrl_writeEnable_2;
    output [4:0] ctrl_writeReg_1, ctrl_readRegA_1, ctrl_readRegB_1,ctrl_writeReg_2, ctrl_readRegA_2, ctrl_readRegB_2;
    output [31:0] data_writeReg_1,data_writeReg_2;
    input [31:0] data_readRegA_1,data_readRegA_2, data_readRegB_1,data_readRegB_2;

    /* YOUR CODE STARTS HERE */
	 
	 wire clockinv;
	 not(clockinv,clock);
	 wire [31:0]pcOut,pcOut_bot,pcIn,fdPCOut,fdPCOut_bot,fdIR,fdIR_bot,dxA,dxA_bot,dxB,dxB_bot,dxPCOut,dxPCOut_bot,dxIR,dxIR_bot,dxIR_bot_pre;
	 wire[31:0]xA,xB,aluOut,xmO,xmB,xmIR,mwO,mwD,mwIR,xA_bot,xB_bot,aluOut_bot,xmO_bot,xmB_bot,xmIR_bot,mwO_bot,mwD_bot,mwIR_bot;
	 wire overWriteFD,overWriteDX,aluNE,aluLT,aluOvf,isMult,isDiv;
	 wire overWriteFD_bot,overWriteDX_bot,aluNE_bot,aluLT_bot,aluOvf_bot,isMult_bot,isDiv_bot;
	 wire [4:0]aluOp,aluShamt,aluOp_bot,aluShamt_bot;
	 
	 wire address_imem2_ovf;
	 
	 programCounter pc(.clk(clock),.out(pcOut),.overwrite(overWriteFD|overWriteDX),.overwrite_in(pcIn),.reset(reset),.we(pcWE));

	 adder_cla_32_bit pc_bot (.in1(pcOut),.in2({32{1'b0}}),.cin({1'b1}),.sum(pcOut_bot),.overflow(address_imem2_ovf));
	 assign address_imem_1=pcOut[11:0];
	 assign address_imem_2=pcOut_bot[11:0];

	 wire [31:0]fd_instr_in,fd_instr_in_bot,fd_decoder_pc_out,fd_decoder_pc_out_bot,fd_instr_out,fd_instr_out_bot;
	 wire[31:0] dx_decoder_pc_out,dx_decoder_pc_out_bot,dx_inst_in,dx_inst_in_bot;
	 assign fd_instr_in= (overWriteFD|overWriteDX) ?{32{1'b0}} : q_imem_1;
	 assign fd_instr_in_bot= (overWriteFD|overWriteDX) ?{32{1'b0}} : q_imem_2;
	 
	 f_pipe_reg fd_latch (.data_in_top(fd_instr_in),.data_in_bot(fd_instr_in_bot),.we(fdWE), .clk(clock), .pc_in_top(pcOut),.pc_in_bot(pcOut_bot),.reset(reset),
	 .pc_out_top(fdPCOut),.pc_out_bot(fdPCOut_bot),.instruction_out_top(fdIR),.instruction_out_bot(fdIR_bot));
	 
	 wire [31:0] fdDecoderInput,fdDecoderInput_bot, branchPC;
	 assign fdDecoderInput = stall ? {32{1'b0}} : fdIR;
	 assign fdDecoderInput_bot = stall ? {32{1'b0}} : fdIR_bot;


	wire doneStalling,amStalling;

 wire isJB,isJB_bot,shouldBranchOrJump,stall_bot,stalled_for_both,clearFF;



	wire doneStalling,amStalling;
//	assign amStalling=(stall_bot&~doneStalling);
	
	d_flip_flop stallbotFF (.d(stall_bot), .q(amStalling), .clk(clock), .ena(1'b1), .aclr(reset));
	
	d_flip_flop stallBOT_ALL (.d(1'b1), .q(stalled_for_both), .clk(clock), .ena(amStalling&stall), .aclr(clearFF|reset));
	d_flip_flop count_1 (.d(stalled_for_both), .q(clearFF), .clk(clock), .ena(1'b1), .aclr(reset));

	fdDecoder fd_decoder(.instruction_top((amStalling|stalled_for_both)?{32{1'b0}}:fdDecoderInput),.readRegA_top(ctrl_readRegA_1),.readRegB_top(ctrl_readRegB_1), 
	                     .isJB_top(isJB),.pcOut_top(fd_decoder_pc_out),.pcIn_top(fdPCOut),.instructionOut_top(fd_instr_out),.shouldBranchOrJump(shouldBranchOrJump),
								.instruction_bot(fdDecoderInput_bot),.readRegA_bot(ctrl_readRegA_2),.readRegB_bot(ctrl_readRegB_2), 
	                     .isJB_bot(isJB_bot),.pcOut_bot(fd_decoder_pc_out_bot),.pcIn_bot(fdPCOut_bot),.instructionOut_bot(fd_instr_out_bot),.stall_bot(stall_bot),
								.predictor_past_pc(predictor_past_pc),.predictor_past_wrong(predictor_past_wrong),

								.past_predicted_taken(branchPredictedTaken),.past_is_branch(dx_isBNE|dx_isBNE_bot|dx_isBLT|dx_isBLT_bot|dx_BEX|dx_BEX_bot),
								.clock(clock), .reset(reset),
								
								.predictorPC(predictorPC), .isBranchD(isBranchD), .shouldTakeBranch(shouldTakeBranch)
								
								
								);
								
	assign d_FD_T=fd_instr_out;
	assign d_FD_B=fd_instr_out_bot;
	wire [31:0] fd_decoder_PC, branch_overwrite_pc,dx_jrAmt_bot;
	
	//wire[31:0] predictor_past_pc;

	
	assign predictor_past_pc=branch_overwrite_pc;
	assign branch_overwrite_pc= branchOverwrite_top ? dxPCOut : dxPCOut_bot; 
	assign predictor_past_wrong=branchOverwrite;
	
	assign fd_decoder_PC=isJB ? fd_decoder_pc_out: fd_decoder_pc_out_bot;
	assign overWriteFD=((isJB|isJB_bot)&shouldBranchOrJump);
	assign pcIn= overWriteDX ? dx_decoder_pc_out: fd_decoder_PC;

	 assign dx_inst_in= overWriteDX|stall ?{32{1'b0}} :fd_instr_out;
	 assign dx_inst_in_bot= (overWriteDX|stall|stall_bot|(shouldBranchOrJump&isJB)) ?{32{1'b0}} :fd_instr_out_bot;



	 d_pipe_reg dx_latch(.data_inA_top(dlatch_in_a),.data_inA_bot(dlatch_in_a_bot),.we(dxWE)
	                    ,.data_inB_top(dlatch_in_b),.data_inB_bot(dlatch_in_b_bot),
							  .clk(clock), .pc_in_top(fdPCOut),.pc_in_bot(fdPCOut_bot),.reset(reset),
							  .data_outA_top(dxA),.data_outB_top(dxB),
							  .data_outA_bot(dxA_bot),.data_outB_bot(dxB_bot)
	 ,.pc_out_top(dxPCOut),.pc_out_bot(dxPCOut_bot),.instruction_out_top(dxIR),.instruction_out_bot(dxIR_bot),.instruction_in_top(dx_inst_in),.instruction_in_bot(dx_inst_in_bot),.branchPredictedTaken_in(shouldBranchOrJump),.branchPredictedTaken_out(branchPredictedTaken));
	

	wire dx_isJR,dx_isBLT,dx_isBNE,dx_BEX,branchOverwrite,branchOverwrite_top,branchOverwrite_bot,branchPredictedTaken;
	wire dx_isJR_bot,dx_isBLT_bot,dx_isBNE_bot,dx_BEX_bot;
	wire[31:0]dx_jrAmt,dx_regBOut,dx_regBOut_bot;
	
	dxDecoder dx_decoder(.pc_top(dxPCOut),.instruction_top(dxIR), .regA_top(dxA),.regB_top(dxB),.overWriteRS_top(overwriteDXRS),.overWriteRT_top(overwriteDXRT)
	,.xmOVR_top(xmOvr),.mwOVR_top(data_writeReg_1),.outA_top(xA),.outB_top(xB),.aluOp_top(aluOp),.shamt_top(aluShamt),.isMult_top(isMult),.isDiv_top(isDiv),
	 .isJR_top(dx_isJR),.isBLT_top(dx_isBLT),.isBNE_top(dx_isBNE),.jrAmt_top(dx_jrAmt),.regBOut_top(dx_regBOut),.isBEX_top(dx_BEX),.branchPredictedTaken(branchPredictedTaken),
	 //bot
	 .pc_bot(dxPCOut_bot),.instruction_bot(dxIR_bot), .regA_bot(dxA_bot),.regB_bot(dxB_bot),.overWriteRS_bot(overwriteDXRS_bot),.overWriteRT_bot(overwriteDXRT_bot)
	,.xmOVR_bot(xmOvr_bot),.mwOVR_bot(data_writeReg_2),.outA_bot(xA_bot),.outB_bot(xB_bot),.aluOp_bot(aluOp_bot),.shamt_bot(aluShamt_bot),.isMult_bot(isMult_bot),.isDiv_bot(isDiv_bot),
	 .isJR_bot(dx_isJR_bot),.isBLT_bot(dx_isBLT_bot),.isBNE_bot(dx_isBNE_bot),.jrAmt_bot(dx_jrAmt_bot),.regBOut_bot(dx_regBOut_bot),.isBEX_bot(dx_BEX_bot),
	
	.cross_overWriteRS_top(cross_overwriteDXRS_top),.cross_overWriteRT_top(cross_overwriteDXRT_top),.cross_overWriteRS_bot(cross_overwriteDXRS_bot),.cross_overWriteRT_bot(cross_overwriteDXRT_bot)
	 
	 );

	 
	 assign d_DX_T=dxIR;
	 assign d_DX_B=dxIR_bot;
	 

	 wire [31:0]xmOvr,xmOvr_bot;
	 assign xmOvr = xm_setX ?data_xmSetX :xmO;
	 assign xmOvr_bot = xm_setX_bot ?data_xmSetX_bot :xmO_bot;
	 





	 alu myAlu(.data_operandA(xA),.data_operandB(xB),.ctrl_ALUopcode(aluOp),.ctrl_shiftamt(aluShamt),.data_result(aluOut),.isNotEqual(aluNE),.isLessThan(aluLT),.overflow(aluOvf));
	 alu myAlu_bot(.data_operandA(xA_bot),.data_operandB(xB_bot),.ctrl_ALUopcode(aluOp_bot),.ctrl_shiftamt(aluShamt_bot),.data_result(aluOut_bot),.isNotEqual(aluNE_bot),.isLessThan(aluLT_bot),.overflow(aluOvf_bot));
	

	assign branchOverwrite_top = branchPredictedTaken ? ((dx_isBNE & ~aluNE)|(dx_isBLT & ~aluLT)|(dx_BEX & ~aluNE)):((dx_isBNE & aluNE)|(dx_isBLT & aluLT)|(dx_BEX & aluNE));
	assign branchOverwrite_bot = branchPredictedTaken ? ((dx_isBNE_bot & ~aluNE_bot)|(dx_isBLT_bot & ~aluLT_bot)|(dx_BEX_bot & ~aluNE_bot)):((dx_isBNE_bot & aluNE_bot)|(dx_isBLT_bot & aluLT_bot)|(dx_BEX_bot & aluNE_bot));
	assign branchOverwrite=branchOverwrite_top|branchOverwrite_bot;
	assign dx_decoder_pc_out = (dx_isJR|branchOverwrite_top)?dx_jrAmt:dx_jrAmt_bot;
	
	assign overWriteDX=branchOverwrite|dx_isJR|dx_isJR_bot;
	assign debugBranchPredictedTaken=branchPredictedTaken;


		wire [31:0] multA,multB,multIR;
		assign multA=(isMult|isDiv) ? xA:xA_bot;
		assign multB =(isMult|isDiv)?xB:xB_bot;
		assign multIR=(isMult|isDiv)?dxIR:dxIR_bot;
	/*MULTIPLIER*/
	 multdiv multiplier (.data_operandA(multA), .data_operandB(multB), .ctrl_MULT((isMult|isMult_bot)&~dx_isJR), .ctrl_DIV((isDiv|isDiv_bot)&~dx_isJR), .clock(clockinv), .data_result(multOut), .data_exception(multException), .data_resultRDY(multReady));
	 wire[31:0]multOut,multInstruction;
	 wire multException,multReady,multInProgress, xm_ovf;
	 wire [31:0]x_latch_instruciton_in,x_latch_instruciton_in_bot;
	 assign x_latch_instruciton_in= (isMult|isDiv) ?{32{1'b0}}:dxIR;
	 assign x_latch_instruciton_in_bot= (isMult_bot|isDiv_bot|dx_isJR|branchOverwrite_top) ?{32{1'b0}}:dxIR_bot;
	 

	 
	 multdivLatch multDivLatch(.in(multIR),.we((isMult|isDiv|isMult_bot|isDiv_bot)&~dx_isJR),.clock(clockinv),.out(multInstruction),.reset(reset),.done(multReady|multException),.inProgress(multInProgress));
	 
	 x_pipe_reg xm_latch (.dataA_top(aluOut),.dataB_top(dx_regBOut),.we(xmWE), .clk(clock),.reset(reset),.data_outA_top(xmO),.data_outB_top(xmB)
	 ,.instruction_in_top(x_latch_instruciton_in),.instruction_out_top(xmIR),.ovf_in_top(aluOvf),.ovf_out_top(xm_ovf),
	 .dataA_bot(aluOut_bot),.dataB_bot(dx_regBOut_bot),.data_outA_bot(xmO_bot),.data_outB_bot(xmB_bot)
	 ,.instruction_in_bot(x_latch_instruciton_in_bot),.instruction_out_bot(xmIR_bot),.ovf_in_bot(aluOvf_bot),.ovf_out_bot(xm_ovf_bot)
	 
	 ); 
	 
	 wire xm_setX,xm_setX_bot;
	 wire[31:0]data_xmSetX,data_xmSetX_bot;
	 assign xm_setX=xmIR[31]&~xmIR[30]&xmIR[29]&~xmIR[28]&xmIR[27];
	 assign xm_setX_bot=xmIR_bot[31]&~xmIR_bot[30]&xmIR_bot[29]&~xmIR_bot[28]&xmIR_bot[27];
	 assign data_xmSetX[31:27]={5{1'b0}};
	 assign data_xmSetX[26:0]=xmIR[26:0];
	 assign data_xmSetX_bot[31:27]={5{1'b0}};
	 assign data_xmSetX_bot[26:0]=xmIR_bot[26:0];

	 

	 
	 wire dmem_wren_top,dmem_wren_bot,xm_mem_top,xm_mem_bot;
	 xmDecoder xm_decoder(.instruction_top(xmIR),.we_top(dmem_wren_top),.instruction_bot(xmIR_bot),.we_bot(dmem_wren_bot),.mem_top(xm_mem_top),.mem_bot(xm_mem_bot));
	 assign wren=dmem_wren_top|dmem_wren_bot;
	 assign address_dmem=xm_mem_top?xmO[11:0]:xmO_bot[11:0];
	 assign data=xm_mem_top?xmB:xmB_bot;
	 
//	 assign d_XM_T=xmIR;
	// assign d_XM_B=xmIR_bot;
	 assign d_XM_PC=xmB_bot;
//	 assign d_XM_O=xmO_bot;

	 
	 m_pipe_reg mw_latch (.dataO_top(xmO),.dataD_top(q_dmem),.we(mwWE), .clk(clock),.reset(reset),
	 .data_outO_top(mwO),.data_outD_top(mwD),.instruction_in_top(xmIR),.instruction_out_top(mwIR),.ovf_in_top(xm_ovf),.ovf_out_top(mw_ovf),
	 .dataO_bot(xmO_bot),.dataD_bot(q_dmem),.data_outO_bot(mwO_bot),.data_outD_bot(mwD_bot),
	 .instruction_in_bot(xmIR_bot),.instruction_out_bot(mwIR_bot),.ovf_in_bot(xm_ovf_bot),.ovf_out_bot(mw_ovf_bot)
	 );
	 
	 mwDecoder mw_decoder(.o_top(mwO),.d_top(mwD),.instruction_top(mwIR),.data_top(mwDataWriteReg),.writeReg_top(mwWriteReg),.we_top(mwRegWE),.ovf_top(mw_ovf),
								 .o_bot(mwO_bot),.d_bot(mwD_bot),.instruction_bot(mwIR_bot),.data_bot(mwDataWriteReg_bot),.writeReg_bot(mwWriteReg_bot),.we_bot(mwRegWE_bot),.ovf_bot(mw_ovf_bot)
	 );
	 

	 assign d_MW_T=mwIR;
	  assign d_MW_B=mwIR_bot;
	 
	 wire[4:0]mwWriteReg,multReg,mwWriteReg_bot,multReg_bot;
	 wire[31:0]mwDataWriteReg,mwDataWriteReg_bot,four,five;
	 assign four[31:3]={29{1'b0}};
	 assign four [2]=1'b1;
	 assign four [1:0]={2{1'b0}};
	 assign five[31:3]={29{1'b0}};
	 assign five [2]=1'b1;
	 assign five[1]=1'b0;
	 assign five[0]=1'b1;
	 
	 wire [4:0]r30;
	 assign r30[4:1]={4{1'b1}};
	 assign r30[0]=1'b0;
	 
	 assign multReg = multException ? r30 : multInstruction[26:22] ;
	 
	 wire mwRegWE,mwRegWE_bot,mw_ovf,mw_ovf_bot;
	 wire isDivOp;
	 
	 wire [31:0]multData,multE;
	 assign isDivOp = multInstruction[2]; 
	 assign multE= isDivOp ? five : four; 
	 assign multData = multException ? multE: multOut;
	 
	wire writing_cross,writing_zero;
	wire[4:0]writing_comparator;
	
	xnor(writing_comparator[0],mwWriteReg[0],mwWriteReg_bot[0]);
	xnor(writing_comparator[1],mwWriteReg[1],mwWriteReg_bot[1]);
	xnor(writing_comparator[2],mwWriteReg[2],mwWriteReg_bot[2]);
	xnor(writing_comparator[3],mwWriteReg[3],mwWriteReg_bot[3]);
	xnor(writing_comparator[4],mwWriteReg[4],mwWriteReg_bot[4]);
	and(writing_cross,writing_comparator[0],writing_comparator[1],writing_comparator[2],writing_comparator[3],writing_comparator[4]);
	nor(writing_zeros,mwWriteReg[0],mwWriteReg[1],mwWriteReg[2],mwWriteReg[3],mwWriteReg[4])	;
	 
	 assign data_writeReg_1=(multReady|multException) ? multData :mwDataWriteReg;// TODO: RSTATUS WRITE ERROR IF ERROR OCCURRED
	 assign ctrl_writeReg_1= multReady? multReg : mwWriteReg;//TODO: RSTATUS
	 assign ctrl_writeEnable_1 = multReady|multException|(mwRegWE& (~writing_cross|writing_zeros));//TODO RSTATUS
	 
	 assign data_writeReg_2 = mwDataWriteReg_bot;
	 assign ctrl_writeReg_2= mwWriteReg_bot;
	 assign ctrl_writeEnable_2= ~(multReady|multException)&mwRegWE_bot;
	 
	 
	 /*HAZARD CONTROLLS*/
	 wire fdWE,dxWE,xmWE,mwWE,pcWE;
	 //top
	 rwHazardController rwHazController(.inFD(fdIR),.inDX(dxIR),.inXM(xmIR),.inMW(mwIR),.xmOverwriteDXRS(overwriteDXRS[0]),
	 .xmOverwriteDXRT(overwriteDXRT[0]),.mwOverwriteDXRS(overwriteDXRS[1]),.mwOverwriteDXRT(overwriteDXRT[1]),
	 .overWriteXMRD(overWriteXMRD),.ovfXM(xm_ovf),.ovfMW(mw_ovf));
	 //bot
	  rwHazardController rwHazController_bot(.inFD(fdIR_bot),.inDX(dxIR_bot),.inXM(xmIR_bot),.inMW(mwIR_bot),.xmOverwriteDXRS(overwriteDXRS_bot[0]),
	 .xmOverwriteDXRT(overwriteDXRT_bot[0]),.mwOverwriteDXRS(overwriteDXRS_bot[1]),.mwOverwriteDXRT(overwriteDXRT_bot[1]),
	 .overWriteXMRD(overWriteXMRD_bot),.ovfXM(xm_ovf_bot),.ovfMW(mw_ovf_bot));
	 //top->bot
	  rwHazardController rwHazController_cross_bot(.inFD(fdIR_bot),.inDX(dxIR_bot),.inXM(xmIR),.inMW(mwIR),.xmOverwriteDXRS(cross_overwriteDXRS_bot[0]),
	 .xmOverwriteDXRT(cross_overwriteDXRT_bot[0]),.mwOverwriteDXRS(cross_overwriteDXRS_bot[1]),.mwOverwriteDXRT(cross_overwriteDXRT_bot[1]),
	 .ovfXM(xm_ovf),.ovfMW(mw_ovf));
	   rwHazardController rwHazController_cross_top_m(.inFD(fdIR_bot),.inDX(dxIR_bot),.inXM(xmIR_bot),.inMW(mwIR),.overWriteXMRD(cross_overWriteXMRD_bot),
	 .ovfXM(xm_ovf_bot),.ovfMW(mw_ovf));
	 //bot->top

	 
	  rwHazardController rwHazController_cross_top(.inFD(fdIR),.inDX(dxIR),.inXM(xmIR_bot),.inMW(mwIR_bot),.xmOverwriteDXRS(cross_overwriteDXRS_top[0]),
	 .xmOverwriteDXRT(cross_overwriteDXRT_top[0]),.mwOverwriteDXRS(cross_overwriteDXRS_top[1]),.mwOverwriteDXRT(cross_overwriteDXRT_top[1]),
	 .ovfXM(xm_ovf_bot),.ovfMW(mw_ovf_bot));
	  rwHazardController rwHazController_cross_bot_m(.inFD(fdIR),.inDX(dxIR),.inXM(xmIR),.inMW(mwIR_bot),.overWriteXMRD(cross_overWriteXMRD_top),
	 .ovfXM(xm_ovf),.ovfMW(mw_ovf_bot));
	 
	 
	 assign d_cross_t[1:0]=cross_overwriteDXRS_top;
	 assign d_cross_b[1:0]=cross_overwriteDXRT_top;
	 assign d_cross_t[3:2]=cross_overwriteDXRS_bot;
	 assign d_cross_b[3:2]=cross_overwriteDXRT_bot;
	 
	 
	 stallController stallControl(.in1(stall_bot? {32{1'b0}} :fdIR),.in2(dxIR),.inM(multInstruction),.multOngoing(multInProgress),.stall(stall_everything_top));
	 stallController stallControl_bot(.in1(fdIR_bot),.in2(dxIR_bot),.inM(multInstruction),.multOngoing(multInProgress),.stall(stall_everything_bot));
	 
	  stallController stallControl_cross_top(.in1(stall_bot? {32{1'b0}} :fdIR),.in2(dxIR_bot),.inM(multInstruction),.multOngoing(multInProgress),.stall(stall_cross_1));
	 stallController stallControl_cross_bot(.in1(fdIR_bot),.in2(dxIR),.inM(multInstruction),.multOngoing(multInProgress),.stall(stall_cross_2));
	 
	 assign stall=stall_everything_top|stall_everything_bot|stall_cross_1|stall_cross_2;
	 

	 wire stall_everything_top, stall_everything_bot,stall,stallInv,stall_cross_1,stall_cross_2;
	 wire [1:0] overwriteDXRS,overwriteDXRT,overwriteDXRS_bot,overwriteDXRT_bot;
	 wire[1:0] cross_overwriteDXRS_top,cross_overwriteDXRT_top,cross_overwriteDXRS_bot,cross_overwriteDXRT_bot;
	 

	 wire [1:0]overWriteXMRD,overWriteXMRD_bot,cross_overWriteXMRD_top,cross_overWriteXMRD_bot;
	 wire[31:0]dlatch_in_a,dlatch_in_b,dlatch_in_a_bot,dlatch_in_b_bot;
	 
	 
	 assign stallInv=~stall;
	 
	 assign dlatch_in_a =  data_readRegA_1;
	 assign dlatch_in_b =  data_readRegB_1;
	 assign dlatch_in_a_bot =  data_readRegA_2;
	 assign dlatch_in_b_bot =  data_readRegB_2;
	 /*EXCEPTION HANDLING*/
	 wire exception;
	 wire[31:0]exceptionVal;
	 assign exception={1'b0};
	 exceptionHandler eHandler (.instruction(dxIR),.setXVal({32{1'b0}}),.out(exceptionVal));
	 
	 assign fdWE= ~stall & ~exception & ~multException & ~multReady&(~stall_bot|overWriteDX);
	 assign pcWE= ~stall & ~exception & ~multException & ~multReady&(~stall_bot|overWriteDX);
	 assign dxWE= ~exception & ~multException&~multReady;
	 assign xmWE= ~exception & ~multException&~multReady;
	 assign mwWE=~exception & ~multException&~multReady;
	 
	 /*DEGUG*/
	/* assign debugFD=fdIR;
	 assign debugDX=dxIR;
	 assign debugXM=xmIR;
	 assign debugMW=mwIR;
	 assign debugALUinA=pcIn;
	 assign debugALUinB=pcOut;
	 assign debugStall=overwriteDXRT[0];*/
	 
endmodule
