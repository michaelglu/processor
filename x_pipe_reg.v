module x_pipe_reg (dataA,dataB,we, clk,reset,data_outA,data_outB,instruction_in,instruction_out,ovf_in,ovf_out);

input clk,we,reset,ovf_in;
input[31:0]dataA,dataB,instruction_in;
output[31:0]data_outA,data_outB,instruction_out;
output ovf_out;

d_flip_flop ovf_flip_flop (.q(ovf_out), .d(ovf_in), .clk(clk), .ena(we), .aclr(reset));
register regA (.in(dataA), .clk(clk),.we(we), .reset(reset),.out(data_outA));
register regB (.in(dataB), .clk(clk),.we(we), .reset(reset),.out(data_outB));
register instruction (.in(instruction_in), .clk(clk),.we(we), .reset(reset),.out(instruction_out));

endmodule