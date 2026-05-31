// Code your design here
module mod3counter(input clk,enable,reset,output reg[1:0]sout);
  
  always @(posedge clk)
    begin
      if(reset)
        begin
          sout <= 2'b00;
        end
      else if(enable)
        begin
          if(sout==2'b10)
            begin
              sout <=0;
            end
          else
            begin
          sout <=sout + 1'b1;
            end
        end
    end
endmodule
          