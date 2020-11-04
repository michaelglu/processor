module register_1(in, clk,we, reset,out);

input in;
input clk,we,reset;
output out;

d_flip_flop d0(.d(in), .aclr(reset),.clk(clk),.q(out),.ena(we));

endmodule