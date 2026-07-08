// Code your testbench here
// or browse Examples
module testbench();
  
  reg clk,reset,din;
  wire dout;
  
  debouncer DUT(clk,reset,din,dout);
  initial 
    begin
      {clk,reset,din}=0;
      $dumpfile("dump.vcd");
      $dumpvars();
    end
  
  always #5 clk = ~clk;
  
  initial 
    begin
      reset = 1'b1;
    din = 0;
    #10;
    reset = 0;
    din = 0; 
      #10;
    din = 1;
      #10;
    din = 0;
      #10;
    din = 0;
      #10;
    din = 1;
      #10;
    din = 1; 
      #10;
    din = 0;
      #10;
    din = 1;
      #10;
    din = 1;
      #10;
    din = 0;
      #10;
    din = 0;
      #10;
    #20;
    $finish();
    end
endmodule
  
  