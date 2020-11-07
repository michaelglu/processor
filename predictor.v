module predictor (shouldTakeBranch, XPCidx, DPCidx, Xbranch, Dbranch, taken, clock, reset);

input Xbranch, Dbranch, taken, clock, reset;
input [31:0] XPCidx, DPCidx;
output shouldTakeBranch;

predictor_1bit(shouldTakeBranch, XPCidx, DPCidx, Xbranch, Dbranch, taken, clock, reset);

endmodule