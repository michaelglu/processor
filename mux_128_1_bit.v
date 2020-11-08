module mux_128_1_bit (select,in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16,
in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31,in32,
in33,in34,in35,in36,in37,in38,in39,in40,in41,in42,in43,in44,in45,in46,in47,in48,
in49,in50,in51,in52,in53,in54,in55,in56,in57,in58,in59,in60,in61,in62,in63,in64,
in65,in66,in67,in68,in69,in70,in71,in72,in73,in74,in75,in76,in77,in78,in79,in80,
in81,in82,in83,in84,in85,in86,in87,in88,in89,in90,in91,in92,in93,in94,in95,in96,
in97,in98,in99,in100,in101,in102,in103,in104,in105,in106,in107,in108,in109,in110,
in111,in112,in113,in114,in115,in116,in117,in118,in119,in120,in121,in122,in123,in124,in125,in126,in127, out);

input [6:0] select;
input in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,in10,in11,in12,in13,in14,in15,in16,
in17,in18,in19,in20,in21,in22,in23,in24,in25,in26,in27,in28,in29,in30,in31,in32,
in33,in34,in35,in36,in37,in38,in39,in40,in41,in42,in43,in44,in45,in46,in47,in48,
in49,in50,in51,in52,in53,in54,in55,in56,in57,in58,in59,in60,in61,in62,in63,in64,
in65,in66,in67,in68,in69,in70,in71,in72,in73,in74,in75,in76,in77,in78,in79,in80,
in81,in82,in83,in84,in85,in86,in87,in88,in89,in90,in91,in92,in93,in94,in95,in96,
in97,in98,in99,in100,in101,in102,in103,in104,in105,in106,in107,in108,in109,in110,
in111,in112,in113,in114,in115,in116,in117,in118,in119,in120,in121,in122,in123,in124,in125,in126,in127;

output  out;
 
wire w1, w2;

mux_64_1_bit first_top(.select(select[5:0]), .in0(in0),.in1(in1),.in2(in2),.in3(in3),.in4(in4),.in5(in5),.in6(in6),.in7(in7),.in8(in8),
.in9(in9),.in10(in10),.in11(in11),.in12(in12),.in13(in13),.in14(in14),.in15(in15),.in16(in16),
.in17(in17),.in18(in18),.in19(in19),.in20(in20),.in21(in21),.in22(in22),.in23(in23),.in24(in24),
.in25(in25),.in26(in26),.in27(in27),.in28(in28),.in29(in29),.in30(in30),.in31(in31),.in32(in32),
.in33(in33),.in34(in34),.in35(in35),.in36(in36),.in37(in37),.in38(in38),.in39(in39),.in40(in40),
.in41(in41),.in42(in42),.in43(in43),.in44(in44),.in45(in45),.in46(in46),.in47(in47),.in48(in48),
.in49(in49),.in50(in50),.in51(in51),.in52(in52),.in53(in53),.in54(in54),.in55(in55),.in56(in56),
.in57(in57),.in58(in58),.in59(in59),.in60(in60),.in61(in61),.in62(in62),.in63(in63), .out(w1));

mux_64_1_bit first_bottom(.select(select[5:0]), .in0(in64),.in1(in65),.in2(in66),.in3(in67),.in4(in68),.in5(in69),.in6(in70),.in7(in71),.in8(in72),
.in9(in73),.in10(in74),.in11(in75),.in12(in76),.in13(in77),.in14(in78),.in15(in79),.in16(in80),
.in17(in81),.in18(in82),.in19(in83),.in20(in84),.in21(in85),.in22(in86),.in23(in87),.in24(in88),
.in25(in89),.in26(in90),.in27(in91),.in28(in92),.in29(in93),.in30(in94),.in31(in95),.in32(in96),
.in33(in97),.in34(in98),.in35(in99),.in36(in100),.in37(in101),.in38(in102),.in39(in103),.in40(in104),
.in41(in105),.in42(in106),.in43(in107),.in44(in108),.in45(in109),.in46(in110),.in47(in111),.in48(in112),
.in49(in113),.in50(in114),.in51(in115),.in52(in116),.in53(in117),.in54(in118),.in55(in119),.in56(in120),
.in57(in121),.in58(in122),.in59(in123),.in60(in124),.in61(in125),.in62(in126),.in63(in127), .out(w2));


mux2_1bit second(.select(select[5]), .in0(w1), .in1(w2), .out(out));
 
endmodule