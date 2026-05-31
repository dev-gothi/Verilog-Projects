// Code your design here
module pipo(input clk,reset,load,input [3:0]sin,output reg [3:0]sout);
  reg[3:0]temp;
  
  always@(posedge clk)
    begin
      if(reset)
        begin
          temp <=4'b0000;
        end
      else if(load==1)
        begin
          temp<=sin;
        end
      
      else if(load ==0)
        begin
        
          sout <=temp;
        end
    end
endmodule
          
          
          
          
          
          
          
          
          
          
        
          
  