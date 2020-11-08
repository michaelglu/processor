module mux2to1_3_bit(select, in0, in1, out);
	input select;
	input [2:0] in0, in1;
	output [2:0] out;
	assign out = select ? in1 : in0;
endmodule