module f_pipe_reg (data_in, clk, pc_in, we ,reset,pc_out,instruction_out);

input clk,we,reset;
input[31:0]data_in, pc_in;
output[31:0]pc_out,instruction_out;

register pc (.in(pc_in), .clk(clk),.we(we), .reset(reset),.out(pc_out));
register data (.in(data_in), .clk(clk),.we(we), .reset(reset),.out(instruction_out));




endmodule