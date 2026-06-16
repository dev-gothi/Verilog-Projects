// Code your testbench here
// or browse Examples
module testbench();
  
  wire alarm,dooropen;
  reg clk,reset,setmode;
  reg [3:0]password;
  reg [3:0]newpassword;
  
  digitaldoorlock d1(clk,reset,setmode,password,newpassword,alarm,dooropen);
  
  initial 
    begin
      {clk,reset,setmode,password,newpassword}=0;
      $dumpfile("dump.vcd");
      $dumpvars();
      
    end
  
  always #5 clk = ~clk;
  
  initial 
    begin
      #10;
      reset = 1;
      #10;
      reset = 0;
      setmode = 0;
      password = 4'b1111;
      
      
      #10;
      password = 4'b1010;
      
      #10;
      password = 4'b1101;
      #10;
      reset = 1;
     
     #10;
      reset = 0;
       password = 4'b0101;
      #10;
      
       setmode = 1;
      newpassword = 4'b1100;
      
      #20;
      setmode = 0;
      password = 4'b1100;
      
      #40;
      $finish();
      
    end
endmodule
  