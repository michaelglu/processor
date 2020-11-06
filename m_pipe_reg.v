module m_pipe_reg (dataO_top,dataD_top,we, clk,reset,data_outO_top,data_outD_top,instruction_in_top,instruction_out_top,ovf_in_top,ovf_out_top,
						 dataO_bot,dataD_bot,              data_outO_bot,data_outD_bot,instruction_in_bot,instruction_out_bot,ovf_in_bot,ovf_out_bot
);

input clk,we,reset,ovf_in_top,ovf_in_bot;
input[31:0]dataO_top,dataD_top,instruction_in_top;
output[31:0]data_outO_top,data_outD_top,instruction_out_top;
output ovf_out_top;

d_flip_flop ovf_flip_flop_top (.q(ovf_out_top), .d(ovf_in_top), .clk(clk), .ena(we), .aclr(reset));
register dataD_topreg_top (.in(dataD_top), .clk(clk),.we(we), .reset(reset),.out(data_outD_top));
register data_top(.in(dataO_top), .clk(clk),.we(we), .reset(reset),.out(data_outO_top));
register instruction_top (.in(instruction_in_top), .clk(clk),.we(we), .reset(reset),.out(instruction_out_top));

input[31:0]dataO_bot,dataD_bot,instruction_in_bot;
output[31:0]data_outO_bot,data_outD_bot,instruction_out_bot;
output ovf_out_bot;

d_flip_flop ovf_flip_flop_bot (.q(ovf_out_bot), .d(ovf_in_bot), .clk(clk), .ena(we), .aclr(reset));
register dataD_botreg_bot (.in(dataD_bot), .clk(clk),.we(we), .reset(reset),.out(data_outD_bot));
register data_bot(.in(dataO_bot), .clk(clk),.we(we), .reset(reset),.out(data_outO_bot));
register instruction_bot (.in(instruction_in_bot), .clk(clk),.we(we), .reset(reset),.out(instruction_out_bot));



endmodule