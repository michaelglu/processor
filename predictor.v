<<<<<<< HEAD
module predictor (shouldTakeBranch, XPC, DPC, Xbranch, Dbranch, taken, clock, reset);

input Xbranch, Dbranch, taken, clock, reset;
input [31:0] XPC, DPC;
output shouldTakeBranch;

predictor_1bit(shouldTakeBranch, XPC, DPC, Xbranch, Dbranch, taken, clock, reset);

endmodule