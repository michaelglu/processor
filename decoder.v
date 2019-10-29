module decoder(i,out);

input[4:0]i;
output [31:0]out;

wire[4:0]c;
not(c[0],i[0]);
not(c[1],i[1]);
not(c[2],i[2]);
not(c[3],i[3]);
not(c[4],i[4]);

and(out[0],c[4],c[3],c[2],c[1],c[0]);
and(out[1],c[4],c[3],c[2],c[1],i[0]);
and(out[2],c[4],c[3],c[2],i[1],c[0]);
and(out[3],c[4],c[3],c[2],i[1],i[0]);

and(out[4],c[4],c[3],i[2],c[1],c[0]);
and(out[5],c[4],c[3],i[2],c[1],i[0]);
and(out[6],c[4],c[3],i[2],i[1],c[0]);
and(out[7],c[4],c[3],i[2],i[1],i[0]);


and(out[8],c[4],i[3],c[2],c[1],c[0]);
and(out[9],c[4],i[3],c[2],c[1],i[0]);
and(out[10],c[4],i[3],c[2],i[1],c[0]);
and(out[11],c[4],i[3],c[2],i[1],i[0]);

and(out[12],c[4],i[3],i[2],c[1],c[0]);
and(out[13],c[4],i[3],i[2],c[1],i[0]);
and(out[14],c[4],i[3],i[2],i[1],c[0]);
and(out[15],c[4],i[3],i[2],i[1],i[0]);
//_____________________________________
and(out[16],i[4],c[3],c[2],c[1],c[0]);
and(out[17],i[4],c[3],c[2],c[1],i[0]);
and(out[18],i[4],c[3],c[2],i[1],c[0]);
and(out[19],i[4],c[3],c[2],i[1],i[0]);

and(out[20],i[4],c[3],i[2],c[1],c[0]);
and(out[21],i[4],c[3],i[2],c[1],i[0]);
and(out[22],i[4],c[3],i[2],i[1],c[0]);
and(out[23],i[4],c[3],i[2],i[1],i[0]);


and(out[24],i[4],i[3],c[2],c[1],c[0]);
and(out[25],i[4],i[3],c[2],c[1],i[0]);
and(out[26],i[4],i[3],c[2],i[1],c[0]);
and(out[27],i[4],i[3],c[2],i[1],i[0]);

and(out[28],i[4],i[3],i[2],c[1],c[0]);
and(out[29],i[4],i[3],i[2],c[1],i[0]);
and(out[30],i[4],i[3],i[2],i[1],c[0]);
and(out[31],i[4],i[3],i[2],i[1],i[0]);


endmodule