module adder_cla_8_bit_overflow(in1, in2,cin,sum,g,p,overflow);

input[7:0]in1,in2;
input cin;
output [7:0]sum;
output g,p,overflow;

wire g0,g1,g2,g3,g4,g5,g6,g7,p0,p1,p2,p3,p4,p5,p6,p7,c1,c2,c3,c4,c5,c6,c7,c8,pr0,pr1,pr2,pr3,pr4,pr5,pr6,pr7,s0,s1,s2,s3,s4,s5,s6,s7;

and(g0,in1[0],in2[0]);
or (p0,in1[0],in2[0]);

and(g1,in1[1],in2[1]);
or (p1,in1[1],in2[1]);

and(g2,in1[2],in2[2]);
or (p2,in1[2],in2[2]);

and(g3,in1[3],in2[3]);
or (p3,in1[3],in2[3]);

and(g4,in1[4],in2[4]);
or (p4,in1[4],in2[4]);

and(g5,in1[5],in2[5]);
or (p5,in1[5],in2[5]);

and(g6,in1[6],in2[6]);
or (p6,in1[6],in2[6]);


and(g7,in1[7],in2[7]);
or (p7,in1[7],in2[7]);

and(pr0,p0,cin);
or (c1,g0,pr0);

and(pr1,p1,c1);
or (c2,g1,pr1);

and(pr2,p2,c2);
or (c3,g2,pr2);

and(pr3,p3,c3);
or (c4,g3,pr3);

and(pr4,p4,c4);
or (c5,g4,pr4);

and(pr5,p5,c5);
or (c6,g5,pr5);

and(pr6,p6,c6);
or (c7,g6,pr6);

and(pr7,p7,c7);
or (c8,g7,pr7);


adder_cla_1bit a0 (.in1(in1[0]),.in2(in2[0]),.cin(cin),.sum(s0));
adder_cla_1bit a1 (.in1(in1[1]),.in2(in2[1]),.cin(c1),.sum(s1));
adder_cla_1bit a2 (.in1(in1[2]),.in2(in2[2]),.cin(c2),.sum(s2));
adder_cla_1bit a3 (.in1(in1[3]),.in2(in2[3]),.cin(c3),.sum(s3));
adder_cla_1bit a4 (.in1(in1[4]),.in2(in2[4]),.cin(c4),.sum(s4));
adder_cla_1bit a5 (.in1(in1[5]),.in2(in2[5]),.cin(c5),.sum(s5));
adder_cla_1bit a6 (.in1(in1[6]),.in2(in2[6]),.cin(c6),.sum(s6));
adder_cla_1bit a7 (.in1(in1[7]),.in2(in2[7]),.cin(c7),.sum(s7));

assign sum[0]=s0;
assign sum[1]=s1;
assign sum[2]=s2;
assign sum[3]=s3;
assign sum[4]=s4;
assign sum[5]=s5;
assign sum[6]=s6;
assign sum[7]=s7;



and(p,p0,p1,p2,p3,p4,p5,p5,p7);

wire gi0,gi1,gi2,gi3,gi4,gi5,gi6;
and(gi6,p7,g6);
and(gi5,p7,p6,g5);
and(gi4,p7,p6,p5,g4);
and(gi3,p7,p6,p5,p4,g3);
and(gi2,p7,p6,p5,p4,p3,g2);
and(gi1,p7,p6,p5,p4,p3,p2,g1);
and(gi0,p7,p6,p5,p4,p3,p2,p1,g0);

or(g,gi0,gi1,gi2,gi3,gi4,gi5,gi6,g7);

xor(overflow,c7,c8);

endmodule