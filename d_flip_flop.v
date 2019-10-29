module d_flip_flop(q, d, clk, ena, aclr);
   
   //Inputs
   input d, clk, ena, aclr;
   
   //Internal wire
   wire aclr;

   //Output
   output q;
   
   //Register
   reg q;

   //Intialize q to 0
   initial
   begin
       q = 1'b0;
   end

   //Set value of q on positive edge of the clock or clear
   always @(posedge clk or posedge aclr) begin
       //If clear is high, set q to 0
       if (aclr) begin
           q <= 1'b0;
       //If enable is high, set q to the value of d
       end else if (ena) begin
           if(clk) begin
			  q <= d;
			  end
       end
   end
endmodule