module predictor_1bit (shouldTakeBranch, XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);

input Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset;
input [31:0] XPCidx, DPCidx;
output shouldTakeBranch;

wire[128:0] XPCdecoder_out, Xbranchand;
wire counter_mux_out, is_branch_mux_out, counter_plus_one, taken;
wire regout0,regout1,regout2,regout3,regout4,regout5,regout6,regout7,regout8,regout9,regout10,
regout11,regout12,regout13,regout14,regout15,regout16,regout17,regout18,regout19,regout20,regout21,
regout22,regout23,regout24,regout25,regout26,regout27,regout28,regout29,regout30,regout31,regout32,
regout33,regout34,regout35,regout36,regout37,regout38,regout39,regout40,regout41,regout42,regout43,
regout44,regout45,regout46,regout47,regout48,regout49,regout50,regout51,regout52,regout53,regout54,
regout55,regout56,regout57,regout58,regout59,regout60,regout61,regout62,regout63,regout64,regout65,
regout66,regout67,regout68,regout69,regout70,regout71,regout72,regout73,regout74,regout75,regout76,
regout77,regout78,regout79,regout80,regout81,regout82,regout83,regout84,regout85,regout86,regout87,
regout88,regout89,regout90,regout91,regout92,regout93,regout94,regout95,regout96,regout97,regout98,
regout99,regout100,regout101,regout102,regout103,regout104,regout105,regout106,regout107,regout108,
regout109,regout110,regout111,regout112,regout113,regout114,regout115,regout116,regout117,regout118,
regout119,regout120,regout121,regout122,regout123,regout124,regout125,regout126,regout127;


assign taken = (predictedTaken & ~predictedWrong) | (~predictedTaken & predictedWrong);

decoder_7bit XPCdecoder(XPCidx[6:0], XPCdecoder_out);

