// Code your design here
module dutycycle(input clk,enable,reset,output fdiv5);
  
  reg[3:0]sout;
  reg enable1,enable2;
  
  always@(posedge clk)
    begin
      if(reset)
        begin
          sout<=0;
          enable1<=0;
        end
      else if(enable==1)
      begin
        
        if(sout==3'b000 | sout==3'b001)
          begin
            enable1<=1'b1;
          end
        else
          begin
          enable1<=0;
          end
         if(sout==4'b100)
        begin
          sout<=0;
          
        end
        else
          begin
            sout<=sout + 1'b1;
          end
      end
    end
  
  
  
  
      
    
    


always@(negedge clk)
  begin
    if(reset)
      enable2<=0;
    
    
    else if(enable)
      begin
         if(sout==3'b000 | sout==3'b001)
          begin
            enable2<=1'b1;
          end
        else
          begin
          enable2<=0;
          end
        
        
      end
    
    
    
    
  end

assign fdiv5 = enable1 | enable2;
endmodule
        