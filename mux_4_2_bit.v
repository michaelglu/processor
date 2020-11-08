module mux_4_2_bit(select, in0, in1, in2, in3, out);
input [1:0] select;
input [1:0] in0, in1, in2, in3;
output [1:0] out;
wire [1:0] w1, w2;
mux2to1_2_bit first_top(.select(select[0]), .in0(in0), .in1(in1), .out(w1));
mux2to1_2_bit first_bottom(.select(select[0]), .in0(in2), .in1(in3), .out(w2));
mux2to1_2_bit second(.select(select[1]), .in0(w1), .in1(w2), .out(out));
endmodule
