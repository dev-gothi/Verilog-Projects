// Code your design here
// Code your design here
module mod5counter(input clk,enable,reset,output reg[2:0]sout);
  
  always @(posedge clk)
    begin
      if(reset)
        begin
          sout <= 3'b000;
        end
      else if(enable)
        begin
          if(sout==3'b100)
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
          