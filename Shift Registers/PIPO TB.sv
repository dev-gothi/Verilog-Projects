// Code your testbench here
// or browse Examples
module testbench();

reg clk,reset,load;
reg[3:0]sin;

wire [3:0]sout;

pipo dut(clk,reset,load,sin,sout);
  
initial
  begin
    {clk,reset,load,sin}=0;
        $dumpfile("dump.vcd");
    $dumpvars(0, testbench);
  end

always #5 clk = ~clk;

initial 
  begin
    reset = 1;
    #10;
    reset = 0;
     sin = 4'b1011;
    load = 1;b1;
   
    
    #10;
    load = 1'b0;
    $finish;
  end
endmodule
    