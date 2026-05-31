// Code your design

module muxcase(input a,b,s,output reg y);
  
  always@(*)
    begin
      case(s)
        0 : y = a;
        1 : y = b;
        
        default : y=0;
      endcase
    end
endmodule