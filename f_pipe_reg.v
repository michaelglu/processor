module f_pipe_reg (data_in_top,data_in_bot, clk, pc_in_top,pc_in_bot, we ,reset,pc_out_top,pc_out_bot,instruction_out_top,instruction_out_bot);

input clk,we,reset;
input[31:0]data_in_top,data_in_bot, pc_in_top,pc_in_bot;
output[31:0]pc_out_top,pc_out_bot,instruction_out_top,instruction_out_bot;

register pc_top (.in(pc_in_top), .clk(clk),.we(we), .reset(reset),.out(pc_out_top));
register data_top (.in(data_in_top), .clk(clk),.we(we), .reset(reset),.out(instruction_out_top));

register pc_bot (.in(pc_in_bot), .clk(clk),.we(we), .reset(reset),.out(pc_out_bot));
register data_bot (.in(data_in_bot), .clk(clk),.we(we), .reset(reset),.out(instruction_out_bot));




endmodule