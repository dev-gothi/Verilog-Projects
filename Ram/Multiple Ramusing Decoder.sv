// Code your design here
module ramdecoder(input clk,reset,wenable,outenable,cs,input[2:0]address,inout [7:0]data);
  
  reg[7:0]memory[7:0];
  reg [7:0] temp;
  
  always@(posedge clk)
    begin
      if(reset)
        begin
          for(int i=0;i<8;i++)
          begin
            memory[i]<=0;
          end
        end
      
          
      else if((wenable && cs) ==1)
            begin
              memory[address]<=data;
            end
          
      else if((!wenable && cs )==1)
            begin
              temp<=memory[address];
            end
    end
  /* Here the input data is wire and output should be reg which is 
  not possible as single port so both are declared as wire and temp is used as wire cant be used in always block lhs and at last value of data is assigned
  */
  assign data = (outenable && cs && !wenable == 1) ? temp : 'bz;
endmodule
        
  
      
              