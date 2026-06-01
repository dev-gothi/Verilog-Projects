// Code your testbench here
// or browse Examples
module testbench();
  
  reg clk,reset,din;
  wire q,qbar;
  
  dff d1(clk,reset,din,q,qbar);
  
  initial 
    begin
      {clk,reset,din}=0;
      $dumpfile("dump.vcd");
      $dumpvars();
    end
  
  always #5 clk = ~clk;
  initial 
    begin
      reset =1;
      
      #10;
      reset = 0;
      din =1;
      
      #10;
      din = 0;
      
      $finish();
    end
endmodule
      