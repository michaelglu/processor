module alu (data_operandA,data_operandB,ctrl_ALUopcode,ctrl_shiftamt,data_result,isNotEqual,isLessThan,overflow);

input[31:0]data_operandA,data_operandB;
input[4:0] ctrl_ALUopcode,ctrl_shiftamt;

output [31:0] data_result;
output isNotEqual,isLessThan,overflow;

wire [31:0] add_result, subtract_result, and_result, or_result,not_intermideate, shiftR_result, shiftL_result, xor_result;
wire ovfAdd, ovfSub;

adder_cla_32_bit adder(.in1(data_operandA),.in2(data_operandB),.cin(1'b0),.sum(add_result),.overflow(ovfAdd));

bitwise_not inverter (.in(data_operandB),.out(not_intermideate));
adder_cla_32_bit subtractor(.in1(data_operandA),.in2(not_intermideate),.cin(1'b1),.sum(subtract_result),.overflow(ovfSub));

bitwise_and bitwise_and_gate (.in1(data_operandA),.in2(data_operandB),.out(and_result));

bitwise_or bitwise_or_gate (.in1(data_operandA),.in2(data_operandB),.out(or_result));

left_shifter shiftLeft (.in(data_operandA), .shift_amount(ctrl_shiftamt),.out(shiftL_result));

right_shifter shiftRight (.in(data_operandA), .shift_amount(ctrl_shiftamt),.out(shiftR_result));

mux_8 myMux(.select(ctrl_ALUopcode[2:0]), .in0(add_result), .in1(subtract_result), .in2(and_result), .in3(or_result),.in4(shiftL_result),.in5(shiftR_result),.in6(data_operandA),.in7(data_operandB), .out(data_result));


mux2_1bit ovfmux(.select(ctrl_ALUopcode[0]), .in0(ovfAdd), .in1(ovfSub), .out(overflow));
xor(isLessThan,subtract_result[31],ovfSub);

xnor(xor_result[0],data_operandA[0],data_operandB[0]);
xnor(xor_result[1],data_operandA[1],data_operandB[1]);
xnor(xor_result[2],data_operandA[2],data_operandB[2]);
xnor(xor_result[3],data_operandA[3],data_operandB[3]);
xnor(xor_result[4],data_operandA[4],data_operandB[4]);
xnor(xor_result[5],data_operandA[5],data_operandB[5]);
xnor(xor_result[6],data_operandA[6],data_operandB[6]);
xnor(xor_result[7],data_operandA[7],data_operandB[7]);
xnor(xor_result[8],data_operandA[8],data_operandB[8]);
xnor(xor_result[9],data_operandA[9],data_operandB[9]);
xnor(xor_result[10],data_operandA[10],data_operandB[10]);
xnor(xor_result[11],data_operandA[11],data_operandB[11]);
xnor(xor_result[12],data_operandA[12],data_operandB[12]);
xnor(xor_result[13],data_operandA[13],data_operandB[13]);
xnor(xor_result[14],data_operandA[14],data_operandB[14]);
xnor(xor_result[15],data_operandA[15],data_operandB[15]);
xnor(xor_result[16],data_operandA[16],data_operandB[16]);
xnor(xor_result[17],data_operandA[17],data_operandB[17]);
xnor(xor_result[18],data_operandA[18],data_operandB[18]);
xnor(xor_result[19],data_operandA[19],data_operandB[19]);
xnor(xor_result[20],data_operandA[20],data_operandB[20]);
xnor(xor_result[21],data_operandA[21],data_operandB[21]);
xnor(xor_result[22],data_operandA[22],data_operandB[22]);
xnor(xor_result[23],data_operandA[23],data_operandB[23]);
xnor(xor_result[24],data_operandA[24],data_operandB[24]);
xnor(xor_result[25],data_operandA[25],data_operandB[25]);
xnor(xor_result[26],data_operandA[26],data_operandB[26]);
xnor(xor_result[27],data_operandA[27],data_operandB[27]);
xnor(xor_result[28],data_operandA[28],data_operandB[28]);
xnor(xor_result[29],data_operandA[29],data_operandB[29]);
xnor(xor_result[30],data_operandA[30],data_operandB[30]);
xnor(xor_result[31],data_operandA[31],data_operandB[31]);

wire isEqual;
and(isEqual, xor_result[0],xor_result[1],xor_result[2],xor_result[3],xor_result[4],xor_result[5],xor_result[6],xor_result[7],xor_result[8],xor_result[9],xor_result[10],xor_result[11],xor_result[12],xor_result[13],xor_result[14],xor_result[15],xor_result[16],xor_result[17],xor_result[18],xor_result[19],xor_result[20],xor_result[21],xor_result[22],xor_result[23],xor_result[24],xor_result[25],xor_result[26],xor_result[27],xor_result[28],xor_result[29],xor_result[30],xor_result[31]);

not(isNotEqual, isEqual);

endmodule