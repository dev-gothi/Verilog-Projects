// Code your testbench here
// or browse Examples
module testbench();
  reg atb ,btb,stb;
  wire ytb;
  
  muxcase mc1(atb,btb,stb,ytb);
  initial
    begin
      {atb,btb,stb}=0;
      $dumpfile("dump.vcd"); 
      $dumpvars;
    end
  initial
    begin
      for(int m=0;m<8;m++)
        begin
          #1;
          {atb,btb,stb}=m;
          $monitor("atb : %b | btb : %b | stb : %b | ytb : %b",atb,btb,stb,ytb);
        end
      
    end
endmodule