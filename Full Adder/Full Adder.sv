// Code your design here
module fulladder(input a,b,c,output reg sum,carry);
  
  always@(*)
    begin
      sum = a ^ b ^ c;	
      carry = (a ^ b) & c | a & b;
    end 
endmodule