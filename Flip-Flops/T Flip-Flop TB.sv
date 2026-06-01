// Code your testbench here
// or browse Examples
module testbench();
  
  reg clk,reset,tin;
  wire q,qbar;
  
  tff t1(clk,reset,tin,q,qbar);
  
  initial 
    begin
      {clk,reset,tin}=0;
      $dumpfile("dump.vcd");
      $dumpvars();
    end
  
  always #5 clk = ~clk;
  initial 
    begin
      reset =1;
      
      #10;
      reset = 0;
      tin =1;
      
      #20;
      tin=0;
      
      $finish();
    end
endmodule
      