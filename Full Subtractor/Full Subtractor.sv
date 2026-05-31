// Code your design here
module fullsubtractor(input a,b,c,output reg diff,borrow);
  
  always @(*)
    begin
      diff = a ^ b ^ c;
      borrow = ((~a) ^ b) & c | (~a) & b;
    end
endmodule

