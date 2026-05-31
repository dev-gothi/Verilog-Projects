// Code your testbench here
// or browse Examples
module testbench();
  
  reg clk,reset,wenable;
  reg [2:0]waddress,raddress;
  reg[7:0]datain;
  wire[7:0]dataout;
  
  ram r1(clk,reset,wenable,waddress,raddress,datain,dataout);
  
  initial
    begin
      {clk,reset,wenable,waddress,raddress,datain}=0;
      $dumpfile("dump.vcd");
      $dumpvars;
    end
  
  always #5 clk = ~clk;
  
  initial
    begin
      reset=1;
      #10;
      reset=0;
      wenable = 1;
      waddress = 3'b110;
      datain = 5;
      
      #10;
      wenable = 1;
      waddress = 3'b101;
      datain = 10;
      #10;
      wenable = 0;
      raddress = 3'b110;
      
      #50;
      
      raddress = 3'b101;
      #10
      
      raddress = 3'b100;
      #20;
      
      $finish();
    end
endmodule