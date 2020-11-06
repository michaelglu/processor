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
 d_FD_T,d_FD_B,
	 d_DX_T,d_DX_B,
	 d_XM_T,d_XM_B,
	 d_MW_T,d_MW_B,d_XM_O,d_XM_PC,
	 d_stall, d_cross_t,
	 d_cross_b,


	 debugImemAddr1,debugImemAddr2,debugImem1,debugImem2, debugRegA1,debugRegA2,debugRegB1,debugRegVal,debugRegB2,debugDmemAddr,debugDmem,debugDmemWren
	 );
    input clock, reset;
	 
	 
	 
	 /**DEBUG**/
	 output[3:0] d_cross_t,d_cross_b;
	output[31:0]debugR1,debugR2,debugR3,debugR4,debugR5,debugR6,debugR7,debugR8,debugR9,debugR10,debugR11,debugR12,debugR13,debugR14,debugR15,debugR16,debugR17,debugR18,debugR19,debugR20,debugR21,debugR22,debugR23,debugR24,debugR25,debugR26,debugR27,debugR28,debugR29,debugR30,debugR31;
	/*output[31:0]debugFD,debugDX,debugXM,debugMW, debugALUinA,debugALUinB;*/
	 output [11:0]debugImemAddr1,debugImemAddr2,debugDmemAddr;
	 output[31:0]debugImem1,debugImem2,debugDmem;
	 output[31:0]	 d_FD_T,d_FD_B,d_DX_T,d_DX_B,d_XM_T,d_XM_B,d_MW_T,d_MW_B,d_XM_O,d_XM_PC,debugRegVal;
output d_stall;
		output debugDmemWren;
	 output[4:0] debugRegA1,debugRegA2,debugRegB1,debugRegB2;
//	 output debugStall;
	 
	 assign debugImem1=q_imem_1;
	 assign debugImemAddr1=address_imem_1;
	 assign debugImem2=q_imem_2;
	 assign debugImemAddr2=address_imem_2;

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
	 
	 assign debugDmemAddr=address_dmem;
	 assign debugDmem=wren? data: q_dmem;
	 assign debugDmemWren=wren;

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
	 assign debugRegA1=ctrl_readRegA_1;
	 assign debugRegA2=ctrl_readRegA_2;
	 assign debugRegB1=ctrl_readRegB_1;
	 assign debugRegB2=ctrl_readRegB_2;
	 assign debugRegVal=data_readRegB_2;

    /** PROCESSOR **/
    processor my_processor(
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
        data_readRegB_1,                   // I: Data from port B of regfile
		  
		  ctrl_writeEnable_2,               // O: Write enable for regfile
        ctrl_writeReg_2,                  // O: Register to write to in regfile
        ctrl_readRegA_2,                  // O: Register to read from port A of regfile
        ctrl_readRegB_2,                  // O: Register to read from port B of regfile
        data_writeReg_2,                  // O: Data to write to for regfile
        data_readRegA_2,                  // I: Data from port A of regfile
        data_readRegB_2,                   // I: Data from port B of regfile
	 	 //debug
	 d_FD_T,d_FD_B,
	 d_DX_T,d_DX_B,
	 d_XM_T,d_XM_B,d_XM_O,d_XM_PC,
	 d_MW_T,d_MW_B,
	 d_stall, d_cross_t,
	 d_cross_b
	
	
	 
    );

endmodule
