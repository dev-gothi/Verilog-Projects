// Code your design here
module digitaldoorlock(input clk,reset,setmode,input [3:0]password,input [3:0]newpassword,output reg alarm,dooropen);
  
  parameter IDLE = 3'd0;
  parameter UNLOCKED = 3'd1;
  parameter ERROR = 3'd2;
  parameter ALARM = 3'd3;

  
  reg [3:0]temppassword;
  reg [1:0]count;
  reg[1:0]nextcount;
  reg[1:0]ps,ns;
  
  // sequential logic
  always@(posedge clk or posedge reset)
    begin
      if(reset)
        begin
          ps<=IDLE;
          temppassword<=4'b0101;
          count<=0;
          nextcount<=0;
        end
      else
        begin
        ps<=ns;
      	count<=nextcount;
    end
      
      
    end
  
  //Next state logic
  always@(*)
    begin
      nextcount = count;
      case(ps)
        
        IDLE : 
          begin
         
            if(password==temppassword)
             ns = UNLOCKED;
              
          else if(count<2)
            begin
            ns = ERROR;
          	nextcount = count + 1'b1;
          end
          else if(count==2)
            ns = ALARM;
        end
        
      
      
      
    
  

  
  UNLOCKED : 
  begin
    if(setmode)
      begin
        temppassword = newpassword;
        nextcount = 0;
        ns = IDLE;
        
      end
    else 
      begin
        ns = IDLE;
        nextcount = 0;
        
      end
    
    
  end
  
    ERROR : 
  begin
    if(temppassword==password)
      begin
        ns = UNLOCKED;
      end
    else
      begin
        if(count<2)
          begin
            ns = ERROR;
            nextcount = count + 1'b1;
          end
        else if(count==2)
          begin
            ns = ALARM;
            
          end
        
      end
    
    
  end
  
  ALARM : ns = ALARM;
  
  default : ns = IDLE;
      endcase
    end
  

 // Output Logic
  always@(*)
    begin
      case(ps)
        IDLE : 
          begin
            dooropen = 0;
            alarm = 0;
          end
        UNLOCKED : 
          begin
            dooropen = 1'b1;
            alarm = 0;
          end
    
         ERROR : 
          begin
            dooropen = 0;
            alarm = 0;
            
          end
    
         ALARM : 
          begin
            dooropen = 0;
            alarm = 1'b1;
            
          end
        default : 
          begin
          dooropen = 0;
            alarm = 0;
          end
        
      endcase
    end
endmodule
    
  
  