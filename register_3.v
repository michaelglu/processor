module register_3 (in, clk,we, reset,out);

input [2:0]in;
input clk,we,reset;
output[2:0]out;

d_flip_flop d0(.d(in[0]), .aclr(reset),.clk(clk),.q(out[0]),.ena(we));
d_flip_flop d1(.d(in[1]), .aclr(reset),.clk(clk),.q(out[1]),.ena(we));
d_flip_flop d2(.d(in[2]), .aclr(reset),.clk(clk),.q(out[2]),.ena(we));

endmodule