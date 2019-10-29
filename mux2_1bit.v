module mux2_1bit(select, in0, in1, out);
	input select,in0, in1;
	output out;
	assign out = select ? in1 : in0;
endmodule