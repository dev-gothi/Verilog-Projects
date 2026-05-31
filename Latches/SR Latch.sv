// Code your design here
module srlatch(input enable,reset,s,r,output reg q,qbar);
  
  always@(enable)
    //for asynchronous reset include reset in the always block parameter with enable
    //if of the reset will be outside the if of the enable block
    begin
    if(enable)
      begin
        
    if(reset)
      begin
        q =1'b0;
        qbar =1'b1;
      end
  else if(s==0 && r==0)
    begin
      q <=q;
      qbar<=qbar;
    end
  else if(s==1 && r==0)
    begin
      q<=1'b1;
      qbar <=1'b0;
    end
  
  else if(s==0 && r==1)
    begin
      q<=1'b0;
      qbar <= 1'b1;
    end
   
  else if(s==1 && r==1)
    begin
      q<=1'bx;
      qbar <= 1'bx;
    end
      end
    end
  
  
endmodule
   
 