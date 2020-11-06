module x_pipe_reg (dataA_top,dataB_top,we, clk,reset,data_outA_top,data_outB_top,instruction_in_top,instruction_out_top,ovf_in_top,ovf_out_top,
						 dataA_bot,dataB_bot,              data_outA_bot,data_outB_bot,instruction_in_bot,instruction_out_bot,ovf_in_bot,ovf_out_bot
	);

input clk,we,reset,ovf_in_top,ovf_in_bot;
input[31:0]dataA_top,dataB_top,instruction_in_top;
output[31:0]data_outA_top,data_outB_top,instruction_out_top;
output ovf_out_top;
input[31:0]dataA_bot,dataB_bot,instruction_in_bot;
output[31:0]data_outA_bot,data_outB_bot,instruction_out_bot;
output ovf_out_bot;

d_flip_flop ovf_flip_flop_top (.q(ovf_out_top), .d(ovf_in_top), .clk(clk), .ena(we), .aclr(reset));
register regA_top (.in(dataA_top), .clk(clk),.we(we), .reset(reset),.out(data_outA_top));
register regB_top (.in(dataB_top), .clk(clk),.we(we), .reset(reset),.out(data_outB_top));
register instruction_top (.in(instruction_in_top), .clk(clk),.we(we), .reset(reset),.out(instruction_out_top));
//bot
d_flip_flop ovf_flip_flop_bot (.q(ovf_out_bot), .d(ovf_in_bot), .clk(clk), .ena(we), .aclr(reset));
register regA_bot (.in(dataA_bot), .clk(clk),.we(we), .reset(reset),.out(data_outA_bot));
register regB_bot (.in(dataB_bot), .clk(clk),.we(we), .reset(reset),.out(data_outB_bot));
register instruction_bot (.in(instruction_in_bot), .clk(clk),.we(we), .reset(reset),.out(instruction_out_bot));

endmodule