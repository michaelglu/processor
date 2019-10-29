module left_shifter(in, shift_amount,out);

input [31:0]in;
input [4:0]shift_amount;
output[31:0] out;


wire[31:0] wout16, win8,wout8,win4,wout4,win2,wout2,win1,wout1;

left_shift_16bit l16(.in(in),.out(wout16));
mux2to1 m16(.select(shift_amount[4]),.in1(wout16),.in0(in),.out(win8));

left_shift_8bit l8(.in(win8),.out(wout8));
mux2to1 m8(.select(shift_amount[3]),.in1(wout8),.in0(win8),.out(win4));

left_shift_4bit l4(.in(win4),.out(wout4));
mux2to1 m4(.select(shift_amount[2]),.in1(wout4),.in0(win4),.out(win2));

left_shift_2bit l2(.in(win2),.out(wout2));
mux2to1 m2(.select(shift_amount[1]),.in1(wout2),.in0(win2),.out(win1));

left_shift_1bit l1(.in(win1),.out(wout1));
mux2to1 m1(.select(shift_amount[0]),.in1(wout1),.in0(win1),.out(out));

endmodule