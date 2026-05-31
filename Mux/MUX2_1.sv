module mux(input a ,b,c,output reg y);
  always@(*)
    begin
  
  if(c==0)
    begin
       y = a;
    end 
  else
    begin
     y =b;
    end
    end
endmodule