// Code your design here
module countermod2(input enable,reset,clk,output reg [1:0]sout);
  
  always@(posedge clk)
    begin
      if(reset==1)
        begin
          sout <=2'b00;
        end
      else if(enable==1)
        begin
          sout <= sout + 1'b1;
        end
    end
endmodule