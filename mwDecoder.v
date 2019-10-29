module mwDecoder(o,d,instruction,data,writeReg,we);

input[31:0]o,d,instruction;
output[31:0] data;
output[4:0] writeReg;
output we;

wire isLW,isR,isJal;

assign isLW=~instruction[31]&&instruction[30]&&~instruction[29]&&~instruction[28]&&~instruction[27];

assign isJal=(~instruction[31]&~instruction[30]&~instruction[29]&instruction[28]&instruction[27]);


assign data= isLW ?d :o;
assign writeReg=isJal?{5{1'b1}} :instruction[26:22];

assign isR=~instruction[31]&& ~instruction[30]&& ~instruction[29]&& ~instruction[28]&& ~instruction[27];
assign we=isR|isJal| (~instruction[31]&& ~instruction[30]&& instruction[29]&& ~instruction[28]&& instruction[27])|isLW;



endmodule