and and0(Xbranchand[0], Xbranch, XPCdecoder_out[0]);
register_1 register0(counter_plus_one, clock, Xbranchand[0], reset, regout0);
and and1(Xbranchand[1], Xbranch, XPCdecoder_out[1]);
register_1 register1(counter_plus_one, clock, Xbranchand[1], reset, regout1);
and and2(Xbranchand[2], Xbranch, XPCdecoder_out[2]);
register_1 register2(counter_plus_one, clock, Xbranchand[2], reset, regout2);
and and3(Xbranchand[3], Xbranch, XPCdecoder_out[3]);
register_1 register3(counter_plus_one, clock, Xbranchand[3], reset, regout3);
and and4(Xbranchand[4], Xbranch, XPCdecoder_out[4]);
register_1 register4(counter_plus_one, clock, Xbranchand[4], reset, regout4);
and and5(Xbranchand[5], Xbranch, XPCdecoder_out[5]);
register_1 register5(counter_plus_one, clock, Xbranchand[5], reset, regout5);
and and6(Xbranchand[6], Xbranch, XPCdecoder_out[6]);
register_1 register6(counter_plus_one, clock, Xbranchand[6], reset, regout6);
and and7(Xbranchand[7], Xbranch, XPCdecoder_out[7]);
register_1 register7(counter_plus_one, clock, Xbranchand[7], reset, regout7);
and and8(Xbranchand[8], Xbranch, XPCdecoder_out[8]);
register_1 register8(counter_plus_one, clock, Xbranchand[8], reset, regout8);
and and9(Xbranchand[9], Xbranch, XPCdecoder_out[9]);
register_1 register9(counter_plus_one, clock, Xbranchand[9], reset, regout9);
and and10(Xbranchand[10], Xbranch, XPCdecoder_out[10]);
register_1 register10(counter_plus_one, clock, Xbranchand[10], reset, regout10);
and and11(Xbranchand[11], Xbranch, XPCdecoder_out[11]);
register_1 register11(counter_plus_one, clock, Xbranchand[11], reset, regout11);
and and12(Xbranchand[12], Xbranch, XPCdecoder_out[12]);
register_1 register12(counter_plus_one, clock, Xbranchand[12], reset, regout12);
and and13(Xbranchand[13], Xbranch, XPCdecoder_out[13]);
register_1 register13(counter_plus_one, clock, Xbranchand[13], reset, regout13);
and and14(Xbranchand[14], Xbranch, XPCdecoder_out[14]);
register_1 register14(counter_plus_one, clock, Xbranchand[14], reset, regout14);
and and15(Xbranchand[15], Xbranch, XPCdecoder_out[15]);
register_1 register15(counter_plus_one, clock, Xbranchand[15], reset, regout15);
and and16(Xbranchand[16], Xbranch, XPCdecoder_out[16]);
register_1 register16(counter_plus_one, clock, Xbranchand[16], reset, regout16);
and and17(Xbranchand[17], Xbranch, XPCdecoder_out[17]);
register_1 register17(counter_plus_one, clock, Xbranchand[17], reset, regout17);
and and18(Xbranchand[18], Xbranch, XPCdecoder_out[18]);
register_1 register18(counter_plus_one, clock, Xbranchand[18], reset, regout18);
and and19(Xbranchand[19], Xbranch, XPCdecoder_out[19]);
register_1 register19(counter_plus_one, clock, Xbranchand[19], reset, regout19);
and and20(Xbranchand[20], Xbranch, XPCdecoder_out[20]);
register_1 register20(counter_plus_one, clock, Xbranchand[20], reset, regout20);
and and21(Xbranchand[21], Xbranch, XPCdecoder_out[21]);
register_1 register21(counter_plus_one, clock, Xbranchand[21], reset, regout21);
and and22(Xbranchand[22], Xbranch, XPCdecoder_out[22]);
register_1 register22(counter_plus_one, clock, Xbranchand[22], reset, regout22);
and and23(Xbranchand[23], Xbranch, XPCdecoder_out[23]);
register_1 register23(counter_plus_one, clock, Xbranchand[23], reset, regout23);
and and24(Xbranchand[24], Xbranch, XPCdecoder_out[24]);
register_1 register24(counter_plus_one, clock, Xbranchand[24], reset, regout24);
and and25(Xbranchand[25], Xbranch, XPCdecoder_out[25]);
register_1 register25(counter_plus_one, clock, Xbranchand[25], reset, regout25);
and and26(Xbranchand[26], Xbranch, XPCdecoder_out[26]);
register_1 register26(counter_plus_one, clock, Xbranchand[26], reset, regout26);
and and27(Xbranchand[27], Xbranch, XPCdecoder_out[27]);
register_1 register27(counter_plus_one, clock, Xbranchand[27], reset, regout27);
and and28(Xbranchand[28], Xbranch, XPCdecoder_out[28]);
register_1 register28(counter_plus_one, clock, Xbranchand[28], reset, regout28);
and and29(Xbranchand[29], Xbranch, XPCdecoder_out[29]);
register_1 register29(counter_plus_one, clock, Xbranchand[29], reset, regout29);
and and30(Xbranchand[30], Xbranch, XPCdecoder_out[30]);
register_1 register30(counter_plus_one, clock, Xbranchand[30], reset, regout30);
and and31(Xbranchand[31], Xbranch, XPCdecoder_out[31]);
register_1 register31(counter_plus_one, clock, Xbranchand[31], reset, regout31);
and and32(Xbranchand[32], Xbranch, XPCdecoder_out[32]);
register_1 register32(counter_plus_one, clock, Xbranchand[32], reset, regout32);
and and33(Xbranchand[33], Xbranch, XPCdecoder_out[33]);
register_1 register33(counter_plus_one, clock, Xbranchand[33], reset, regout33);
and and34(Xbranchand[34], Xbranch, XPCdecoder_out[34]);
register_1 register34(counter_plus_one, clock, Xbranchand[34], reset, regout34);
and and35(Xbranchand[35], Xbranch, XPCdecoder_out[35]);
register_1 register35(counter_plus_one, clock, Xbranchand[35], reset, regout35);
and and36(Xbranchand[36], Xbranch, XPCdecoder_out[36]);
register_1 register36(counter_plus_one, clock, Xbranchand[36], reset, regout36);
and and37(Xbranchand[37], Xbranch, XPCdecoder_out[37]);
register_1 register37(counter_plus_one, clock, Xbranchand[37], reset, regout37);
and and38(Xbranchand[38], Xbranch, XPCdecoder_out[38]);
register_1 register38(counter_plus_one, clock, Xbranchand[38], reset, regout38);
and and39(Xbranchand[39], Xbranch, XPCdecoder_out[39]);
register_1 register39(counter_plus_one, clock, Xbranchand[39], reset, regout39);
and and40(Xbranchand[40], Xbranch, XPCdecoder_out[40]);
register_1 register40(counter_plus_one, clock, Xbranchand[40], reset, regout40);
and and41(Xbranchand[41], Xbranch, XPCdecoder_out[41]);
register_1 register41(counter_plus_one, clock, Xbranchand[41], reset, regout41);
and and42(Xbranchand[42], Xbranch, XPCdecoder_out[42]);
register_1 register42(counter_plus_one, clock, Xbranchand[42], reset, regout42);
and and43(Xbranchand[43], Xbranch, XPCdecoder_out[43]);
register_1 register43(counter_plus_one, clock, Xbranchand[43], reset, regout43);
and and44(Xbranchand[44], Xbranch, XPCdecoder_out[44]);
register_1 register44(counter_plus_one, clock, Xbranchand[44], reset, regout44);
and and45(Xbranchand[45], Xbranch, XPCdecoder_out[45]);
register_1 register45(counter_plus_one, clock, Xbranchand[45], reset, regout45);
and and46(Xbranchand[46], Xbranch, XPCdecoder_out[46]);
register_1 register46(counter_plus_one, clock, Xbranchand[46], reset, regout46);
and and47(Xbranchand[47], Xbranch, XPCdecoder_out[47]);
register_1 register47(counter_plus_one, clock, Xbranchand[47], reset, regout47);
and and48(Xbranchand[48], Xbranch, XPCdecoder_out[48]);
register_1 register48(counter_plus_one, clock, Xbranchand[48], reset, regout48);
and and49(Xbranchand[49], Xbranch, XPCdecoder_out[49]);
register_1 register49(counter_plus_one, clock, Xbranchand[49], reset, regout49);
and and50(Xbranchand[50], Xbranch, XPCdecoder_out[50]);
register_1 register50(counter_plus_one, clock, Xbranchand[50], reset, regout50);
and and51(Xbranchand[51], Xbranch, XPCdecoder_out[51]);
register_1 register51(counter_plus_one, clock, Xbranchand[51], reset, regout51);
and and52(Xbranchand[52], Xbranch, XPCdecoder_out[52]);
register_1 register52(counter_plus_one, clock, Xbranchand[52], reset, regout52);
and and53(Xbranchand[53], Xbranch, XPCdecoder_out[53]);
register_1 register53(counter_plus_one, clock, Xbranchand[53], reset, regout53);
and and54(Xbranchand[54], Xbranch, XPCdecoder_out[54]);
register_1 register54(counter_plus_one, clock, Xbranchand[54], reset, regout54);
and and55(Xbranchand[55], Xbranch, XPCdecoder_out[55]);
register_1 register55(counter_plus_one, clock, Xbranchand[55], reset, regout55);
and and56(Xbranchand[56], Xbranch, XPCdecoder_out[56]);
register_1 register56(counter_plus_one, clock, Xbranchand[56], reset, regout56);
and and57(Xbranchand[57], Xbranch, XPCdecoder_out[57]);
register_1 register57(counter_plus_one, clock, Xbranchand[57], reset, regout57);
and and58(Xbranchand[58], Xbranch, XPCdecoder_out[58]);
register_1 register58(counter_plus_one, clock, Xbranchand[58], reset, regout58);
and and59(Xbranchand[59], Xbranch, XPCdecoder_out[59]);
register_1 register59(counter_plus_one, clock, Xbranchand[59], reset, regout59);
and and60(Xbranchand[60], Xbranch, XPCdecoder_out[60]);
register_1 register60(counter_plus_one, clock, Xbranchand[60], reset, regout60);
and and61(Xbranchand[61], Xbranch, XPCdecoder_out[61]);
register_1 register61(counter_plus_one, clock, Xbranchand[61], reset, regout61);
and and62(Xbranchand[62], Xbranch, XPCdecoder_out[62]);
register_1 register62(counter_plus_one, clock, Xbranchand[62], reset, regout62);
and and63(Xbranchand[63], Xbranch, XPCdecoder_out[63]);
register_1 register63(counter_plus_one, clock, Xbranchand[63], reset, regout63);
and and64(Xbranchand[64], Xbranch, XPCdecoder_out[64]);
register_1 register64(counter_plus_one, clock, Xbranchand[64], reset, regout64);
and and65(Xbranchand[65], Xbranch, XPCdecoder_out[65]);
register_1 register65(counter_plus_one, clock, Xbranchand[65], reset, regout65);
and and66(Xbranchand[66], Xbranch, XPCdecoder_out[66]);
register_1 register66(counter_plus_one, clock, Xbranchand[66], reset, regout66);
and and67(Xbranchand[67], Xbranch, XPCdecoder_out[67]);
register_1 register67(counter_plus_one, clock, Xbranchand[67], reset, regout67);
and and68(Xbranchand[68], Xbranch, XPCdecoder_out[68]);
register_1 register68(counter_plus_one, clock, Xbranchand[68], reset, regout68);
and and69(Xbranchand[69], Xbranch, XPCdecoder_out[69]);
register_1 register69(counter_plus_one, clock, Xbranchand[69], reset, regout69);
and and70(Xbranchand[70], Xbranch, XPCdecoder_out[70]);
register_1 register70(counter_plus_one, clock, Xbranchand[70], reset, regout70);
and and71(Xbranchand[71], Xbranch, XPCdecoder_out[71]);
register_1 register71(counter_plus_one, clock, Xbranchand[71], reset, regout71);
and and72(Xbranchand[72], Xbranch, XPCdecoder_out[72]);
register_1 register72(counter_plus_one, clock, Xbranchand[72], reset, regout72);
and and73(Xbranchand[73], Xbranch, XPCdecoder_out[73]);
register_1 register73(counter_plus_one, clock, Xbranchand[73], reset, regout73);
and and74(Xbranchand[74], Xbranch, XPCdecoder_out[74]);
register_1 register74(counter_plus_one, clock, Xbranchand[74], reset, regout74);
and and75(Xbranchand[75], Xbranch, XPCdecoder_out[75]);
register_1 register75(counter_plus_one, clock, Xbranchand[75], reset, regout75);
and and76(Xbranchand[76], Xbranch, XPCdecoder_out[76]);
register_1 register76(counter_plus_one, clock, Xbranchand[76], reset, regout76);
and and77(Xbranchand[77], Xbranch, XPCdecoder_out[77]);
register_1 register77(counter_plus_one, clock, Xbranchand[77], reset, regout77);
and and78(Xbranchand[78], Xbranch, XPCdecoder_out[78]);
register_1 register78(counter_plus_one, clock, Xbranchand[78], reset, regout78);
and and79(Xbranchand[79], Xbranch, XPCdecoder_out[79]);
register_1 register79(counter_plus_one, clock, Xbranchand[79], reset, regout79);
and and80(Xbranchand[80], Xbranch, XPCdecoder_out[80]);
register_1 register80(counter_plus_one, clock, Xbranchand[80], reset, regout80);
and and81(Xbranchand[81], Xbranch, XPCdecoder_out[81]);
register_1 register81(counter_plus_one, clock, Xbranchand[81], reset, regout81);
and and82(Xbranchand[82], Xbranch, XPCdecoder_out[82]);
register_1 register82(counter_plus_one, clock, Xbranchand[82], reset, regout82);
and and83(Xbranchand[83], Xbranch, XPCdecoder_out[83]);
register_1 register83(counter_plus_one, clock, Xbranchand[83], reset, regout83);
and and84(Xbranchand[84], Xbranch, XPCdecoder_out[84]);
register_1 register84(counter_plus_one, clock, Xbranchand[84], reset, regout84);
and and85(Xbranchand[85], Xbranch, XPCdecoder_out[85]);
register_1 register85(counter_plus_one, clock, Xbranchand[85], reset, regout85);
and and86(Xbranchand[86], Xbranch, XPCdecoder_out[86]);
register_1 register86(counter_plus_one, clock, Xbranchand[86], reset, regout86);
and and87(Xbranchand[87], Xbranch, XPCdecoder_out[87]);
register_1 register87(counter_plus_one, clock, Xbranchand[87], reset, regout87);
and and88(Xbranchand[88], Xbranch, XPCdecoder_out[88]);
register_1 register88(counter_plus_one, clock, Xbranchand[88], reset, regout88);
and and89(Xbranchand[89], Xbranch, XPCdecoder_out[89]);
register_1 register89(counter_plus_one, clock, Xbranchand[89], reset, regout89);
and and90(Xbranchand[90], Xbranch, XPCdecoder_out[90]);
register_1 register90(counter_plus_one, clock, Xbranchand[90], reset, regout90);
and and91(Xbranchand[91], Xbranch, XPCdecoder_out[91]);
register_1 register91(counter_plus_one, clock, Xbranchand[91], reset, regout91);
and and92(Xbranchand[92], Xbranch, XPCdecoder_out[92]);
register_1 register92(counter_plus_one, clock, Xbranchand[92], reset, regout92);
and and93(Xbranchand[93], Xbranch, XPCdecoder_out[93]);
register_1 register93(counter_plus_one, clock, Xbranchand[93], reset, regout93);
and and94(Xbranchand[94], Xbranch, XPCdecoder_out[94]);
register_1 register94(counter_plus_one, clock, Xbranchand[94], reset, regout94);
and and95(Xbranchand[95], Xbranch, XPCdecoder_out[95]);
register_1 register95(counter_plus_one, clock, Xbranchand[95], reset, regout95);
and and96(Xbranchand[96], Xbranch, XPCdecoder_out[96]);
register_1 register96(counter_plus_one, clock, Xbranchand[96], reset, regout96);
and and97(Xbranchand[97], Xbranch, XPCdecoder_out[97]);
register_1 register97(counter_plus_one, clock, Xbranchand[97], reset, regout97);
and and98(Xbranchand[98], Xbranch, XPCdecoder_out[98]);
register_1 register98(counter_plus_one, clock, Xbranchand[98], reset, regout98);
and and99(Xbranchand[99], Xbranch, XPCdecoder_out[99]);
register_1 register99(counter_plus_one, clock, Xbranchand[99], reset, regout99);
and and100(Xbranchand[100], Xbranch, XPCdecoder_out[100]);
register_1 register100(counter_plus_one, clock, Xbranchand[100], reset, regout100);
and and101(Xbranchand[101], Xbranch, XPCdecoder_out[101]);
register_1 register101(counter_plus_one, clock, Xbranchand[101], reset, regout101);
and and102(Xbranchand[102], Xbranch, XPCdecoder_out[102]);
register_1 register102(counter_plus_one, clock, Xbranchand[102], reset, regout102);
and and103(Xbranchand[103], Xbranch, XPCdecoder_out[103]);
register_1 register103(counter_plus_one, clock, Xbranchand[103], reset, regout103);
and and104(Xbranchand[104], Xbranch, XPCdecoder_out[104]);
register_1 register104(counter_plus_one, clock, Xbranchand[104], reset, regout104);
and and105(Xbranchand[105], Xbranch, XPCdecoder_out[105]);
register_1 register105(counter_plus_one, clock, Xbranchand[105], reset, regout105);
and and106(Xbranchand[106], Xbranch, XPCdecoder_out[106]);
register_1 register106(counter_plus_one, clock, Xbranchand[106], reset, regout106);
and and107(Xbranchand[107], Xbranch, XPCdecoder_out[107]);
register_1 register107(counter_plus_one, clock, Xbranchand[107], reset, regout107);
and and108(Xbranchand[108], Xbranch, XPCdecoder_out[108]);
register_1 register108(counter_plus_one, clock, Xbranchand[108], reset, regout108);
and and109(Xbranchand[109], Xbranch, XPCdecoder_out[109]);
register_1 register109(counter_plus_one, clock, Xbranchand[109], reset, regout109);
and and110(Xbranchand[110], Xbranch, XPCdecoder_out[110]);
register_1 register110(counter_plus_one, clock, Xbranchand[110], reset, regout110);
and and111(Xbranchand[111], Xbranch, XPCdecoder_out[111]);
register_1 register111(counter_plus_one, clock, Xbranchand[111], reset, regout111);
and and112(Xbranchand[112], Xbranch, XPCdecoder_out[112]);
register_1 register112(counter_plus_one, clock, Xbranchand[112], reset, regout112);
and and113(Xbranchand[113], Xbranch, XPCdecoder_out[113]);
register_1 register113(counter_plus_one, clock, Xbranchand[113], reset, regout113);
and and114(Xbranchand[114], Xbranch, XPCdecoder_out[114]);
register_1 register114(counter_plus_one, clock, Xbranchand[114], reset, regout114);
and and115(Xbranchand[115], Xbranch, XPCdecoder_out[115]);
register_1 register115(counter_plus_one, clock, Xbranchand[115], reset, regout115);
and and116(Xbranchand[116], Xbranch, XPCdecoder_out[116]);
register_1 register116(counter_plus_one, clock, Xbranchand[116], reset, regout116);
and and117(Xbranchand[117], Xbranch, XPCdecoder_out[117]);
register_1 register117(counter_plus_one, clock, Xbranchand[117], reset, regout117);
and and118(Xbranchand[118], Xbranch, XPCdecoder_out[118]);
register_1 register118(counter_plus_one, clock, Xbranchand[118], reset, regout118);
and and119(Xbranchand[119], Xbranch, XPCdecoder_out[119]);
register_1 register119(counter_plus_one, clock, Xbranchand[119], reset, regout119);
and and120(Xbranchand[120], Xbranch, XPCdecoder_out[120]);
register_1 register120(counter_plus_one, clock, Xbranchand[120], reset, regout120);
and and121(Xbranchand[121], Xbranch, XPCdecoder_out[121]);
register_1 register121(counter_plus_one, clock, Xbranchand[121], reset, regout121);
and and122(Xbranchand[122], Xbranch, XPCdecoder_out[122]);
register_1 register122(counter_plus_one, clock, Xbranchand[122], reset, regout122);
and and123(Xbranchand[123], Xbranch, XPCdecoder_out[123]);
register_1 register123(counter_plus_one, clock, Xbranchand[123], reset, regout123);
and and124(Xbranchand[124], Xbranch, XPCdecoder_out[124]);
register_1 register124(counter_plus_one, clock, Xbranchand[124], reset, regout124);
and and125(Xbranchand[125], Xbranch, XPCdecoder_out[125]);
register_1 register125(counter_plus_one, clock, Xbranchand[125], reset, regout125);
and and126(Xbranchand[126], Xbranch, XPCdecoder_out[126]);
register_1 register126(counter_plus_one, clock, Xbranchand[126], reset, regout126);
and and127(Xbranchand[127], Xbranch, XPCdecoder_out[127]);
register_1 register127(counter_plus_one, clock, Xbranchand[127], reset, regout127);




