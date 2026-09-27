module tb;
  reg clk, reset, txstart;
  reg [7:0] datain;
  wire txbusy, txdone, rxbusy, rxdone, error;
  wire [7:0] rxdata;

  uarttop DUT(clk,reset,txstart,datain,txbusy,txdone,rxbusy,rxdone,error,rxdata);

 initial 
   begin
     {clk,reset,txstart}=0;
     $dumpfile("dump.vcd");
     $dumpvars();
     
   end
  
  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
   
    reset = 1;
   

    #20;
    reset = 0;     
    #20;
    txstart = 1;
    datain = 8'hDD;
    #10 
    txstart = 0;    
    #10000;         //as 960 cycles needed so running for rough time around 10000    

    if(rxdata == datain)
      $display("PASS: rxdata = %h matches datain = %h", rxdata, datain);
    else
      $display("FAIL: rxdata = %h, expected %h", rxdata, datain);

    $finish;
  end

endmodule