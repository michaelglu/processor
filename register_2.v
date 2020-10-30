module register_2 (in, clk,we, reset,out);

input [1:0]in;
input clk,we,reset;
output[1:0]out;

d_flip_flop d0(.d(in[0]), .aclr(reset),.clk(clk),.q(out[0]),.ena(we));
d_flip_flop d1(.d(in[1]), .aclr(reset),.clk(clk),.q(out[1]),.ena(we));

endmodule