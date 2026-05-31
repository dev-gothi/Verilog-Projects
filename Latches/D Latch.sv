// Code your design here
module dlatch(input d,reset,enable,output reg y,ybar);
  
  always @(enable)
    begin
      if(enable)
        begin
          if(reset)
            begin
              y <= 1'b0;
              ybar <= 1'b1;
            end
          else
            begin
              y <= d;
              ybar <= ~d;
              
            end
        end
    end
endmodule