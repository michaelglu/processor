/**
 * NOTE: you should not need to change this file! This file will be swapped out for a grading
 * "skeleton" for testing. We will also remove your imem and dmem file.
 *
 * NOTE: skeleton should be your top-level module!
 *
 * This skeleton file serves as a wrapper around the processor to provide certain control signals
 * and interfaces to memory elements. This structure allows for easier testing, as it is easier to
 * inspect which signals the processor tries to assert when.
 */

module skeleton(clock, reset,debugR1,debugR2,debugR3,debugR4,debugR5,debugR6,debugR7,debugR8,debugR9,debugR10,debugR11,debugR12,debugR13,debugR14,debugR15,debugR16,debugR17,debugR18,debugR19,debugR20,debugR21,debugR22,debugR23,debugR24,debugR25,debugR26,debugR27,debugR28,debugR29,debugR30,debugR31,
/*debugFD,
	debugDX,
	 debugXM,
	 debugMW,
	 debugImem,
	 debugImemAddr,
	  debugALUinA,
	 debugALUinB,debugStall*/
	 );
    input clock, reset;
	 
	 
	 
	 /**DEBUG**/
	output[31:0]debugR1,debugR2,debugR3,debugR4,debugR5,debugR6,debugR7,debugR8,debugR9,debugR10,debugR11,debugR12,debugR13,debugR14,debugR15,debugR16,debugR17,debugR18,debugR19,debugR20,debugR21,debugR22,debugR23,debugR24,debugR25,debugR26,debugR27,debugR28,debugR29,debugR30,debugR31;
	/*output[31:0]debugFD,debugDX,debugXM,debugMW, debugALUinA,debugALUinB;
	 output [11:0]debugImemAddr;
	 output[31:0]debugImem;
	 output debugStall;
	 
	 assign debugImem=q_dmem;
	 assign debugImemAddr=address_dmem;*/

    /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_imem_1,address_imem_2;
    wire [31:0] q_imem_1,q_imem_2;
    imem my_imem_1(
        .address    (address_imem_1),            // address of data
        .clock      (~clock),                  // you may need to invert the clock
        .q          (q_imem_1)                   // the raw instruction
    );
	  imem my_imem_2(
        .address    (address_imem_2),            // address of data
        .clock      (~clock),                  // you may need to invert the clock
        .q          (q_imem_2)                   // the raw instruction
    );

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_dmem;
    wire [31:0] data;
    wire wren;
    wire [31:0] q_dmem;
    dmem my_dmem(
        .address    (address_dmem/* 12-bit wire */),       // address of data
        .clock      (~clock),                  // may need to invert the clock
        .data	    (data/* 32-bit data in */),    // data you want to write
        .wren	    (wren/* 1-bit signal */),      // write enable
        .q          (q_dmem/* 32-bit data out */)    // data from dmem
    );

    /** REGFILE **/
    // Instantiate your regfile
    wire ctrl_writeEnable_1,ctrl_writeEnable_2;
    wire [4:0] ctrl_writeReg_1,ctrl_writeReg_2, ctrl_readRegA_1,ctrl_readRegA_2, ctrl_readRegB_1,ctrl_readRegB_2;
    wire [31:0] data_writeReg_1,data_writeReg_2;
    wire [31:0] data_readRegA_1,data_readRegA_2, data_readRegB_1,data_readRegB_2;
    regfile my_regfile(
    clock,
    ctrl_writeEnable_1,
	 ctrl_writeEnable_2,
    reset, 
	 ctrl_writeReg_1,
	 ctrl_writeReg_2,
    ctrl_readRegA_1, 
	 ctrl_readRegB_1, 
	 data_writeReg_1,
    data_readRegA_1, 
	 data_readRegB_1,
	 ctrl_readRegA_2, 
	 ctrl_readRegB_2, 
	 data_writeReg_2,
    data_readRegA_2, 
	 data_readRegB_2,
	 
	 
		  debugR1,debugR2,debugR3,debugR4,debugR5,debugR6,debugR7,debugR8,debugR9,debugR10,debugR11,debugR12,debugR13,debugR14,debugR15,debugR16,debugR17,debugR18,debugR19,debugR20,debugR21,debugR22,debugR23,debugR24,debugR25,debugR26,debugR27,debugR28,debugR29,debugR30,debugR31
    );

    /** PROCESSOR **/
    processor my_processor(
        // Control signals
        clock,                          // I: The master clock
        reset,                          // I: A reset signal

        // Imem
        address_imem_1,                   // O: The address of the data to get from imem
        q_imem_1,                         // I: The data from imem

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
        data_readRegB_1,                   // I: Data from port B of regfile
		  
		  ctrl_writeEnable_2,               // O: Write enable for regfile
        ctrl_writeReg_2,                  // O: Register to write to in regfile
        ctrl_readRegA_2,                  // O: Register to read from port A of regfile
        ctrl_readRegB_2,                  // O: Register to read from port B of regfile
        data_writeReg_2,                  // O: Data to write to for regfile
        data_readRegA_2,                  // I: Data from port A of regfile
        data_readRegB_2,                   // I: Data from port B of regfile
	 	 /* debugFD,
	debugDX,
	 debugXM,
	 debugMW,debugALUinA,debugALUinB,debugStall*/
    );

endmodule
