// Code your testbench here
// or browse Examples
module testbench();
  
  reg enabletb,resettb,clktb;
  wire [1:0]souttb;
  
  countermod4 c1(enabletb,resettb,clktb,souttb);
  
  initial 
    begin
      {enabletb,resettb,clktb}=0;
      $dumpfile("dump.vcd"); $dumpvars;
      
    end
  
  always #5 clktb = ~clktb;
  
  initial 
    begin
      resettb = 1;
      #10;
      
      resettb = 0;
      enabletb = 1;
      #30;
      enabletb = 0;
      $finish();
    end
endmodule
      
      
  