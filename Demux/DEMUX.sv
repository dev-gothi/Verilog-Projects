// Code your design here
module demux(input y,s,output reg a,b);
  //output is reg because we cannot use lhs as wire or net in always block
  always@(*)
    begin
      if(s==0)
        begin
          a = y;
          b = 0;
        end
      else
        begin
          b = y ;
          a = 0 ;
        end
    end
endmodule