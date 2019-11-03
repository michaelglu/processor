module m_pipe_reg (dataO,dataD,we, clk,reset,data_outO,data_outD,instruction_in,instruction_out,ovf_in,ovf_out);

input clk,we,reset,ovf_in;
input[31:0]dataO,dataD,instruction_in;
output[31:0]data_outO,data_outD,instruction_out;
output ovf_out;

d_flip_flop ovf_flip_flop (.q(ovf_out), .d(ovf_in), .clk(clk), .ena(we), .aclr(reset));
register dataDreg (.in(dataD), .clk(clk),.we(we), .reset(reset),.out(data_outD));
register data (.in(dataO), .clk(clk),.we(we), .reset(reset),.out(data_outO));
register instruction (.in(instruction_in), .clk(clk),.we(we), .reset(reset),.out(instruction_out));


endmodule