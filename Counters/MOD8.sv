// Code your design here
// Code your design here
module countermod8(input enable,reset,clk,output reg [2:0]sout);
  
  always@(posedge clk)
    begin
      if(reset==1)
        begin
          sout <=3'b000;
        end
      else if(enable==1)
        begin
          sout <= sout + 1'b1;
        end
    end
endmodule