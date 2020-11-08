module d_pipe_reg (data_inA_top,data_inB_top,we, clk, pc_in_top, ,reset,data_outA_top,data_outB_top,pc_out_top,instruction_out_top,instruction_in_top,branchPredictedTaken_in,branchPredictedTaken_out,
						 data_inA_bot,data_inB_bot,         pc_in_bot,       ,data_outA_bot,data_outB_bot,pc_out_bot,instruction_out_bot,instruction_in_bot
);

input clk,we,reset,branchPredictedTaken_in;
input[31:0]data_inA_top,data_inB_top, pc_in_top,instruction_in_top;
output[31:0]data_outA_top,data_outB_top,pc_out_top,instruction_out_top;
//bot
input[31:0]data_inA_bot,data_inB_bot, pc_in_bot,instruction_in_bot;
output[31:0]data_outA_bot,data_outB_bot,pc_out_bot,instruction_out_bot;

output branchPredictedTaken_out;

register pc (.in(pc_in_top), .clk(clk),.we(we), .reset(reset),.out(pc_out_top));
register dataA (.in(data_inA_top), .clk(clk),.we(we), .reset(reset),.out(data_outA_top));
register dataB (.in(data_inB_top), .clk(clk),.we(we), .reset(reset),.out(data_outB_top));
register instruction (.in(instruction_in_top), .clk(clk),.we(we), .reset(reset),.out(instruction_out_top));
//bot
register pc_bot (.in(pc_in_bot), .clk(clk),.we(we), .reset(reset),.out(pc_out_bot));
register dataA_bot (.in(data_inA_bot), .clk(clk),.we(we), .reset(reset),.out(data_outA_bot));
register dataB_bot (.in(data_inB_bot), .clk(clk),.we(we), .reset(reset),.out(data_outB_bot));
register instruction_bot (.in(instruction_in_bot), .clk(clk),.we(we), .reset(reset),.out(instruction_out_bot));





d_flip_flop branchPredictionDFF(.d(branchPredictedTaken_in), .aclr(reset),.clk(clk),.q(branchPredictedTaken_out),.ena(we));



endmodule