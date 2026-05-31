// Code your testbench here
// or browse Examples
module testbench();
  wire y,ybar;
  reg t,enable,reset;
  
  tlatch t1(t,enable,reset,y,ybar);
  
  initial 
    begin
      {t,enable,reset}=0;
    end
  
  always #10 enable = ~enable;
  
  initial
    begin
       $monitor("t : %b | y : %b | ybar : %b",t,y,ybar);
      reset = 1;
      #20;
           

      reset = 0;
      #20;
      t=1;
      #20;
      t=0;
    end
endmodule
      