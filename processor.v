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
	 debugFD,
	 debugDX,
	 debugXM,
	 debugMW,
	 debugALUinA,
	 debugALUinB,
	 debugStall
);

//debug

output[31:0] debugFD,debugDX,debugXM,debugMW,debugALUinA,debugALUinB;
output debugStall;

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
	 wire overWrite,aluNE,aluLT,aluOvf,isMult,isDiv;
	 wire [4:0]aluOp,aluShamt;
	 
//	 assign overWrite=1'b0;//TODO: channge overwrite signal when jump + branch is implemented
	 
	 programCounter pc(.clk(clock),.out(pcOut),.overwrite(overWrite),.overwrite_in(pcIn),.reset(reset),.we(pcWE));
	 assign address_imem=pcOut;
	 
	 wire [31:0]fd_instr_in,dx_instr_in;
	 assign fd_instr_in= overWrite ?{32{1'b0}} : q_imem;
	 f_pipe_reg fd_latch (.data_in(fd_instr_in),.we(fdWE), .clk(clock), .pc_in(pcOut),.reset(reset), .pc_out(fdPCOut),.instruction_out(fdIR));
	 
	 wire [31:0] fdDecoderInput;
	 assign fdDecoderInput = stall ? {32{1'b0}} : fdIR;
	 fdDecoder fd_decoder(.instruction(fdDecoderInput),.readRegA(ctrl_readRegA),.readRegB(ctrl_readRegB));
	 
	 assign dx_instr_in= overWrite? {32{1'b0}}:fdDecoderInput;
	 
	 d_pipe_reg dx_latch(.data_inA(dlatch_in_a),.we(dxWE),.data_inB(dlatch_in_b), .clk(clock), .pc_in(fdPCOut),.reset(reset),.data_outA(dxA),.data_outB(dxB),.pc_out(dxPCOut),.instruction_out(dxIR),.instruction_in(dx_instr_in));
	
	 dxDecoder dx_decoder(.instruction(dxIR), .regA(dxA),.regB(dxB),.overWriteRS(overwriteDXRS),.overWriteRT(overwriteDXRT),.xmOVR(xmO),.mwOVR(data_writeReg),
	 .outA(xA),.outB(xB),.aluOp(aluOp),.shamt(aluShamt),.isMult(isMult),.isDiv(isDiv),.isJump(overWrite),.jumpAmt(pcIn));
	 
	 alu myAlu(.data_operandA(xA),.data_operandB(xB),.ctrl_ALUopcode(aluOp),.ctrl_shiftamt(aluShamt),.data_result(aluOut),.isNotEqual(aluNE),.isLessThan(aluLT),.overflow(aluOvf));
	 /*MULTIPLIER*/
	 multdiv multiplier (.data_operandA(xA), .data_operandB(xB), .ctrl_MULT(isMult), .ctrl_DIV(isDiv), .clock(clockinv), .data_result(multOut), .data_exception(multException), .data_resultRDY(multReady));
	 wire[31:0]multOut,multInstruction;
	 wire multException,multReady,multInProgress;
	 wire [31:0]x_latch_instruciton_in;
	 assign x_latch_instruciton_in= (isMult|isDiv) ?{32{1'b0}}:dxIR;
	 
	 multdivLatch multDivLatch(.in(dxIR),.we(isMult|isDiv),.clock(clockinv),.out(multInstruction),.reset(reset),.done(multReady|multException),.inProgress(multInProgress));
	 
	 x_pipe_reg xm_latch (.dataA(aluOut),.dataB(dxB),.we(xmWE), .clk(clock),.reset(reset),.data_outA(xmO),.data_outB(xmB),.instruction_in(x_latch_instruciton_in),.instruction_out(xmIR)); 
	 
	 xmDecoder xm_decoder(.instruction(xmIR),.we(wren));
	 assign address_dmem=xmO[11:0];
	 assign data=xmB;
	 
	 
	 m_pipe_reg mw_latch (.dataO(xmO),.dataD(q_dmem),.we(mwWE), .clk(clock),.reset(reset),.data_outO(mwO),.data_outD(mwD),.instruction_in(xmIR),.instruction_out(mwIR));
	 
	 mwDecoder mw_decoder(.o(mwO),.d(mwD),.instruction(mwIR),.data(mwDataWriteReg),.writeReg(mwWriteReg),.we(mwRegWE));
	 
	 wire[4:0]mwWriteReg;
	 wire[31:0]mwDataWriteReg;
	 wire mwRegWE;
	 
	 assign data_writeReg=multReady ? multOut :mwDataWriteReg;// TODO: RSTATUS WRITE ERROR IF ERROR OCCURRED
	 assign ctrl_writeReg= multReady? multInstruction[26:22] : mwWriteReg;//TODO: RSTATUS
	 assign ctrl_writeEnable = multReady|mwRegWE;//TODO RSTATUS
	 
	 
	 /*HAZARD CONTROLLS*/
	 wire fdWE,dxWE,xmWE,mwWE,pcWE;
	 
	 rwHazardController rwHazController(.inFD(fdIR),.inDX(dxIR),.inXM(xmIR),.inMW(mwIR),.xmOverwriteDXRS(overwriteDXRS[0]),.xmOverwriteDXRT(overwriteDXRT[0]),.mwOverwriteDXRS(overwriteDXRS[1]),.mwOverwriteDXRT(overwriteDXRT[1]),.overWriteXMRD(overWriteXMRD),.overWriteRegA(overwriteFDRS),.overWriteRegB(overwriteFDRT));
	 stallController stallControl(.in1(fdIR),.in2(dxIR),.inM(multInstruction),.multOngoing(multInProgress),.stall(stall));
	 
	 
	 wire stall,stallInv;
	 wire [1:0] overwriteDXRS,overwriteDXRT;
	 wire [1:0]overWriteXMRD;
	 wire overwriteFDRS,overwriteFDRT;//DON'T need after fixing clocking
	 wire[31:0]dlatch_in_a,dlatch_in_b;
	 
	 
	 assign stallInv=~stall;
	 
	 assign dlatch_in_a = /*overwriteFDRS ? data_writeReg :*/ data_readRegA;
	 assign dlatch_in_b = /*overwriteFDRT ? data_writeReg :*/ data_readRegB;
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
	 assign debugFD=fdIR;
	 assign debugDX=dxIR;
	 assign debugXM=xmIR;
	 assign debugMW=mwIR;
	 assign debugALUinA=xA;
	 assign debugALUinB=xB;
	 assign debugStall=multReady;
	 
endmodule
