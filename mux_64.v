module mux_64 (select,in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16,in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31,
in32,in33,in34,in35,in36,in37,in38,in39,in40,in41,in42,in43,in44,in45,in46,in47,in48,in49,in50,in51,in52,in53,in54,in55,in56,in57,in58,in59,in60,in61,in62,in63, out);

input [5:0] select;
input [31:0] in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16,in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31,
in32,in33,in34,in35,in36,in37,in38,in39,in40,in41,in42,in43,in44,in45,in46,in47,in48,in49,in50,in51,in52,in53,in54,in55,in56,in57,in58,in59,in60,in61,in62,in63;
output [31:0] out;
 
wire [31:0] w1, w2;
mux_32 first_top(.select(select[4:0]), .in0(in0),.in1(in1),.in2(in2),.in3(in3),.in4(in4),.in5(in5),.in6(in6),.in7(in7),.in8(in8),.in9(in9),.in10(in10),.in11(in11),.in12(in12),.in13(in13),.in14(in14),.in15(in15),
.in16(in16),.in17(in17),.in18(in18),.in19(in19),.in20(in20),.in21(in21),.in22(in22),.in23(in23),.in24(in24),.in25(in25),.in26(in26),.in27(in27),.in28(in28),.in29(in29),.in30(in30),.in31(in31), .out(w1));

mux_32 first_bottom(.select(select[4:0]), .in0(in32),.in1(in33),.in2(in34),.in3(in35),.in4(in36),.in5(in37),.in6(in38),.in7(in39),.in8(in40),.in9(in41),.in10(in42),.in11(in43),.in12(in44),.in13(in45),.in14(in46),.in15(in47),
.in16(in48),.in17(in49),.in18(in50),.in19(in51),.in20(in52),.in21(in53),.in22(in54),.in23(in55),.in24(in56),.in25(in57),.in26(in58),.in27(in59),.in28(in60),.in29(in61),.in30(in62),.in31(in63), .out(w2));


mux2to1 second(.select(select[5]), .in0(w1), .in1(w2), .out(out));
 
endmodule