module multdivLatch (in,we,done,clock,out,reset,inProgress);
input[31:0]in;
input we,clock,reset,done;
output [31:0]out;
output inProgress;

	register instruction (.in(in), .clk(clock),.we(we), .reset(reset),.out(out));
	d_flip_flop ongoing (.q(inProgress), .d(1'b1), .clk(clock), .ena(we), .aclr(done));

endmodule