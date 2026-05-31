// Code your design here
module piso (input clk,reset,load,input [3:0]sin,output reg sout);
  reg [3:0]temp;
  
  always@(posedge clk)
    begin
      if(reset)
        begin
          temp <= 4'b0000;
        end
      else if(load==1)
        begin
          temp <= sin;
        end
      else if(load==0)
        begin
          temp <= temp>>1'b1;
          temp[3] <=1'b0;
          sout <= temp[0];
        end
    end
endmodule
      
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
  
  