mux_128_1_bit counter_mux(.select(XPCidx[6:0]),.in0(regout0),.in1(regout1),.in2(regout2),.in3(regout3),.in4(regout4),
.in5(regout5),.in6(regout6),.in7(regout7),.in8(regout8),.in9(regout9),.in10(regout10),.in11(regout11),
.in12(regout12),.in13(regout13),.in14(regout14),.in15(regout15),.in16(regout16),.in17(regout17),
.in18(regout18),.in19(regout19),.in20(regout20),.in21(regout21),.in22(regout22),.in23(regout23),
.in24(regout24),.in25(regout25),.in26(regout26),.in27(regout27),.in28(regout28),.in29(regout29),
.in30(regout30),.in31(regout31),.in32(regout32),.in33(regout33),.in34(regout34),.in35(regout35),
.in36(regout36),.in37(regout37),.in38(regout38),.in39(regout39),.in40(regout40),.in41(regout41),
.in42(regout42),.in43(regout43),.in44(regout44),.in45(regout45),.in46(regout46),.in47(regout47),
.in48(regout48),.in49(regout49),.in50(regout50),.in51(regout51),.in52(regout52),.in53(regout53),
.in54(regout54),.in55(regout55),.in56(regout56),.in57(regout57),.in58(regout58),.in59(regout59),
.in60(regout60),.in61(regout61),.in62(regout62),.in63(regout63),.in64(regout64),.in65(regout65),
.in66(regout66),.in67(regout67),.in68(regout68),.in69(regout69),.in70(regout70),.in71(regout71),
.in72(regout72),.in73(regout73),.in74(regout74),.in75(regout75),.in76(regout76),.in77(regout77),
.in78(regout78),.in79(regout79),.in80(regout80),.in81(regout81),.in82(regout82),.in83(regout83),
.in84(regout84),.in85(regout85),.in86(regout86),.in87(regout87),.in88(regout88),.in89(regout89),
.in90(regout90),.in91(regout91),.in92(regout92),.in93(regout93),.in94(regout94),.in95(regout95),
.in96(regout96),.in97(regout97),.in98(regout98),.in99(regout99),.in100(regout100),.in101(regout101),
.in102(regout102),.in103(regout103),.in104(regout104),.in105(regout105),.in106(regout106),.in107(regout107),
.in108(regout108),.in109(regout109),.in110(regout110),.in111(regout111),.in112(regout112),.in113(regout113),
.in114(regout114),.in115(regout115),.in116(regout116),.in117(regout117),.in118(regout118),.in119(regout119),
.in120(regout120),.in121(regout121),.in122(regout122),.in123(regout123),.in124(regout124),.in125(regout125),
.in126(regout126),.in127(regout127), .out(counter_mux_out));

