// Code your design here
module tlatch(input t,enable,reset,output reg y,ybar);
  always @(enable)
    begin
      if(enable)
        begin
          if(reset)
            begin
              y <= 1'b0;
              ybar <= 1'b1;
            end
          else if(t==1'b0)
            begin
              y <= y;
              ybar <= ~y;
            end
          else if(t==1'b1)
        	begin
               y <= ~y;
              ybar <= y;
            end
        end
    end
endmodule
              
