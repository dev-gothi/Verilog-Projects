// Code your testbench here
// or browse Examples
module testbench();
  reg [1:0] itb;
  reg stb;
  wire ytb;
  
  mux m1(itb[0],itb[1],stb,ytb);
  
  initial
    begin
      {itb,stb}=0;
      $dumpfile("dump.vcd"); 
      $dumpvars;
    end
  
  initial 
    begin
      for(int m=0;m<8;m++)
        begin
          #1;
          {stb,itb}=m;
          $monitor("itb[1] : %b | itb[0] : %b | stb : %b | ytb : %b",itb[1],itb[0],stb,ytb);
        end 
      
   
    end
endmodule
          
  
  