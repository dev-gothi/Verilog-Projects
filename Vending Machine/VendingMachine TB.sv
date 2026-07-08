// Code your testbench here
// or browse Examples
module testbench();
  
  reg clk,reset,coinvalid;
  reg [3:0] coinvalue;
  wire dispense,insufficient;
  wire [4:0] change;
  
  vendingmachine #(.PRICE(5'd15)) DUT(clk,reset,coinvalid,coinvalue,dispense,insufficient,change);
  
  initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars();      {clk,reset,coinvalid,coinvalue}=0;
    end
  
  always #5 clk = ~clk;
  
  initial 
    begin
      reset = 1'b1;
      #10;
      reset = 0;
     
      
      coinvalid = 1'b1;
      coinvalue = 4'd12;
      #10;
      coinvalid = 0;
      #10;
      coinvalid = 1'b1;
      coinvalue = 4'd10;
      #10;
      coinvalid = 0;
      #100;
      
      
      $finish();
    end
endmodule