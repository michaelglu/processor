module predictor (pc,is_branch,shouldTakeBranch,past_pc,past_wrong,past_is_branch,past_predicted_taken);
input[31:0]pc,past_pc;
input past_wrong,is_branch,past_is_branch,past_predicted_taken;
// pc: pc of branch being predicted
// is_branch: is the instruction being predicted a branch?
// past_pc: pc of branch previously predicted (comes from execute)
// past_is_branch: is the instruction coming from execute a branch
// past_wrong: was there a mispredict on the past branch coming from execute
// past_predicted_taken: whether the prediction of the past branch from execute was taken or not taken
// shouldTakeBranch: shoud take current branch in decode?
output shouldTakeBranch;
assign shouldTakeBranch=1'b0;

endmodule