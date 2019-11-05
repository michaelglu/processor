module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB,
	/* debugR1,debugR2,debugR3,debugR4,debugR5,debugR6,debugR7,debugR8,debugR9,debugR10,debugR11,debugR12,debugR13,debugR14,debugR15,debugR16,debugR17,debugR18,debugR19,debugR20,debugR21,debugR22,debugR23,debugR24,debugR25,debugR26,debugR27,debugR28,debugR29,debugR30,debugR31*/
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;
	wire clockInv;
	assign clockInv=~clock;
   output [31:0] data_readRegA, data_readRegB;
	
	/*output[31:0]debugR1,debugR2,debugR3,debugR4,debugR5,debugR6,debugR7,debugR8,debugR9,debugR10,debugR11,debugR12,debugR13,debugR14,debugR15,debugR16,debugR17,debugR18,debugR19,debugR20,debugR21,debugR22,debugR23,debugR24,debugR25,debugR26,debugR27,debugR28,debugR29,debugR30,debugR31;*/

   /* YOUR CODE HERE */
	wire[31:0] zero,wr,we,rA,rB,r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24,r25,r26,r27,r28,r29,r30,r31;
	decoder writeDecoder(.i(ctrl_writeReg),.out(wr));
	decoder readDecoderA(.i(ctrl_readRegA),.out(rA));
	decoder readDecoderB(.i(ctrl_readRegB),.out(rB));
	and(we[0],wr[0],ctrl_writeEnable);
	and(we[1],wr[1],ctrl_writeEnable);
	and(we[2],wr[2],ctrl_writeEnable);
	and(we[3],wr[3],ctrl_writeEnable);
	and(we[4],wr[4],ctrl_writeEnable);
	and(we[5],wr[5],ctrl_writeEnable);
	and(we[6],wr[6],ctrl_writeEnable);
	and(we[7],wr[7],ctrl_writeEnable);
	and(we[8],wr[8],ctrl_writeEnable);
	and(we[9],wr[9],ctrl_writeEnable);
	and(we[10],wr[10],ctrl_writeEnable);
	and(we[11],wr[11],ctrl_writeEnable);
	and(we[12],wr[12],ctrl_writeEnable);
	and(we[13],wr[13],ctrl_writeEnable);
	and(we[14],wr[14],ctrl_writeEnable);
	and(we[15],wr[15],ctrl_writeEnable);
	and(we[16],wr[16],ctrl_writeEnable);
	and(we[17],wr[17],ctrl_writeEnable);
	and(we[18],wr[18],ctrl_writeEnable);
	and(we[19],wr[19],ctrl_writeEnable);
	and(we[20],wr[20],ctrl_writeEnable);
	and(we[21],wr[21],ctrl_writeEnable);
	and(we[22],wr[22],ctrl_writeEnable);
	and(we[23],wr[23],ctrl_writeEnable);
	and(we[24],wr[24],ctrl_writeEnable);
	and(we[25],wr[25],ctrl_writeEnable);
	and(we[26],wr[26],ctrl_writeEnable);
	and(we[27],wr[27],ctrl_writeEnable);
	and(we[28],wr[28],ctrl_writeEnable);
	and(we[29],wr[29],ctrl_writeEnable);
	and(we[30],wr[30],ctrl_writeEnable);
	and(we[31],wr[31],ctrl_writeEnable);
	
	
	
	assign zero[0]=1'b0;
	assign zero[1]=1'b0;
	assign zero[2]=1'b0;
	assign zero[3]=1'b0;
	assign zero[4]=1'b0;
	assign zero[5]=1'b0;
	assign zero[6]=1'b0;
	assign zero[7]=1'b0;
	assign zero[8]=1'b0;
	assign zero[9]=1'b0;
	assign zero[10]=1'b0;
	assign zero[11]=1'b0;
	assign zero[12]=1'b0;
	assign zero[13]=1'b0;
	assign zero[14]=1'b0;
	assign zero[15]=1'b0;
	assign zero[16]=1'b0;
	assign zero[17]=1'b0;
	assign zero[18]=1'b0;
	assign zero[19]=1'b0;
	assign zero[20]=1'b0;
	assign zero[21]=1'b0;
	assign zero[22]=1'b0;
	assign zero[23]=1'b0;
	assign zero[24]=1'b0;
	assign zero[25]=1'b0;
	assign zero[26]=1'b0;
	assign zero[27]=1'b0;
	assign zero[28]=1'b0;
	assign zero[29]=1'b0;
	assign zero[30]=1'b0;
	assign zero[31]=1'b0;
	register r_0(.in(zero), .clk(clockInv),.we(1'b0), .reset(ctrl_reset),.out(r0));
	register r_1(.in(data_writeReg), .clk(clockInv),.we(we[1]), .reset(ctrl_reset),.out(r1));
	register r_2(.in(data_writeReg), .clk(clockInv),.we(we[2]), .reset(ctrl_reset),.out(r2));
	register r_3(.in(data_writeReg), .clk(clockInv),.we(we[3]), .reset(ctrl_reset),.out(r3));
	register r_4(.in(data_writeReg), .clk(clockInv),.we(we[4]), .reset(ctrl_reset),.out(r4));
	register r_5(.in(data_writeReg), .clk(clockInv),.we(we[5]), .reset(ctrl_reset),.out(r5));
	register r_6(.in(data_writeReg), .clk(clockInv),.we(we[6]), .reset(ctrl_reset),.out(r6));
	register r_7(.in(data_writeReg), .clk(clockInv),.we(we[7]), .reset(ctrl_reset),.out(r7));
	register r_8(.in(data_writeReg), .clk(clockInv),.we(we[8]), .reset(ctrl_reset),.out(r8));
	register r_9(.in(data_writeReg), .clk(clockInv),.we(we[9]), .reset(ctrl_reset),.out(r9));
	register r_10(.in(data_writeReg), .clk(clockInv),.we(we[10]), .reset(ctrl_reset),.out(r10));
	register r_11(.in(data_writeReg), .clk(clockInv),.we(we[11]), .reset(ctrl_reset),.out(r11));
	register r_12(.in(data_writeReg), .clk(clockInv),.we(we[12]), .reset(ctrl_reset),.out(r12));
	register r_13(.in(data_writeReg), .clk(clockInv),.we(we[13]), .reset(ctrl_reset),.out(r13));
	register r_14(.in(data_writeReg), .clk(clockInv),.we(we[14]), .reset(ctrl_reset),.out(r14));
	register r_15(.in(data_writeReg), .clk(clockInv),.we(we[15]), .reset(ctrl_reset),.out(r15));
	register r_16(.in(data_writeReg), .clk(clockInv),.we(we[16]), .reset(ctrl_reset),.out(r16));
	register r_17(.in(data_writeReg), .clk(clockInv),.we(we[17]), .reset(ctrl_reset),.out(r17));
	register r_18(.in(data_writeReg), .clk(clockInv),.we(we[18]), .reset(ctrl_reset),.out(r18));
	register r_19(.in(data_writeReg), .clk(clockInv),.we(we[19]), .reset(ctrl_reset),.out(r19));
	register r_20(.in(data_writeReg), .clk(clockInv),.we(we[20]), .reset(ctrl_reset),.out(r20));
	register r_21(.in(data_writeReg), .clk(clockInv),.we(we[21]), .reset(ctrl_reset),.out(r21));
	register r_22(.in(data_writeReg), .clk(clockInv),.we(we[22]), .reset(ctrl_reset),.out(r22));
	register r_23(.in(data_writeReg), .clk(clockInv),.we(we[23]), .reset(ctrl_reset),.out(r23));
	register r_24(.in(data_writeReg), .clk(clockInv),.we(we[24]), .reset(ctrl_reset),.out(r24));
	register r_25(.in(data_writeReg), .clk(clockInv),.we(we[25]), .reset(ctrl_reset),.out(r25));
	register r_26(.in(data_writeReg), .clk(clockInv),.we(we[26]), .reset(ctrl_reset),.out(r26));
	register r_27(.in(data_writeReg), .clk(clockInv),.we(we[27]), .reset(ctrl_reset),.out(r27));
	register r_28(.in(data_writeReg), .clk(clockInv),.we(we[28]), .reset(ctrl_reset),.out(r28));
	register r_29(.in(data_writeReg), .clk(clockInv),.we(we[29]), .reset(ctrl_reset),.out(r29));
	register r_30(.in(data_writeReg), .clk(clockInv),.we(we[30]), .reset(ctrl_reset),.out(r30));
	register r_31(.in(data_writeReg), .clk(clockInv),.we(we[31]), .reset(ctrl_reset),.out(r31));
	
	tri_state_32 ta0 (.in(r0), .oe(rA[0]), .out(data_readRegA));
	tri_state_32 ta1 (.in(r1), .oe(rA[1]), .out(data_readRegA));
	tri_state_32 ta2 (.in(r2), .oe(rA[2]), .out(data_readRegA));
	tri_state_32 ta3 (.in(r3), .oe(rA[3]), .out(data_readRegA));
	tri_state_32 ta4 (.in(r4), .oe(rA[4]), .out(data_readRegA));
	tri_state_32 ta5 (.in(r5), .oe(rA[5]), .out(data_readRegA));
	tri_state_32 ta6 (.in(r6), .oe(rA[6]), .out(data_readRegA));
	tri_state_32 ta7 (.in(r7), .oe(rA[7]), .out(data_readRegA));
	tri_state_32 ta8 (.in(r8), .oe(rA[8]), .out(data_readRegA));
	tri_state_32 ta9 (.in(r9), .oe(rA[9]), .out(data_readRegA));
	tri_state_32 ta10 (.in(r10), .oe(rA[10]), .out(data_readRegA));
	tri_state_32 ta11 (.in(r11), .oe(rA[11]), .out(data_readRegA));
	tri_state_32 ta12 (.in(r12), .oe(rA[12]), .out(data_readRegA));
	tri_state_32 ta13 (.in(r13), .oe(rA[13]), .out(data_readRegA));
	tri_state_32 ta14 (.in(r14), .oe(rA[14]), .out(data_readRegA));
	tri_state_32 ta15 (.in(r15), .oe(rA[15]), .out(data_readRegA));
	tri_state_32 ta16 (.in(r16), .oe(rA[16]), .out(data_readRegA));
	tri_state_32 ta17 (.in(r17), .oe(rA[17]), .out(data_readRegA));
	tri_state_32 ta18 (.in(r18), .oe(rA[18]), .out(data_readRegA));
	tri_state_32 ta19 (.in(r19), .oe(rA[19]), .out(data_readRegA));
	tri_state_32 ta20 (.in(r20), .oe(rA[20]), .out(data_readRegA));
	tri_state_32 ta21 (.in(r21), .oe(rA[21]), .out(data_readRegA));
	tri_state_32 ta22 (.in(r22), .oe(rA[22]), .out(data_readRegA));
	tri_state_32 ta23 (.in(r23), .oe(rA[23]), .out(data_readRegA));
	tri_state_32 ta24 (.in(r24), .oe(rA[24]), .out(data_readRegA));
	tri_state_32 ta25 (.in(r25), .oe(rA[25]), .out(data_readRegA));
	tri_state_32 ta26 (.in(r26), .oe(rA[26]), .out(data_readRegA));
	tri_state_32 ta27 (.in(r27), .oe(rA[27]), .out(data_readRegA));
	tri_state_32 ta28 (.in(r28), .oe(rA[28]), .out(data_readRegA));
	tri_state_32 ta29 (.in(r29), .oe(rA[29]), .out(data_readRegA));
	tri_state_32 ta30 (.in(r30), .oe(rA[30]), .out(data_readRegA));
	tri_state_32 ta31 (.in(r31), .oe(rA[31]), .out(data_readRegA));
	
	tri_state_32 tb0 (.in(r0), .oe(rB[0]), .out(data_readRegB));
	tri_state_32 tb1 (.in(r1), .oe(rB[1]), .out(data_readRegB));
	tri_state_32 tb2 (.in(r2), .oe(rB[2]), .out(data_readRegB));
	tri_state_32 tb3 (.in(r3), .oe(rB[3]), .out(data_readRegB));
	tri_state_32 tb4 (.in(r4), .oe(rB[4]), .out(data_readRegB));
	tri_state_32 tb5 (.in(r5), .oe(rB[5]), .out(data_readRegB));
	tri_state_32 tb6 (.in(r6), .oe(rB[6]), .out(data_readRegB));
	tri_state_32 tb7 (.in(r7), .oe(rB[7]), .out(data_readRegB));
	tri_state_32 tb8 (.in(r8), .oe(rB[8]), .out(data_readRegB));
	tri_state_32 tb9 (.in(r9), .oe(rB[9]), .out(data_readRegB));
	tri_state_32 tb10 (.in(r10), .oe(rB[10]), .out(data_readRegB));
	tri_state_32 tb11 (.in(r11), .oe(rB[11]), .out(data_readRegB));
	tri_state_32 tb12 (.in(r12), .oe(rB[12]), .out(data_readRegB));
	tri_state_32 tb13 (.in(r13), .oe(rB[13]), .out(data_readRegB));
	tri_state_32 tb14 (.in(r14), .oe(rB[14]), .out(data_readRegB));
	tri_state_32 tb15 (.in(r15), .oe(rB[15]), .out(data_readRegB));
	tri_state_32 tb16 (.in(r16), .oe(rB[16]), .out(data_readRegB));
	tri_state_32 tb17 (.in(r17), .oe(rB[17]), .out(data_readRegB));
	tri_state_32 tb18 (.in(r18), .oe(rB[18]), .out(data_readRegB));
	tri_state_32 tb19 (.in(r19), .oe(rB[19]), .out(data_readRegB));
	tri_state_32 tb20 (.in(r20), .oe(rB[20]), .out(data_readRegB));
	tri_state_32 tb21 (.in(r21), .oe(rB[21]), .out(data_readRegB));
	tri_state_32 tb22 (.in(r22), .oe(rB[22]), .out(data_readRegB));
	tri_state_32 tb23 (.in(r23), .oe(rB[23]), .out(data_readRegB));
	tri_state_32 tb24 (.in(r24), .oe(rB[24]), .out(data_readRegB));
	tri_state_32 tb25 (.in(r25), .oe(rB[25]), .out(data_readRegB));
	tri_state_32 tb26 (.in(r26), .oe(rB[26]), .out(data_readRegB));
	tri_state_32 tb27 (.in(r27), .oe(rB[27]), .out(data_readRegB));
	tri_state_32 tb28 (.in(r28), .oe(rB[28]), .out(data_readRegB));
	tri_state_32 tb29 (.in(r29), .oe(rB[29]), .out(data_readRegB));
	tri_state_32 tb30 (.in(r30), .oe(rB[30]), .out(data_readRegB));
	tri_state_32 tb31 (.in(r31), .oe(rB[31]), .out(data_readRegB));
	
	
/*	
assign debugR1=r1;
assign debugR2=r2;
assign debugR3=r3;
assign debugR4=r4;
assign debugR5=r5;
assign debugR6=r6;
assign debugR7=r7;
assign debugR8=r8;
assign debugR9=r9;
assign debugR10=r10;
assign debugR11=r11;
assign debugR12=r12;
assign debugR13=r13;
assign debugR14=r14;
assign debugR15=r15;
assign debugR16=r16;
assign debugR17=r17;
assign debugR18=r18;
assign debugR19=r19;
assign debugR20=r20;
assign debugR21=r21;
assign debugR22=r22;
assign debugR23=r23;
assign debugR24=r24;
assign debugR25=r25;
assign debugR26=r26;
assign debugR27=r27;
assign debugR28=r28;
assign debugR29=r29;
assign debugR30=r30;
assign debugR31=r31;
	*/
//	mux_32 ma(.select(ctrl_readRegA), .in0(r0), .in1(r1), .in2(r2), .in3(r3),.in4(r4),.in5(r5),.in6(r6),.in7(r7),.in8(r8),.in9(r9),.in10(r10),.in11(r11),.in12(r12),.in13(r13),.in14(r14),.in15(r15),.in16(r16),.in17(r17),.in18(r18),.in19(r19),.in20(r20),.in21(r21),.in22(r22),.in23(r23),.in24(r24),.in25(r25),.in26(r26),.in27(r27),.in28(r28),.in29(r29),.in30(r30),.in31(r31),.out(data_readRegA));
//	mux_32 mb(.select(ctrl_readRegB), .in0(r0), .in1(r1), .in2(r2), .in3(r3),.in4(r4),.in5(r5),.in6(r6),.in7(r7),.in8(r8),.in9(r9),.in10(r10),.in11(r11),.in12(r12),.in13(r13),.in14(r14),.in15(r15),.in16(r16),.in17(r17),.in18(r18),.in19(r19),.in20(r20),.in21(r21),.in22(r22),.in23(r23),.in24(r24),.in25(r25),.in26(r26),.in27(r27),.in28(r28),.in29(r29),.in30(r30),.in31(r31),.out(data_readRegB));

endmodule
