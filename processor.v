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
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB   ,                // I: Data from port B of regfile
	 
	 //debug
	/* debugFD,
	 debugDX,
	 debugXM,
	 debugMW,
	 debugALUinA,
	 debugALUinB,
	 debugStall*/
	  
);

//debug
/*
output[31:0] debugFD,debugDX,debugXM,debugMW,debugALUinA,debugALUinB;
output debugStall;*/

    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 
	 wire clockinv;
	 not(clockinv,clock);
	 wire [31:0]pcOut,pcIn,fdPCOut,fdIR,dxA,dxB,dxPCOut,dxIR,xA,xB,aluOut,xmO,xmB,xmIR,mwO,mwD,mwIR;
	 wire overWriteFD,overWriteDX,aluNE,aluLT,aluOvf,isMult,isDiv;
	 wire [4:0]aluOp,aluShamt;
	 
	 
	 programCounter pc(.clk(clock),.out(pcOut),.overwrite(overWriteFD|overWriteDX),.overwrite_in(pcIn),.reset(reset),.we(pcWE));
	 assign address_imem=pcOut[11:0];
	 
	 wire [31:0]fd_instr_in,fd_decoder_pc_out,fd_instr_out,dx_decoder_pc_out,dx_inst_in;
	 assign fd_instr_in= (overWriteFD|overWriteDX) ?{32{1'b0}} : q_imem;
	 f_pipe_reg fd_latch (.data_in(fd_instr_in),.we(fdWE), .clk(clock), .pc_in(pcOut),.reset(reset), .pc_out(fdPCOut),.instruction_out(fdIR));
	 
	 wire [31:0] fdDecoderInput, branchPC;
	 assign fdDecoderInput = stall ? {32{1'b0}} : fdIR;
	 wire isJB,shouldBranchOrJump;
	

	fdDecoder fd_decoder(.instruction(fdDecoderInput),.readRegA(ctrl_readRegA),.readRegB(ctrl_readRegB), 
	                     .isJB(isJB),.pcOut(fd_decoder_pc_out),.pcIn(fdPCOut),.instructionOut(fd_instr_out),.shouldBranchOrJump(shouldBranchOrJump));
								
	assign overWriteFD=isJB&shouldBranchOrJump;
	assign pcIn= overWriteDX ? dx_decoder_pc_out: fd_decoder_pc_out;
	 assign dx_inst_in= overWriteDX ?{32{1'b0}} :fd_instr_out;


	 d_pipe_reg dx_latch(.data_inA(dlatch_in_a),.we(dxWE),.data_inB(dlatch_in_b), .clk(clock), .pc_in(fdPCOut),.reset(reset),.data_outA(dxA),.data_outB(dxB)
	 ,.pc_out(dxPCOut),.instruction_out(dxIR),.instruction_in(dx_inst_in),.branchPredictedTaken_in(shouldBranchOrJump),.branchPredictedTaken_out(branchPredictedTaken));
	

	wire dx_isJR,dx_isBLT,dx_isBNE,dx_BEX,branchOverwrite,branchPredictedTaken;
	wire[31:0]dx_jrAmt,dx_regBOut;
	dxDecoder dx_decoder(.pc(dxPCOut),.instruction(dxIR), .regA(dxA),.regB(dxB),.overWriteRS(overwriteDXRS),.overWriteRT(overwriteDXRT),.xmOVR(xmOvr),.mwOVR(data_writeReg),
	 .outA(xA),.outB(xB),.aluOp(aluOp),.shamt(aluShamt),.isMult(isMult),.isDiv(isDiv),
	 .isJR(dx_isJR),.isBLT(dx_isBLT),.isBNE(dx_isBNE),.jrAmt(dx_jrAmt),.regBOut(dx_regBOut),.isBEX(dx_BEX),.branchPredictedTaken(branchPredictedTaken));
	 
	 wire [31:0]xmOvr;
	 assign xmOvr = xm_setX ?data_xmSetX :xmO;
	 





	 alu myAlu(.data_operandA(xA),.data_operandB(xB),.ctrl_ALUopcode(aluOp),.ctrl_shiftamt(aluShamt),.data_result(aluOut),.isNotEqual(aluNE),.isLessThan(aluLT),.overflow(aluOvf));
	

	assign branchOverwrite = branchPredictedTaken ? ((dx_isBNE & ~aluNE)|(dx_isBLT & ~aluLT)|(dx_BEX & ~aluNE)):((dx_isBNE & aluNE)|(dx_isBLT & aluLT)|(dx_BEX & aluNE));
	assign dx_decoder_pc_out = dx_jrAmt;
	assign overWriteDX=branchOverwrite|dx_isJR;
	assign debugBranchPredictedTaken=branchPredictedTaken;





	/*MULTIPLIER*/
	 multdiv multiplier (.data_operandA(xA), .data_operandB(xB), .ctrl_MULT(isMult), .ctrl_DIV(isDiv), .clock(clockinv), .data_result(multOut), .data_exception(multException), .data_resultRDY(multReady));
	 wire[31:0]multOut,multInstruction;
	 wire multException,multReady,multInProgress, xm_ovf;
	 wire [31:0]x_latch_instruciton_in;
	 assign x_latch_instruciton_in= (isMult|isDiv) ?{32{1'b0}}:dxIR;
	 
	 multdivLatch multDivLatch(.in(dxIR),.we(isMult|isDiv),.clock(clockinv),.out(multInstruction),.reset(reset),.done(multReady|multException),.inProgress(multInProgress));
	 
	 x_pipe_reg xm_latch (.dataA(aluOut),.dataB(dx_regBOut),.we(xmWE), .clk(clock),.reset(reset),.data_outA(xmO),.data_outB(xmB),.instruction_in(x_latch_instruciton_in),.instruction_out(xmIR),.ovf_in(aluOvf),.ovf_out(xm_ovf)); 
	 
	 wire xm_setX;
	 wire[31:0]data_xmSetX;
	 assign xm_setX=xmIR[31]&~xmIR[30]&xmIR[29]&~xmIR[28]&xmIR[27];
	 assign data_xmSetX[31:27]={5{1'b0}};
	 assign data_xmSetX[26:0]=xmIR[26:0];
	 
	 xmDecoder xm_decoder(.instruction(xmIR),.we(wren));
	 assign address_dmem=xmO[11:0];
	 assign data=xmB;
	 
	 
	 m_pipe_reg mw_latch (.dataO(xmO),.dataD(q_dmem),.we(mwWE), .clk(clock),.reset(reset),.data_outO(mwO),.data_outD(mwD),.instruction_in(xmIR),.instruction_out(mwIR),.ovf_in(xm_ovf),.ovf_out(mw_ovf));
	 
	 mwDecoder mw_decoder(.o(mwO),.d(mwD),.instruction(mwIR),.data(mwDataWriteReg),.writeReg(mwWriteReg),.we(mwRegWE),.ovf(mw_ovf));
	 
	 wire[4:0]mwWriteReg,multReg;
	 wire[31:0]mwDataWriteReg,four,five;
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
	 
	 wire mwRegWE,mw_ovf;
	 wire isDivOp;
	 
	 wire [31:0]multData,multE;
	 assign isDivOp = multInstruction[2]; 
	 assign multE= isDivOp ? five : four; 
	 assign multData = multException ? multE: multOut;
	 
	 assign data_writeReg=(multReady|multException) ? multData :mwDataWriteReg;// TODO: RSTATUS WRITE ERROR IF ERROR OCCURRED
	 assign ctrl_writeReg= multReady? multReg : mwWriteReg;//TODO: RSTATUS
	 assign ctrl_writeEnable = multReady|multException|mwRegWE;//TODO RSTATUS
	 
	 
	 /*HAZARD CONTROLLS*/
	 wire fdWE,dxWE,xmWE,mwWE,pcWE;
	 
	 rwHazardController rwHazController(.inFD(fdIR),.inDX(dxIR),.inXM(xmIR),.inMW(mwIR),.xmOverwriteDXRS(overwriteDXRS[0]),
	 .xmOverwriteDXRT(overwriteDXRT[0]),.mwOverwriteDXRS(overwriteDXRS[1]),.mwOverwriteDXRT(overwriteDXRT[1]),
	 .overWriteXMRD(overWriteXMRD),.overWriteRegA(overwriteFDRS),.overWriteRegB(overwriteFDRT),.ovfXM(xm_ovf),.ovfMW(mw_ovf));
	 
	 
	 
	 
	 stallController stallControl(.in1(fdIR),.in2(dxIR),.inM(multInstruction),.multOngoing(multInProgress),.stall(stall));
	 
	 
	 wire stall,stallInv;
	 wire [1:0] overwriteDXRS,overwriteDXRT;
	 wire [1:0]overWriteXMRD;
	 wire overwriteFDRS,overwriteFDRT;//DON'T need after fixing clocking
	 wire[31:0]dlatch_in_a,dlatch_in_b;
	 
	 
	 assign stallInv=~stall;
	 
	 assign dlatch_in_a =  data_readRegA;
	 assign dlatch_in_b =  data_readRegB;
	 /*EXCEPTION HANDLING*/
	 wire exception;
	 wire[31:0]exceptionVal;
	 assign exception={1'b0};
	 exceptionHandler eHandler (.instruction(dxIR),.setXVal({32{1'b0}}),.out(exceptionVal));
	 
	 assign fdWE= ~stall & ~exception & ~multException & ~multReady;
	 assign pcWE= ~stall & ~exception & ~multException & ~multReady;
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
