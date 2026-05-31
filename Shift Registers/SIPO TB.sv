// Code your testbench here
// or browse Examples
module testbench();
  
  wire [3:0]sout;
  reg sin,enable,reset,clk;
  
 sipo sp1(sin,enable,reset,clk,sout);
  
  initial
    begin
      
      {sin,enable,reset,clk}=0;
       $dumpfile("dump.vcd");$dumpvars;
    end
  
  always #5 clk = ~clk;
  
  initial
    begin
      reset =1;
      #10;
      reset =0;
      enable = 0;
      #10;
      
      
      sin = 1'b1;
      #10;
       sin = 1'b0;
      #10;
       sin = 1'b0;
      #10;
       sin = 1'b1;
      #10;
      enable =1;
    end
endmodule
      
  