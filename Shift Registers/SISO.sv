// Code your design here
module siso(input sin,enable,reset,clk,output reg sout);
  reg [3:0]temp;
  
  always @(posedge clk)
    begin
      if(reset)
        begin
          temp<=4'b0000;
        end
      //by shift operator
//       else if(enable)
//         begin
//           temp<= temp>>1'b1;
//           temp[3]<=sin;
//           sout <= temp[0];
//         end
      
      //by concatenation operator
      
      else if(enable)
        begin
          temp <={sin,temp[3:1]};
           temp[3]<=sin;
          sout <= temp[0];
        end
    end
endmodule
          