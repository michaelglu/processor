module runner (clock,reset,num_inst,num_noops_min,num_noops_max,num_mispredicts,done,result,oFD,oDX,stall,stall_bot);

input clock,reset;

output [31:0]num_inst,num_noops_min,num_noops_max,num_mispredicts,result;
output done,oFD,oDX;
reg [31:0]count_inst,count_noops_min,count_noops_max,count_mispredicts;
reg amDone;


assign done=amDone;
assign num_inst = count_inst;
assign num_noops_min=count_noops_min;
assign num_noops_max=count_noops_max;
assign num_mispredicts=count_mispredicts;

wire[31:0] reg1;
output stall,stall_bot;
wire overrideDX,overrideFD,d_mispredict;

assign oFD=overrideFD;
assign oDX=overrideDX;

skeleton myskeleton(.clock(clock),.reset(1'b0),.debugR1(reg1), .d_stall(stall),.d_stall_bot(stall_bot),.d_O_DX(overrideDX),.d_O_FD(overrideFD),.debugR4(result),.d_mispredict(d_mispredict));



always @(posedge clock)
begin

		if(reset) begin
		amDone <=1'b0;
		count_inst<={32{1'b0}};
		count_noops_min<={32{1'b0}};
		count_noops_max<={32{1'b0}};
		count_mispredicts<={32{1'b0}};
		end
		if(reg1==32'd1)begin
			amDone<=1'b1;
			count_inst<=count_inst-32'd8;// 8 noops behind the last instruciton
		end
		else begin
		count_inst<=count_inst+32'd2;// increment by 2 every cycle until done
		end
		if (stall_bot) begin
			count_noops_min<=count_noops_min+32'd2;	// stall_bot means 2 noop was inserted
			count_noops_max<=count_noops_max+32'd2;	// stall_bot means 2 noop was inserted	
		end
		
		if(stall) begin
		count_noops_min<=count_noops_min+32'd2; //while stall high 2 noops inserted per cycle
		count_noops_max<=count_noops_max+32'd2; //while stall high 2 noops inserted per cycle
		end
		if(overrideFD)begin
		count_noops_min<=count_noops_min+32'd2; // if branching/jumping from fd overwrote 2 instrucitons with noops if coming from bot
		count_noops_max<=count_noops_max+32'd3; // if branching/jumping from fd overwrote 3 instrucitons with noops if coming from top
		end
		if(overrideDX)begin
		count_noops_min<=count_noops_min+32'd4;// if branching/jumping from fd overwrote 4 instrucitons with noops if coming from bot
		count_noops_max<=count_noops_max+32'd5;// if branching/jumping from fd overwrote 5 instrucitons with noops if coming from top
		end
		if(d_mispredict)begin
		count_mispredicts<=count_mispredicts+32'd1;
		end
	


end


endmodule