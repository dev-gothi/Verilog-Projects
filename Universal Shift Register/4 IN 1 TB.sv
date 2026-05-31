// Code your testbench here
// or browse Examples
module testbench();
  reg clk,reset,load,sin;
  reg [1:0]mode;
  reg[3:0]pin;
  wire sout;
  wire [3:0]pout;
  
  universal u1(clk,load,reset,sin,mode,pin,sout,pout);
  
  initial 
    begin
      {clk,load,reset,sin,mode,pin} = 0;
      $dumpfile("dump.vcd"); $dumpvars;
    end
  always #5 clk = ~clk;
  
  initial 
    begin
      reset =1;
      #10;
      reset =0;
      mode = 2'b00;
      sin = 1'b1;
      #10;
      sin = 1'b0;
      #10;
      sin = 1'b0;
      #10;
      sin = 1'b1;
      #10;
      $finish();
    end
endmodule
   
      