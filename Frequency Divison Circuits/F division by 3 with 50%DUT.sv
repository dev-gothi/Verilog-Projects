// Code your design here
module fdiv3with50(input enable,clk,reset,output fdiv3);
  reg[2:0]cout;
  reg enable1,enable2;
  
  
  always@(posedge clk)
    begin
      if(reset)
        begin
          cout <=2'b00;
          enable1<=1'b0;
          
        end
      else if(enable)
        begin
          if(cout ==2'b10)
            begin
              cout<=2'b00;
            end
          else
            begin
              cout<=cout + 1'b1;
            end
          
          if(cout==0)
            begin
             enable1<=1'b1;
            end
      else
        begin
        enable1<=1'b0;
    end
        end
    end
  
        
      
  
  always@(negedge clk)
    begin
      if(reset)
        begin
          enable2<=1'b0;
        end
      
      else if(enable)
        begin
       if(cout==0 )
        enable2<=1'b1;
      else
        enable2<=1'b0;
    end
    end
  
  
    
  
  assign fdiv3 = enable1 | enable2;
  
  
endmodule
      
      