module exceptionHandler (instruction,setXVal,out);
input[31:0]instruction,setXVal;
output [31:0]out;

wire isAdd,isAddI,isSub,isMul,isDiv,isSetX;

assign isAdd = ~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&~instruction[27]&(~instruction[6]&~instruction[5]&~instruction[4]&~instruction[3]&~instruction[2]);
assign isAddI=(~instruction[31]&~instruction[30]&instruction[29]&~instruction[28]&instruction[27]);
assign isSub= ~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&~instruction[27]&(~instruction[6]&~instruction[5]&~instruction[4]&~instruction[3]&instruction[2]);
assign isMul= ~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&~instruction[27]&(~instruction[6]&~instruction[5]&instruction[4]&instruction[3]&~instruction[2]);
assign isDiv= ~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&~instruction[27]&(~instruction[6]&~instruction[5]&instruction[4]&instruction[3]&instruction[2]);
assign isSetx=(instruction[31]&~instruction[30]&instruction[29]&~instruction[28]&instruction[27]);

wire[31:0]one,two,three,four,five;
assign one[31:1]={31{1'b0}};
assign one[0]=1'b1;

assign two[31:2]={30{1'b0}};
assign two[1]=1'b1;
assign two[0]=1'b0;

assign three[31:2]={30{1'b0}};
assign three[1:0]={2{1'b1}};

assign four[31:3]={29{1'b0}};
assign four[2]=1'b1;
assign four[1:0]={2{1'b0}};

assign five[31:3]={29{1'b0}};
assign five[2]=1'b1;
assign five[1]=1'b0;
assign five[0]=1'b1;


tri_state_32 t1 (.in(one), .oe(isAdd), .out(out));
tri_state_32 t2 (.in(two), .oe(isAddI), .out(out));
tri_state_32 t3 (.in(three), .oe(isSub), .out(out));
tri_state_32 t4 (.in(four), .oe(isMult), .out(out));
tri_state_32 t5 (.in(five), .oe(isDiv), .out(out));
tri_state_32 tx (.in(setXVal), .oe(isSetX), .out(out));


endmodule