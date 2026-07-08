// Code your design here
module debouncer(input clk,reset,din,output reg dout);
  
  localparam s0 = 2'b00;
  localparam s0w = 2'b01;
  localparam s1 = 2'b10;
  localparam s1w = 2'b11;
  
  reg[1:0]ns,ps;
  reg temp;
  
  always@(posedge clk or posedge reset)
    begin
      if(reset)
        begin
          ps<=s0;
          dout<=0;
        end
      else 
        begin
        ps<=ns;
      	dout<=temp;
        end
    end
  
  always @(*)
    begin
      case(ps)
        s0: ns =(din) ? s0w : s0;
        s0w : ns = (din) ? s1 : s0;
        s1 : ns = (din) ? s1 : s1w;
        s1w : ns = (din) ? s1 : s0;
        default : ns = s0;
      endcase
        
    end
 
  always@(*)
	begin
      case(ps)
        s0: temp = 0;
        s0w: temp = din;
         s1: temp = 1'b1;
          s1w: temp = din;
        default : temp = 0;
      endcase
	end
endmodule
  