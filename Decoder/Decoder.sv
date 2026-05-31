// Code your design here
module decoder(input [1:0]y,output reg [3:0]d);
  always@(*)
    begin
      
      if(y == 2'b00)
      d = 4'b0001;
      else if(y==2'b01)
        d = 4'b0010;
      else if(y == 2'b10)
        d = 4'b0100;
      else if(y == 2'b11)
        d = 4'b1000;
      else
        d = 4'b0000;
    end
endmodule
  
  
          
        
          