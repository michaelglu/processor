module tri_state_32 (in, oe, out);
input [31:0]in;
input oe;
output[31:0]out;

//tri_state_buffer t0(.in(in[0]), .oe(oe), .out(out[0]));
//tri_state_buffer t1(.in(in[1]), .oe(oe), .out(out[1]));
//tri_state_buffer t2(.in(in[2]), .oe(oe), .out(out[2]));
//tri_state_buffer t3(.in(in[3]), .oe(oe), .out(out[3]));
//tri_state_buffer t4(.in(in[4]), .oe(oe), .out(out[4]));
//tri_state_buffer t5(.in(in[5]), .oe(oe), .out(out[5]));
//tri_state_buffer t6(.in(in[6]), .oe(oe), .out(out[6]));
//tri_state_buffer t7(.in(in[7]), .oe(oe), .out(out[7]));
//tri_state_buffer t8(.in(in[8]), .oe(oe), .out(out[8]));
//tri_state_buffer t9(.in(in[9]), .oe(oe), .out(out[9]));
//tri_state_buffer t10(.in(in[10]), .oe(oe), .out(out[10]));
//tri_state_buffer t11(.in(in[11]), .oe(oe), .out(out[11]));
//tri_state_buffer t12(.in(in[12]), .oe(oe), .out(out[12]));
//tri_state_buffer t13(.in(in[13]), .oe(oe), .out(out[13]));
//tri_state_buffer t14(.in(in[14]), .oe(oe), .out(out[14]));
//tri_state_buffer t15(.in(in[15]), .oe(oe), .out(out[15]));
//tri_state_buffer t16(.in(in[16]), .oe(oe), .out(out[16]));
//tri_state_buffer t17(.in(in[17]), .oe(oe), .out(out[17]));
//tri_state_buffer t18(.in(in[18]), .oe(oe), .out(out[18]));
//tri_state_buffer t19(.in(in[19]), .oe(oe), .out(out[19]));
//tri_state_buffer t20(.in(in[20]), .oe(oe), .out(out[20]));
//tri_state_buffer t21(.in(in[21]), .oe(oe), .out(out[21]));
//tri_state_buffer t22(.in(in[22]), .oe(oe), .out(out[22]));
//tri_state_buffer t23(.in(in[23]), .oe(oe), .out(out[23]));
//tri_state_buffer t24(.in(in[24]), .oe(oe), .out(out[24]));
//tri_state_buffer t25(.in(in[25]), .oe(oe), .out(out[25]));
//tri_state_buffer t26(.in(in[26]), .oe(oe), .out(out[26]));
//tri_state_buffer t27(.in(in[27]), .oe(oe), .out(out[27]));
//tri_state_buffer t28(.in(in[28]), .oe(oe), .out(out[28]));
//tri_state_buffer t29(.in(in[29]), .oe(oe), .out(out[29]));
//tri_state_buffer t30(.in(in[30]), .oe(oe), .out(out[30]));
//tri_state_buffer t31(.in(in[31]), .oe(oe), .out(out[31]));

assign out = oe ? in :{32{1'bz}} ;

endmodule