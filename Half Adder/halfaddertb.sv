// Code your testbench here
// or browse Examples
module testbench;
  //step1
 reg atb,btb;
  wire sumtb,carrytb;
  //step2
  halfadderb tb(atb,btb,sumtb,carrytb);
  //step3
  initial 
    begin
      atb= 2'b00;
      btb = 2'b00;
    end 
  //step4
  initial 
    begin
       atb =0;
      btb =1;
     #1;
      $display("The value of sum is %d and carry is %d",sumtb,carrytb);
      
    end
      endmodule