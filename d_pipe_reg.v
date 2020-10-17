module d_pipe_reg (data_inA,data_inB,we, clk, pc_in, ,reset,data_outA,data_outB,pc_out,instruction_out,instruction_in,branchPredictedTaken_in,branchPredictedTaken_out);

input clk,we,reset,branchPredictedTaken_in;
input[31:0]data_inA,data_inB, pc_in,instruction_in;
output[31:0]data_outA,data_outB,pc_out,instruction_out;
output branchPredictedTaken_out;

register pc (.in(pc_in), .clk(clk),.we(we), .reset(reset),.out(pc_out));
register dataA (.in(data_inA), .clk(clk),.we(we), .reset(reset),.out(data_outA));
register dataB (.in(data_inB), .clk(clk),.we(we), .reset(reset),.out(data_outB));
register instruction (.in(instruction_in), .clk(clk),.we(we), .reset(reset),.out(instruction_out));
d_flip_flop branchPredictionDFF(.d(branchPredictedTaken_in), .aclr(reset),.clk(clk),.q(branchPredictedTaken_out),.ena(we));



endmodule