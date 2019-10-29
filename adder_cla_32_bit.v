module adder_cla_32_bit(in1,in2,cin,sum,overflow);
input[31:0]in1,in2;
input cin;
output [31:0] sum;
output overflow;

wire g0,g1,g2,g3,p0,p1,p2,p3,pr0,pr1,pr2,pr3,c8,c16,c24,c32,i0,i1,i2,i3,i4,i5;
wire [7:0] sum1,sum2,sum3,sum4;

adder_cla_8_bit adder0 (.in1(in1[7:0]), .in2(in2[7:0]),.cin(cin),.sum(sum1),.g(g0),.p(p0));

and(pr0,p0,cin);
or(c8,g0,pr0);

adder_cla_8_bit adder1 (.in1(in1[15:8]), .in2(in2[15:8]),.cin(c8),.sum(sum2),.g(g1),.p(p1));

and(i0,p1,c8);
//and(pr1,p1,p0,cin);
or(c16,g1,i0);

adder_cla_8_bit adder2 (.in1(in1[23:16]), .in2(in2[23:16]),.cin(c16),.sum(sum3),.g(g2),.p(p2));

//and(i1,p2,g1);
//and(i2,p2,p1,g0);
//and(pr2,p2,p1,p0,cin);
and(pr2,p2,c16);
or(c24,g2,pr2);

//assign ctest=c16;

adder_cla_8_bit_overflow adder3 (.in1(in1[31:24]), .in2(in2[31:24]),.cin(c24),.sum(sum4),.g(g3),.p(p3),.overflow(overflow));

and(i3,p3,g2);
and(i4,p3,p2,g1);
and(i5,p3,p2,p1,g0);
and(pr3,p3,p2,p1,p0);
or(c32,pr3,i3,i4,i5,g3);

assign sum[7:0]=sum1;
assign sum[15:8]=sum2;
assign sum[23:16]=sum3;
assign sum[31:24]=sum4;


endmodule