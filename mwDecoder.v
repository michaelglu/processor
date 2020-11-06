module mwDecoder(o_top,d_top,instruction_top,data_top,writeReg_top,we_top,ovf_top,
					  o_bot,d_bot,instruction_bot,data_bot,writeReg_bot,we_bot,ovf_bot);

input ovf_top;
input[31:0]o_top,d_top,instruction_top;
output[31:0] data_top;
output[4:0] writeReg_top;
output we_top;

wire isLW_top,isR_top,isJal_top,isSetX_top;
wire [31:0]data_top_normal,data_top_normal_setx,one,two,three,exceptionOut_top,data_topSetX;
wire [4:0]writeReg_top_normal;
assign isLW_top=~instruction_top[31]&&instruction_top[30]&&~instruction_top[29]&&~instruction_top[28]&&~instruction_top[27];

assign isJal_top=(~instruction_top[31]&~instruction_top[30]&~instruction_top[29]&instruction_top[28]&instruction_top[27]);

assign isSetX_top=(instruction_top[31]&~instruction_top[30]&instruction_top[29]&~instruction_top[28]&instruction_top[27]);

assign data_topSetX[31:27]={5{1'b0}};
assign data_topSetX[26:0]=instruction_top[26:0];

wire [4:0]r30_top;

assign r30_top[4:1]={4{1'b1}};
assign r30_top[0]=1'b0;

assign data_top_normal= isLW_top ?d_top :o_top;
assign data_top_normal_setx = isSetX_top ? data_topSetX : data_top_normal;
assign writeReg_top_normal=isJal_top? {5{1'b1}} :instruction_top[26:22];

assign one[31:1]={31{1'b0}};
assign one[0]=1'b1;
assign two[31:2]={30{1'b0}};
assign two[1]=1'b1;
assign two[0]=1'b0;
assign three[31:2]={30{1'b0}};
assign three[1:0]={2{1'b1}};

wire[31:0]eA_top,eB_top;
assign eA_top=(~instruction_top[2]) ? one :three;
assign eB_top= (~instruction_top[31]&~instruction_top[30]&~instruction_top[29]&~instruction_top[28]&~instruction_top[27]) ? eA_top : two;





assign data_top = ovf_top ? eB_top : data_top_normal_setx;
assign writeReg_top = (ovf_top|isSetX_top) ? r30_top :writeReg_top_normal;

assign isR_top=~instruction_top[31]&& ~instruction_top[30]&& ~instruction_top[29]&& ~instruction_top[28]&& ~instruction_top[27];
assign we_top=isR_top|isJal_top| (~instruction_top[31]&& ~instruction_top[30]&& instruction_top[29]&& ~instruction_top[28]&& instruction_top[27])|isLW_top|ovf_top|isSetX_top;

//bot
input ovf_bot;
input[31:0]o_bot,d_bot,instruction_bot;
output[31:0] data_bot;
output[4:0] writeReg_bot;
output we_bot;

wire isLW_bot,isR_bot,isJal_bot,isSetX_bot;
wire [31:0]data_bot_normal,data_bot_normal_setx,exceptionOut_bot,data_botSetX;
wire [4:0]writeReg_bot_normal;
assign isLW_bot=~instruction_bot[31]&&instruction_bot[30]&&~instruction_bot[29]&&~instruction_bot[28]&&~instruction_bot[27];

assign isJal_bot=(~instruction_bot[31]&~instruction_bot[30]&~instruction_bot[29]&instruction_bot[28]&instruction_bot[27]);

assign isSetX_bot=(instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&~instruction_bot[28]&instruction_bot[27]);

assign data_botSetX[31:27]={5{1'b0}};
assign data_botSetX[26:0]=instruction_bot[26:0];

wire [4:0]r30_bot;

assign r30_bot[4:1]={4{1'b1}};
assign r30_bot[0]=1'b0;

assign data_bot_normal= isLW_bot ?d_bot :o_bot;
assign data_bot_normal_setx = isSetX_bot ? data_botSetX : data_bot_normal;
assign writeReg_bot_normal=isJal_bot? {5{1'b1}} :instruction_bot[26:22];


wire[31:0]eA_bot,eB_bot;
assign eA_bot=(~instruction_bot[2]) ? one :three;
assign eB_bot= (~instruction_bot[31]&~instruction_bot[30]&~instruction_bot[29]&~instruction_bot[28]&~instruction_bot[27]) ? eA_bot : two;





assign data_bot = ovf_bot ? eB_bot : data_bot_normal_setx;
assign writeReg_bot = (ovf_bot|isSetX_bot) ? r30_bot :writeReg_bot_normal;

assign isR_bot=~instruction_bot[31]&& ~instruction_bot[30]&& ~instruction_bot[29]&& ~instruction_bot[28]&& ~instruction_bot[27];
assign we_bot=isR_bot|isJal_bot| (~instruction_bot[31]&& ~instruction_bot[30]&& instruction_bot[29]&& ~instruction_bot[28]&& instruction_bot[27])|isLW_bot|ovf_bot|isSetX_bot;




endmodule