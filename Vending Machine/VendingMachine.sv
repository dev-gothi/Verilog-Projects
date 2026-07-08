module vendingmachine #(
  parameter PRICE = 5'd15
)(
  input clk,reset,coinvalid,
  input [3:0]coinvalue,
  output reg dispense,insufficient,
  output reg[4:0]change
  );
  
  localparam IDLE = 3'b000;
  localparam COLLECTING = 3'b001;
  localparam SUFFICIENT = 3'b010;
  localparam DISPENSE =   3'b011;
  localparam RETURNCHANGE = 3'b100;
  
  reg[4:0]sum;
  reg [2:0]ns,ps;
  
  always@(posedge clk)
    begin
      if(reset)
        ps<=IDLE;
      else
        ps<=ns;
    end
  
  
  //For calculating SUM
  always@(posedge clk)
    begin
      if(reset)
        sum<=0;
      else if((ps==IDLE || ps==COLLECTING) && coinvalid)
    sum <= sum + coinvalue;
      else if(ps==RETURNCHANGE)
        sum<=0;
    end
  
  
  
  always @(*)
    begin
      {dispense,change,insufficient}=0;
      case(ps)
        
        IDLE : begin
          if(coinvalid)
            ns = COLLECTING;
          else 
            ns = IDLE;
        end
        
        COLLECTING:
          begin
            if(sum >= PRICE)
              ns = SUFFICIENT;
            else 
              begin
              insufficient = 1'b1;
              ns = COLLECTING;
              end
          end
        
        SUFFICIENT:
          begin
           ns = DISPENSE;
          end
        
        DISPENSE:
          begin
            dispense = 1'b1;
            if(sum > PRICE)
              ns = RETURNCHANGE;
            else
            ns = IDLE;
          end
        
        RETURNCHANGE:
          begin
            change = sum - PRICE ;
            ns = IDLE;
          end
        default:ns = IDLE;
      
      endcase  
    end
endmodule