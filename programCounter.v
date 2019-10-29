module programCounter(clk,out,overwrite,overwrite_in,reset,we);
input clk,overwrite,reset,we;
input [31:0]overwrite_in;
output [31:0] out;

wire [31:0]regIn,currentCycle,nextCycle,zeroes,regInFinal;
wire PC_OVF;

assign zeroes={32{1'b0}};

adder_cla_32_bit myAdder(.in1(currentCycle),.in2(zeroes),.cin(1'b1),.sum(nextCycle),.overflow(PC_OVF));
assign regIn= overwrite ? overwrite_in : nextCycle;
assign regInFinal=hasBeenInitialized?regIn:{32{1'b0}};

register pc (.in(regInFinal), .clk(clk),.we(we), .reset(reset),.out(out));
assign currentCycle=out;

wire hasBeenInitialized;
d_flip_flop init(.q(hasBeenInitialized), .d(1'b1), .clk(clk), .ena(we), .aclr(reset));


endmodule