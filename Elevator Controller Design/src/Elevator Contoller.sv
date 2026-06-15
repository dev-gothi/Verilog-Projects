// Code your design here
module elevatordesign(input clk,reset,emergencystop,input [3:0]floorreq,output reg motorstop,moveup,movedown,output reg dooropen,output reg[1:0]currentfloor);
  
  parameter IDLE = 2'b00;
  parameter MOVEUP = 2'b01;
  parameter MOVEDOWN = 2'b10;
  parameter EMERGENCY = 2'b11;
  
  reg [1:0]ps,ns,targetfloor;
  
  //Encoder logic
  
  always@(*)
    begin
     targetfloor = currentfloor;
      
      if(floorreq[0])
        targetfloor = 2'b00;
      else if(floorreq[1])
        targetfloor = 2'b01;
      else if(floorreq[2])
        targetfloor = 2'b10;
      else if (floorreq[3])
        targetfloor = 2'b11;
    end
  
  //Nextstate Logic
  always @(*)
    begin
      case(ps)
        IDLE : begin
          if(emergencystop)
            ns = EMERGENCY;
          else if(targetfloor>currentfloor)
            ns = MOVEUP;
          else if(targetfloor<currentfloor)
            ns = MOVEDOWN;
          else
            ns = IDLE;
        end
        
        MOVEUP : begin
          if(emergencystop)
            ns = EMERGENCY;
          else if(targetfloor==currentfloor)
            ns = IDLE;
          else 
            ns = MOVEUP;
        end
        
         MOVEDOWN : begin
          if(emergencystop)
            ns = EMERGENCY;
          else if(targetfloor==currentfloor)
            ns = IDLE;
          else 
            ns = MOVEDOWN;
        end
        
        EMERGENCY :
          begin
          if(emergencystop)
            ns = EMERGENCY;
        else
            ns = IDLE;
          end
        
        default : ns = IDLE;
      endcase
    end
  
  // Nextstate Condition
  always@(posedge clk)
    begin
      if(reset)
        begin
        ps<=IDLE;
      	
        end
      else 
        ps<=ns;
      
      
    end
  
  
  //Output Logic
  
  always @(posedge clk)
    begin
      if(reset)
        begin
      	 currentfloor<=2'b00;
          moveup<=0;
          dooropen<=1'b1;
          movedown<=0;
          motorstop<=1'b1;
        end
      else
        begin
      
      
          case(ns)
        IDLE : begin
          moveup<=0;
          movedown<=0;
          motorstop<=1'b1;
          currentfloor<=currentfloor;
          dooropen<=1'b1;
    end
        MOVEUP :begin
        moveup<=1'b1;
          movedown<=0;
          motorstop<=0;
          currentfloor<= currentfloor + 1'b1;
          dooropen<=0;
          
        end
        
         MOVEDOWN :begin
        movedown<=1'b1;
          moveup<=0;
          motorstop<=0;
           currentfloor <= currentfloor - 1'b1;
           dooropen<=0;
           
        end
        
        EMERGENCY : begin
          moveup <=0;
          movedown<=0;
          motorstop<=1'b1;
          dooropen<=0;
          
        end
        
        default : begin
       	moveup<=0;
        movedown<=0;
        motorstop<=1'b1;
          
        end
        
        
      endcase
        end
    end
endmodule
        
  
        
        
        
        
      