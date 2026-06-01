// Code your design here

module JKff(input clk,reset,j,k,output reg q,qbar);
  
  always@(posedge clk)
    begin
      if(reset)
        begin
        q<= 0;
      	qbar<= 1'b1;
        end
      
      
      //Hold condition
      else if(j==0 && k==0)
        begin
          q  <= q;
          qbar <= qbar;
        end
      
      //reset condition
      else if(j==0 && k==1)
        begin
          q<=0;
          qbar<=1'b1;
          
        end
      
      // set condition
      else if(j==1 && k==0)
        begin
          q<=1'b1;
          qbar<=0;
        end
      
      //toggle condition
      else 
        begin
          q  <= qbar;
          qbar <= q;
        end
      
      
    end
endmodule