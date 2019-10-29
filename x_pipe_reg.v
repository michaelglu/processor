module x_pipe_reg (dataA,dataB,we, clk,reset,data_outA,data_outB,instruction_in,instruction_out);

input clk,we,reset;
input[31:0]dataA,dataB,instruction_in;
output[31:0]data_outA,data_outB,instruction_out;

register regA (.in(dataA), .clk(clk),.we(we), .reset(reset),.out(data_outA));
register regB (.in(dataB), .clk(clk),.we(we), .reset(reset),.out(data_outB));
register instruction (.in(instruction_in), .clk(clk),.we(we), .reset(reset),.out(instruction_out));

endmodule