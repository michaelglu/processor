module predictor_2_bit_adder(taken, in0, in1, out);
input taken;
input [1:0] in0, in1;
output [1:0] out;
wire [1:0] w1, xnor3out, xnor4out, mux1out;
wire x1,x2,x3,x4,adder1cout, adder2cout, adder1sum, adder2sum;
wire and1out, and2out, and3out, and4out; 

xor xor1(x1, taken, in0[0]);
xor xor2(x2, taken, in0[1]);

full_adder adder1(in1[1],x2,adder2cout,adder1cout,adder1sum);
full_adder adder2(in1[0],x1,taken,adder2cout,adder2sum);

assign w1[0] = adder2sum;
assign w1[1] = adder1sum;

mux2to1_2_bit mux1(and3out, w1, 2'b00, mux1out);
mux2to1_2_bit mux2(and4out, mux1out, 2'b11, out);

xnor xnor31(xnor3out[0], in1[0], 1'b0);
xnor xnor32(xnor3out[1], in1[1], 1'b0);

xnor xnor41(xnor4out[0], in1[0], 1'b1);
xnor xnor42(xnor4out[1], in1[1], 1'b1);

and and1(and1out, xnor3out[0], xnor3out[1]);
and and2(and2out, xnor4out[0], xnor4out[1]);
and and3(and3out, taken, and1out);
and and4(and4out, ~taken, and2out);

endmodule
