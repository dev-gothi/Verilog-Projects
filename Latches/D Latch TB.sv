// Code your testbench here
// or browse Examples
module testbench();
  wire ytb,ybartb;
  reg dtb,resettb,enabletb;
  
  dlatch dl1(dtb,resettb,enabletb,ytb,ybartb);
  
  initial
    begin
      {enabletb,resettb,dtb} = 0;
    end
  
  always #5 enabletb = ~enabletb;
  
  initial 
    begin
      resettb = 1;
      #15 resettb = 0;
     
      
      $monitor(" d : %b | y : %b | ybar : %b",dtb,ytb,ybartb);
      
      #5;
      dtb = 1;
      #10;
      dtb = 0;
      
     
    end
endmodule
  