module register (in, clk,we, reset,out);

input [31:0]in;
input clk,we,reset;
output[31:0]out;

d_flip_flop d0(.d(in[0]), .aclr(reset),.clk(clk),.q(out[0]),.ena(we));
d_flip_flop d1(.d(in[1]), .aclr(reset),.clk(clk),.q(out[1]),.ena(we));
d_flip_flop d2(.d(in[2]), .aclr(reset),.clk(clk),.q(out[2]),.ena(we));
d_flip_flop d3(.d(in[3]), .aclr(reset),.clk(clk),.q(out[3]),.ena(we));
d_flip_flop d4(.d(in[4]), .aclr(reset),.clk(clk),.q(out[4]),.ena(we));
d_flip_flop d5(.d(in[5]), .aclr(reset),.clk(clk),.q(out[5]),.ena(we));
d_flip_flop d6(.d(in[6]), .aclr(reset),.clk(clk),.q(out[6]),.ena(we));
d_flip_flop d7(.d(in[7]), .aclr(reset),.clk(clk),.q(out[7]),.ena(we));
d_flip_flop d8(.d(in[8]), .aclr(reset),.clk(clk),.q(out[8]),.ena(we));
d_flip_flop d9(.d(in[9]), .aclr(reset),.clk(clk),.q(out[9]),.ena(we));
d_flip_flop d10(.d(in[10]), .aclr(reset),.clk(clk),.q(out[10]),.ena(we));
d_flip_flop d11(.d(in[11]), .aclr(reset),.clk(clk),.q(out[11]),.ena(we));
d_flip_flop d12(.d(in[12]), .aclr(reset),.clk(clk),.q(out[12]),.ena(we));
d_flip_flop d13(.d(in[13]), .aclr(reset),.clk(clk),.q(out[13]),.ena(we));
d_flip_flop d14(.d(in[14]), .aclr(reset),.clk(clk),.q(out[14]),.ena(we));
d_flip_flop d15(.d(in[15]), .aclr(reset),.clk(clk),.q(out[15]),.ena(we));
d_flip_flop d16(.d(in[16]), .aclr(reset),.clk(clk),.q(out[16]),.ena(we));
d_flip_flop d17(.d(in[17]), .aclr(reset),.clk(clk),.q(out[17]),.ena(we));
d_flip_flop d18(.d(in[18]), .aclr(reset),.clk(clk),.q(out[18]),.ena(we));
d_flip_flop d19(.d(in[19]), .aclr(reset),.clk(clk),.q(out[19]),.ena(we));
d_flip_flop d20(.d(in[20]), .aclr(reset),.clk(clk),.q(out[20]),.ena(we));
d_flip_flop d21(.d(in[21]), .aclr(reset),.clk(clk),.q(out[21]),.ena(we));
d_flip_flop d22(.d(in[22]), .aclr(reset),.clk(clk),.q(out[22]),.ena(we));
d_flip_flop d23(.d(in[23]), .aclr(reset),.clk(clk),.q(out[23]),.ena(we));
d_flip_flop d24(.d(in[24]), .aclr(reset),.clk(clk),.q(out[24]),.ena(we));
d_flip_flop d25(.d(in[25]), .aclr(reset),.clk(clk),.q(out[25]),.ena(we));
d_flip_flop d26(.d(in[26]), .aclr(reset),.clk(clk),.q(out[26]),.ena(we));
d_flip_flop d27(.d(in[27]), .aclr(reset),.clk(clk),.q(out[27]),.ena(we));
d_flip_flop d28(.d(in[28]), .aclr(reset),.clk(clk),.q(out[28]),.ena(we));
d_flip_flop d29(.d(in[29]), .aclr(reset),.clk(clk),.q(out[29]),.ena(we));
d_flip_flop d30(.d(in[30]), .aclr(reset),.clk(clk),.q(out[30]),.ena(we));
d_flip_flop d31(.d(in[31]), .aclr(reset),.clk(clk),.q(out[31]),.ena(we));

endmodule