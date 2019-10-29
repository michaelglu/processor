module m_pipe_reg (dataO,dataD,we, clk,reset,data_outO,data_outD,instruction_in,instruction_out);

input clk,we,reset;
input[31:0]dataO,dataD,instruction_in;
output[31:0]data_outO,data_outD,instruction_out;

register dataDreg (.in(dataD), .clk(clk),.we(we), .reset(reset),.out(data_outD));
register data (.in(dataO), .clk(clk),.we(we), .reset(reset),.out(data_outO));
register instruction (.in(instruction_in), .clk(clk),.we(we), .reset(reset),.out(instruction_out));


endmodule