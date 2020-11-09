module predictor_correlated_3bit (shouldTakeBranch, XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);

input Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset;
input [31:0] XPCidx, DPCidx;
output shouldTakeBranch;

wire[2:0] bhr_in, bhr_for_read, bhr_out, preshifted_bhr;
wire[7:0] bhr_idx, bhr_shouldTakeBranch;

register_3 BHR(bhr_in, clock, Xbranch, reset, bhr_out);

assign preshifted_bhr[2]=bhr_out[1];
assign preshifted_bhr[1]=bhr_out[0];
assign preshifted_bhr[0]=(predictedTaken & ~predictedWrong) | (~predictedTaken & predictedWrong);

mux2to1_3_bit XbranchAndDbranch_mux(Xbranch & Dbranch, bhr_out, preshifted_bhr, bhr_for_read);

decoder_3bit decoder_bhr(bhr_out, bhr_idx);

predictor_2bit_correlated predictor1(bhr_idx[0], bhr_shouldTakeBranch[0], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
predictor_2bit_correlated predictor2(bhr_idx[1], bhr_shouldTakeBranch[1], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
predictor_2bit_correlated predictor3(bhr_idx[2], bhr_shouldTakeBranch[2], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
predictor_2bit_correlated predictor4(bhr_idx[3], bhr_shouldTakeBranch[3], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
predictor_2bit_correlated predictor5(bhr_idx[4], bhr_shouldTakeBranch[4], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
predictor_2bit_correlated predictor6(bhr_idx[5], bhr_shouldTakeBranch[5], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
predictor_2bit_correlated predictor7(bhr_idx[6], bhr_shouldTakeBranch[6], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
predictor_2bit_correlated predictor8(bhr_idx[7], bhr_shouldTakeBranch[7], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);

mux_8_1_bit(bhr_for_read, bhr_shouldTakeBranch[0], bhr_shouldTakeBranch[1], bhr_shouldTakeBranch[2], bhr_shouldTakeBranch[3],
								 bhr_shouldTakeBranch[4], bhr_shouldTakeBranch[5], bhr_shouldTakeBranch[6], bhr_shouldTakeBranch[7], shouldTakeBranch);

assign bhr_in=preshifted_bhr;

endmodule