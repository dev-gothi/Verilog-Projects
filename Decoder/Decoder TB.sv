// Code your testbench here
// or browse Examples
module testbench();
  wire [3:0]dtb;
  reg [1:0]ytb;
  
  decoder d1(ytb,dtb);
  initial
    begin
     ytb = 0;
      $dumpfile("dump.vcd"); $dumpvars;
    end
  
  initial 
    begin
      for(int i=0;i<4;i++)
        begin
           #1;
          ytb = i;
         
          $monitor(" y[1]=%b y[0]=%b | d[3]=%b d[2]=%b d[1]=%b d[0]=%b ",ytb[1],ytb[0], dtb[3],dtb[2],dtb[1],dtb[0]);
          
        end
    end
endmodule
      