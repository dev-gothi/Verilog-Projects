module universal(
  input clk, load, reset, sin,
  input [1:0] mode,        // 2-bit for 4 modes
  input [3:0] pin,
  output sout,
  output [3:0] pout
);

  reg [3:0] temp;
   //mode = 00 siso
      //mode =01 sipo
      //mode =10 piso
      //mode = 11 pipo

  always @(posedge clk) begin
    if(reset)
      temp <= 4'b0000;
    else begin
      case(mode)

        2'b00 : begin          // SISO — serial in, serial out
                  temp <= {sin, temp[3:1]};  // shift right, sin→MSB
                end

        2'b01 : begin          // SIPO — serial in, parallel out
                  temp <= {sin, temp[3:1]};  // shift right, sin→MSB
                end

        2'b10 : begin          // PISO — parallel in, serial out
                  if(load)
                    temp <= pin;
                  else
                    temp <= {1'b0, temp[3:1]};  // shift right
                end

        2'b11 : begin          // PIPO — parallel in, parallel out
                  if(load)
                    temp <= pin;
                end

        default: temp <= 4'b0000;

      endcase
    end
  end

  assign sout = temp[0];   // serial output
  assign pout = temp;      // parallel output

endmodule