module mwDecoder(o,d,instruction,data,writeReg,we);

input[31:0]o,d,instruction;
output[31:0] data;
output[4:0] writeReg;
output we;

wire isLW,isR;

assign isLW=~instruction[31]&&instruction[30]&&~instruction[29]&&~instruction[28]&&~instruction[27];

assign data= isLW ?d :o;
assign writeReg=instruction[26:22];

assign isR=~instruction[31]&& ~instruction[30]&& ~instruction[29]&& ~instruction[28]&& ~instruction[27];
assign we=isR || (~instruction[31]&& ~instruction[30]&& instruction[29]&& ~instruction[28]&& instruction[27])||isLW;



endmodule