// Code your design here
module ram(input clk,reset,wenable,input [2:0]waddress,raddress,input [7:0]din,output reg [7:0]dout);
  //it has 8 location and each has 8 bits
  reg[7:0]temp[7:0];
  
  always@(posedge clk)
    begin
      if(reset)
       begin
         for(int i=0;i<7;i++)
           begin
           temp[i]<=0;
           end
         
       end
      else if(wenable==1)
        begin
          temp[waddress]<=din;
        end
      
      else if(wenable==0)
        begin
          dout<=temp[raddress];
        end
    end
endmodule
          