// Code your design here
module dff(input clk,reset,din,output reg q,qbar);
  
  always@(posedge clk)
    begin
      if(reset)
        begin
        q<= 0;
      	qbar<= 1'b1;
        end
      
      else
        begin
          q  <= din;
          qbar <= ~din;
        end
    end
endmodule