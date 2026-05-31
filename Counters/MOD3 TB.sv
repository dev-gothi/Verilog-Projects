// Code your testbench here
// or browse Examples
module testbench();
  reg clk,enable,reset;
  wire [1:0]sout;
  
  mod3counter m3(clk,enable,reset,sout);
  
  initial 
    begin
      {clk,enable,reset}=0;
      $dumpfile("dump.vcd"); $dumpvars;
    end
  
  always #5 clk = ~clk;
  
  initial
    begin
      reset = 1;
      #10;
      reset =0;
      enable=1;
      
      #30;
      enable =0;
      $finish();
    end
endmodule
      