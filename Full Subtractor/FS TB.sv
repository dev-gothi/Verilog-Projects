// Code your testbench here
// or browse Examples
module testbench();
  reg atb,btb,ctb;
  wire difftb,borrowtb;
  
  fullsubtractor fs(atb,btb,ctb,difftb,borrowtb);
  
  initial
    begin
     
      atb = 1'b0;
       btb = 1'b0;
       ctb = 1'b0;
    end
  
  initial
    begin
        $dumpfile("dump.vcd");
    $dumpvars(0, testbench);
     $monitor("atb=%b btb=%b ctb=%b | diff=%b borrow=%b",
              atb, btb, ctb, difftb, borrowtb);
      atb =1'b1;
      btb =1'b0;
      ctb = 1'b1;
      #1;
      
        atb =1'b1;
      btb =1'b1;
      ctb = 1'b1;
      #1;
        atb =1'b0;
      btb =1'b0;
      ctb = 1'b1;
      #1;
        atb =1'b1;
      btb =1'b0;
      ctb = 1'b0;
      #1;
        atb =1'b0;
      btb =1'b0;
      ctb = 1'b0;
      #1;
      
    end
endmodule