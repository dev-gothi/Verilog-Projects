// Code your testbench here
// or browse Examples
module testbench();
  
  wire sout;
  reg sin,enable,reset,clk;
  
  siso s1(sin,enable,reset,clk,sout);
  
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars;
      {sin,enable,reset,clk}=0;
    end
  
  always #5 clk = ~clk;
  
  initial
    begin
      reset =1;
      #10;
      reset =0;
      enable = 0;
      #10;
      enable =1;
      
      sin = 1'b1;
      #10;
       sin = 1'b0;
      #10;
       sin = 1'b0;
      #10;
       sin = 1'b1;
      #50;
      enable =0;
      $finish();
    end
endmodule
      
  