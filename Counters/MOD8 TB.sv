// Code your testbench here
// or browse Examples
module testbench();
  
  reg enable,reset,clk;
  wire[2:0]sout;
  
  countermod8 c1(enable,reset,clk,sout);
  
  initial 
    begin
      {enable,reset,clk}=0;
      $dumpfile("dump.vcd");
      $dumpvars;
    end
  
  always #5 clk = ~clk;
  
  initial 
    begin
      reset = 1;
      #10;
      reset = 0;
      enable =1;
      #90;
      enable = 0;
      $finish();
    end
endmodule
      