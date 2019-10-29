module adder_cla_1bit(in1,in2,cin,sum);
input in1, in2, cin;
output sum;
wire w1,w2;

xor(w1,in1,in2);
xor(sum,in1,in2,cin);

endmodule