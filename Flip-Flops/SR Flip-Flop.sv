// Code your design here

module SRff(input clk,reset,s,r,output reg q,qbar);
  
  always@(posedge clk)
    begin
      if(reset)
        begin
        q<= 0;
      	qbar<= 1'b1;
        end
      
      
      //Hold condition
      else if(s==0 && r==0)
        begin
          q  <= q;
          qbar <= qbar;
        end
      
      //reset condition
      else if(s==0 && r==1)
        begin
          q<=0;
          qbar<=1'b1;
          
        end
      
      // set condition
      else if(s==1 && r==0)
        begin
          q<=1'b1;
          qbar<=0;
        end
      
      //toggle condition
      else 
        begin
          q  <= 'bx;
          qbar <= 'bx;
        end
      
      
    end
endmodule