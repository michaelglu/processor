module predictor_correlated_2bit (shouldTakeBranch, XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);

input Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset;
input [31:0] XPCidx, DPCidx;
output shouldTakeBranch;

wire[1:0] bhr_in, bhr_for_read, bhr_out, preshifted_bhr;
wire[3:0] bhr_idx, bhr_shouldTakeBranch;

register_2 BHR(bhr_in, clock, Xbranch, reset, bhr_out);

assign preshifted_bhr[1]=bhr_out[0];
assign preshifted_bhr[0]=(predictedTaken & ~predictedWrong) | (~predictedTaken & predictedWrong);

mux2to1_2_bit XbranchAndDbranch_mux(Xbranch & Dbranch, bhr_out, preshifted_bhr, bhr_for_read);

decoder_2bit decoder_bhr(bhr_out, bhr_idx);

predictor_2bit_correlated predictor1(bhr_idx[0], bhr_shouldTakeBranch[0], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
predictor_2bit_correlated predictor2(bhr_idx[1], bhr_shouldTakeBranch[1], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
predictor_2bit_correlated predictor3(bhr_idx[2], bhr_shouldTakeBranch[2], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
predictor_2bit_correlated predictor4(bhr_idx[3], bhr_shouldTakeBranch[3], XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);

mux_4_1bit(bhr_for_read, bhr_shouldTakeBranch[0], bhr_shouldTakeBranch[1], bhr_shouldTakeBranch[2], bhr_shouldTakeBranch[3], shouldTakeBranch);

assign bhr_in=preshifted_bhr;

endmodule

//to extend, add more predictors, make bhr register larger, shift appropriately.

//module predictor_correlated_2bit (bhr_in, bhr_out, bhr_idx, bhr_shouldTakeBranch, shouldTakeBranch, XPCidx, DPCidx, Xbranch, Dbranch, predictedTaken, predictedWrong, clock, reset);
//if(Xbranch and Dbranch) {
//	read from shifted bhr value (modified by X but not written to bhr yet)
//	DONE if XPC and DPC are the same, bypass decremented/incremented value in 2bit predictor
//	
//	bhr_out = 
//}