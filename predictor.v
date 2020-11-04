module predictor (pc,shouldTakeBranch,past_pc,past_wrong);
input[31:0]pc,past_pc;
input past_wrong;
output shouldTakeBranch;
assign shouldTakeBranch=1'b1;

endmodule