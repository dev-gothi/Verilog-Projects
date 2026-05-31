// Code your testbench here
// or browse Examples
module testbench();
  
  reg clk,enable,reset;
  reg [1:0]mod;
  wire mod2cout;
  wire [1:0]mod4cout;
  wire [2:0]mod8cout;
  wire [3:0]mod16cout;
  
  multiplemod mm1(enable,clk,reset,mod,mod2cout,mod4cout,mod8cout,mod16cout);
  
  initial
    begin
      {enable,clk,reset,mod}=0;
      $dumpfile("dump.vcd");
      $dumpvars;
    end
  
  always #5 clk = ~clk;
  
  initial
    begin
      $monitor("t=%0t | mod=%b | out2=%b out4=%b out8=%b out16=%b",
          $time, mod, mod2cout, mod4cout, mod8cout, mod16cout);
      reset = 1;
      #10;
      reset =0;
      enable=1;
      mod=2'b00;
      
      #20;
      mod = 2'b01;
      
      #60;
      mod = 2'b10;
      
      #150;
      mod = 2'b11;
      
      
      #350;
      enable=0;
      $finish();
    end
endmodule
      
      