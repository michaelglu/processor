module mwDecoder(o,d,instruction,data,writeReg,we,ovf);

input ovf;
input[31:0]o,d,instruction;
output[31:0] data;
output[4:0] writeReg;
output we;

wire isLW,isR,isJal,isSetX;
wire [31:0]data_normal,data_normal_setx,one,two,three,exceptionOut,dataSetX;
wire [4:0]writeReg_normal;
assign isLW=~instruction[31]&&instruction[30]&&~instruction[29]&&~instruction[28]&&~instruction[27];

assign isJal=(~instruction[31]&~instruction[30]&~instruction[29]&instruction[28]&instruction[27]);

assign isSetX=(instruction[31]&~instruction[30]&instruction[29]&~instruction[28]&instruction[27]);

assign dataSetX[31:27]={5{1'b0}};
assign dataSetX[26:0]=instruction[26:0];

wire [4:0]r30;

assign r30[4:1]={4{1'b1}};
assign r30[0]=1'b0;

assign data_normal= isLW ?d :o;
assign data_normal_setx = isSetX ? dataSetX : data_normal;
assign writeReg_normal=isJal? r30 :instruction[26:22];

assign one[31:1]={31{1'b0}};
assign one[0]=1'b1;
assign two[31:2]={30{1'b0}};
assign two[1]=1'b1;
assign two[0]=1'b0;
assign three[31:2]={30{1'b0}};
assign three[1:0]={2{1'b1}};

wire[31:0]eA,eB;
assign eA=(~instruction[2]) ? one :three;
assign eB= (~instruction[31]&~instruction[30]&~instruction[29]&~instruction[28]&~instruction[27]) ? eA : two;



assign data = ovf ? eB : data_normal_setx;
assign writeReg = (ovf|isSetX) ? {5{1'b1}} :writeReg_normal;

assign isR=~instruction[31]&& ~instruction[30]&& ~instruction[29]&& ~instruction[28]&& ~instruction[27];
assign we=isR|isJal| (~instruction[31]&& ~instruction[30]&& instruction[29]&& ~instruction[28]&& instruction[27])|isLW|ovf|isSetX;



endmodule