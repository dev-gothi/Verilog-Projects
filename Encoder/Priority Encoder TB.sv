// Code your testbench here
// or browse Examples
module testbench();
  reg [3:0]dtb;
  wire [1:0]ytb;
  
  priorityencoder pe1(dtb,ytb);
  initial
    begin
     dtb = 0;
      $dumpfile("dump.vcd"); $dumpvars;
    end
  
  initial 
    begin
      for(int i=0;i<4;i++)
        begin
           #1;
          //dtb = (4'b0001 << i);
          dtb[i] = 1;
         
         
         $monitor("d[3]=%b d[2]=%b d[1]=%b d[0]=%b | y[1]=%b y[0]=%b", dtb[3],dtb[2],dtb[1],dtb[0],ytb[1],ytb[0]);
          
        end
    end
endmodule
      