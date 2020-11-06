module xmDecoder (instruction_top,instruction_bot,we_top,we_bot,mem_top,mem_bot);

input[31:0]instruction_top,instruction_bot;
output we_top,we_bot,mem_top,mem_bot;

assign we_top = ~instruction_top[31]&~instruction_top[30]&instruction_top[29]&instruction_top[28]&instruction_top[27];
assign we_bot = ~instruction_bot[31]&~instruction_bot[30]&instruction_bot[29]&instruction_bot[28]&instruction_bot[27];

assign mem_top = we_top|(~instruction_top[31]&instruction_top[30]&~instruction_top[29]&~instruction_top[28]&~instruction_top[27]);
assign mem_bot= we_bot | (~instruction_bot[31]&instruction_bot[30]&~instruction_bot[29]&~instruction_bot[28]&~instruction_bot[27]);

endmodule