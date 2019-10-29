module xmDecoder (instruction,we);

input[31:0]instruction;
output we;

assign we = ~instruction[31]&~instruction[30]&instruction[29]&instruction[28]&instruction[27];

endmodule