mux_128_1_bit counter_mux1(.select(DPCidx[6:0]),.in0(regout0),.in1(regout1),.in2(regout2),.in3(regout3),.in4(regout4),
.in5(regout5),.in6(regout6),.in7(regout7),.in8(regout8),.in9(regout9),.in10(regout10),.in11(regout11),
.in12(regout12),.in13(regout13),.in14(regout14),.in15(regout15),.in16(regout16),.in17(regout17),
.in18(regout18),.in19(regout19),.in20(regout20),.in21(regout21),.in22(regout22),.in23(regout23),
.in24(regout24),.in25(regout25),.in26(regout26),.in27(regout27),.in28(regout28),.in29(regout29),
.in30(regout30),.in31(regout31),.in32(regout32),.in33(regout33),.in34(regout34),.in35(regout35),
.in36(regout36),.in37(regout37),.in38(regout38),.in39(regout39),.in40(regout40),.in41(regout41),
.in42(regout42),.in43(regout43),.in44(regout44),.in45(regout45),.in46(regout46),.in47(regout47),
.in48(regout48),.in49(regout49),.in50(regout50),.in51(regout51),.in52(regout52),.in53(regout53),
.in54(regout54),.in55(regout55),.in56(regout56),.in57(regout57),.in58(regout58),.in59(regout59),
.in60(regout60),.in61(regout61),.in62(regout62),.in63(regout63),.in64(regout64),.in65(regout65),
.in66(regout66),.in67(regout67),.in68(regout68),.in69(regout69),.in70(regout70),.in71(regout71),
.in72(regout72),.in73(regout73),.in74(regout74),.in75(regout75),.in76(regout76),.in77(regout77),
.in78(regout78),.in79(regout79),.in80(regout80),.in81(regout81),.in82(regout82),.in83(regout83),
.in84(regout84),.in85(regout85),.in86(regout86),.in87(regout87),.in88(regout88),.in89(regout89),
.in90(regout90),.in91(regout91),.in92(regout92),.in93(regout93),.in94(regout94),.in95(regout95),
.in96(regout96),.in97(regout97),.in98(regout98),.in99(regout99),.in100(regout100),.in101(regout101),
.in102(regout102),.in103(regout103),.in104(regout104),.in105(regout105),.in106(regout106),.in107(regout107),
.in108(regout108),.in109(regout109),.in110(regout110),.in111(regout111),.in112(regout112),.in113(regout113),
.in114(regout114),.in115(regout115),.in116(regout116),.in117(regout117),.in118(regout118),.in119(regout119),
.in120(regout120),.in121(regout121),.in122(regout122),.in123(regout123),.in124(regout124),.in125(regout125),
.in126(regout126),.in127(regout127), .out(is_branch_mux_out));


assign counter_plus_one = Xbranch&taken;
assign shouldTakeBranch = is_branch_mux_out;

endmodule