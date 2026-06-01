// Code your testbench here
// or browse Examples
module testbench();
  
  reg clk,reset,s,r;
  wire q,qbar;
  
  SRff SR1(clk,reset,s,r,q,qbar);
  
  initial 
    begin
      {clk,reset,s,r}=0;
      $dumpfile("dump.vcd");
      $dumpvars();
    end
  
  always #5 clk = ~clk;
  initial 
    begin
      reset =1;
      
      #10;
      reset = 0;
      s =0;
      r=0;
      
      #20;
      s = 1;
      r=0;
      
      #40;
      s=0;
      r=1;
      
      #60;
      s=1;
      r=1;
      
      
      
      $finish();
    end
endmodule
      