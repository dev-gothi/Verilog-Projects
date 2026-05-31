// Code your design here
module sipo(input sin,enable,reset,clk,output reg [3:0]sout);
  reg [3:0]temp;
  always@(posedge clk)
  begin
    if(reset)
      begin
        temp<=4'b0000;
      end
    
    else if(enable==0)
      begin
       temp<= temp>>1'b1;
        temp[3] <= sin;
      end
    else if(enable==1)
      begin
        sout <=temp;
      end
    
  end
endmodule
       
        