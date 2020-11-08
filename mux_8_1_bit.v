module mux_8_1_bit(select, in0, in1, in2, in3,in4,in5,in6,in7, out);
input [2:0] select;
input in0, in1, in2, in3, in4,in5,in6,in7;
output out;
wire w1, w2;
mux_4_1_bit first_top(.select(select[1:0]), .in0(in0), .in1(in1),.in2(in2), .in3(in3), .out(w1));
mux_4_1_bit first_bottom(.select(select[1:0]), .in0(in4), .in1(in5),.in2(in6), .in3(in7), .out(w2));
mux2_1bit second(.select(select[2]), .in0(w1), .in1(w2), .out(out));
endmodule