module full_adder(in1,in2,cin,cout,sum);
input in1, in2, cin;
output sum, cout;
wire w1,w2,w3;

and(w1,in1,in2);
and(w2, w3, cin);
or(cout, w1,w2);
xor(w3,in1,in2);
xor(sum, w3, cin);

endmodule