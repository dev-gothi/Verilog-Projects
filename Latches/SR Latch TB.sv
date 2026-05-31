// Code your testbench here
// or browse Examples
module testbench();
  wire qtb,qbartb;
  reg enabletb,resettb,stb,rtb;
  
  srlatch sr1(enabletb,resettb,stb,rtb,qtb,qbartb);
  
  initial
    begin
      {enabletb,resettb,stb,rtb}=0;
    end
  
always #5 enabletb = ~enabletb;
  
  initial
    begin
      
      resettb = 1;
      #10;
      resettb = 0;
       $monitor("s : %b | r : %b | q : %b | qbar : %b ",stb,rtb,qtb,qbartb);
      //hold condition
      stb=0;
      rtb=0;
      
      //setcondition
      //10 is added before every because it is a clock pulse of enable in which it will change its value
      #10;
      stb=1;
      rtb=0;
      
      //reset condition
      #10;
      stb=0;
      rtb=1;
      
      //invalid condition
      
      #10;
      stb=1;
      rtb=1;
      
     
    end
  
endmodule
      
  
    