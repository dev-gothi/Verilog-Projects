// Code your testbench here
// or browse Examples
module testbench();
  
  reg clk,reset,wenable,outenable;
  reg cs1,cs2,cs3,cs4;
  
  reg[2:0]address ;
  wire [7:0]data;
  reg [7:0]datatemp;
  
  ramdecoder rd1(clk,reset,wenable,outenable,cs1,address,data);
  ramdecoder rd2(clk,reset,wenable,outenable,cs2,address,data); ramdecoder rd3(clk,reset,wenable,outenable,cs3,address,data); ramdecoder rd4(clk,reset,wenable,outenable,cs4,address,data);
  
  
  always @(*)
    begin
      
      /*
      
      lsb bit of the address is used for the cs selection
      and accordingly rd1,rd2,rd3,rd4 datatemp that is the memory data stored will be changed an differant ram will be utilised 
      
      */
      if(address==2'b00)
        begin
          cs1 = 1'b1;
          {cs2,cs3,cs4}=0;
        end
      
      else if(address==2'b01)
        begin
           cs2 = 1'b1;
          {cs1,cs3,cs4}=0;
        end
      
      else if(address==2'b10)
        begin
           cs3 = 1'b1;
          {cs1,cs2,cs4}=0;
        end
      
      else if(address==2'b11)
        begin
           cs4 = 1'b1;
          {cs1,cs2,cs3}=0;
        end
      
      
      
      
      
    end
  
  
  
  initial 
    begin
      {clk,reset,wenable,outenable,cs1,cs2,cs3,cs4,address,datatemp}=0;
      $dumpfile("dump.vcd"); $dumpvars;
    end
  
  always #5 clk = ~clk;
  
  initial 
    begin
      reset = 1;
      
      #10;
      reset =0;
      wenable = 1'b1;
      address = 3'b101;
    
      datatemp = 9;
      
      #20;
      wenable =0;
      address = 3'b101;
      outenable = 1;
      #20;
      $finish();
    end
  assign data = datatemp;
endmodule
      
      
      
    
  