module mux_16(select, in0, in1, in2, in3,in4,in5,in6,in7,in8, in9, in10, in11,in12,in13,in14,in15, out);
input [3:0] select;
input [31:0] in0, in1, in2, in3,in4,in5,in6,in7,in8, in9, in10, in11,in12,in13,in14,in15;
output [31:0] out;
wire [31:0] w1, w2;
mux_8 first_top(.select(select[2:0]), .in0(in0), .in1(in1),.in2(in2), .in3(in3),.in4(in4), .in5(in5),.in6(in6), .in7(in7), .out(w1));
mux_8 first_bottom(.select(select[2:0]), .in0(in8), .in1(in9),.in2(in10), .in3(in11),.in4(in12), .in5(in13),.in6(in14), .in7(in15), .out(w2));
mux2to1 second(.select(select[3]), .in0(w1), .in1(w2), .out(out));
endmodule