module mux_4_1_bit(select, in0, in1, in2, in3, out);
input [1:0] select;
input in0, in1, in2, in3;
output out;
wire w1, w2;
mux2_1bit first_top(.select(select[0]), .in0(in0), .in1(in1), .out(w1));
mux2_1bit first_bottom(.select(select[0]), .in0(in2), .in1(in3), .out(w2));
mux2_1bit second(.select(select[1]), .in0(w1), .in1(w2), .out(out));
endmodule
