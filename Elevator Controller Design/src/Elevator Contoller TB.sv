// Code your testbench here
// or browse Examples
module testbench();
  
 wire motorstop,moveup,movedown,dooropen;
  wire [1:0] currentfloor;
 
  reg clk,reset,emergencystop;
  reg[3:0]floorreq;
  
  elevatordesign e1(clk,reset,emergencystop,floorreq,motorstop,moveup,movedown,dooropen,currentfloor);
  
  initial 
    begin
      {clk,reset,emergencystop,floorreq}=0;
      $dumpfile("dump.vcd");
      $dumpvars();
    end
 
  always #5 clk = ~clk;
  
  
  initial
   	begin
     reset = 1;
      #10;
      reset = 0;
      floorreq = 4'b0001;
      
      
      #20;
      floorreq = 4'b1000;
      
      
      #40;
      floorreq = 4'b0010;
      
      #76;
      $finish();
      
    end
  
      
      
endmodule
  
  