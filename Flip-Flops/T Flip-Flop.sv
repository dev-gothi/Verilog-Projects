// Code your design here
module tff(input clk,reset,tin,output reg q,qbar);
  
  always@(posedge clk)
    begin
      if(reset)
        begin
        q<= 0;
      	qbar<= 1'b1;
        end
      
      else if(tin==0)
        begin
          q  <= q;
          qbar <= qbar;
        end
      else if(tin==1)
        begin
          q<=qbar;
          qbar<=q;
        end
      
          
    end
endmodule