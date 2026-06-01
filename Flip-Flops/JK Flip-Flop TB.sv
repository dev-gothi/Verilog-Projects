// Code your testbench here
// or browse Examples
module testbench();
  
  reg clk,reset,j,k;
  wire q,qbar;
  
  JKff JK1(clk,reset,j,k,q,qbar);
  
  initial 
    begin
      {clk,reset,j,k}=0;
      $dumpfile("dump.vcd");
      $dumpvars();
    end
  
  always #5 clk = ~clk;
  initial 
    begin
      reset =1;
      
      #10;
      reset = 0;
      j =1;
      k=0;
      
      #20;
      j = 0;
      k=1;
      
      #40;
      j=1'b1;
      k=1'b1;
      
      
      
      $finish();
    end
endmodule
      