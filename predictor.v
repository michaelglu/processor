module predictor (pc,is_branch,shouldTakeBranch,past_pc,past_wrong,past_is_branch,past_predicted_taken,clock,reset);
// pc: pc of branch being predicted
// is_branch: is the instruction being predicted a branch?
// past_pc: pc of branch previously predicted (comes from execute)
// past_is_branch: is the instruction coming from execute a branch
// past_wrong: was there a mispredict on the past branch coming from execute
// past_predicted_taken: whether the prediction of the past branch from execute was taken or not taken
// shouldTakeBranch: shoud take current branch in decode?

input[31:0]pc,past_pc;
input past_wrong,is_branch,past_is_branch,past_predicted_taken,clock,reset;

output shouldTakeBranch;

//predictor_1bit bpred1bit(shouldTakeBranch, past_pc, pc, past_is_branch, is_branch, past_predicted_taken, past_wrong, clock, reset);
predictor_2bit bpred2bit(shouldTakeBranch, past_pc, pc, past_is_branch, is_branch, past_predicted_taken, past_wrong, clock, reset);

//assign shouldTakeBranch=1'b0;

endmodule