// Code your design here
// Code your design here
module multiplemod(input enable,clk,reset,selectupdown,preset,input [1:0]mod,output reg mod2cout,output reg [1:0]mod4cout, output reg[2:0]mod8cout, output reg[3:0]mod16cout);
  
  always @(posedge clk)
    begin
      if(reset)
        begin
          {mod2cout,mod4cout,mod8cout,mod16cout}<=0;
        end
      else if(preset)
         begin
           {mod2cout,mod4cout,mod8cout,mod16cout}<={5{2'b11}};
        end
      
      else if(enable)
        begin
          if(selectupdown==1)
              begin
          case(mod)
            
            2'b00 : begin
              	
              mod2cout<= mod2cout +1'b1;
              {mod4cout,mod8cout,mod16cout}<=0;
            end
            
             2'b01 :  begin
              
              mod4cout<= mod4cout +1'b1;
               {mod2cout,mod8cout,mod16cout}<=0;
            end
             2'b10 : begin
              
              mod8cout<= mod8cout +1'b1;
               {mod4cout,mod2cout,mod16cout}<=0;
            end
             2'b11 :  begin
              
              mod16cout<= mod16cout +1'b1;
               {mod4cout,mod8cout,mod2cout}<=0;
            end
          endcase
              end
          
            
            else
              begin
                case(mod)
                 2'b00 : begin
              	
              mod2cout<= mod2cout -1'b1;
                   //as total 2+3+4 = 9 bits are there so replicat operator used to manage this
                   {mod4cout,mod8cout,mod16cout}<={3{3'b111}};
            end
            
             2'b01 :  begin
              
              mod4cout<= mod4cout -1'b1;
               {mod2cout,mod8cout,mod16cout}<={4{2'b11}};
            end
             2'b10 : begin
              
              mod8cout<= mod8cout -1'b1;
               {mod4cout,mod2cout,mod16cout}<={7{1'b1}};
            end
             2'b11 :  begin
                mod16cout<= mod16cout -1'b1;
               {mod4cout,mod8cout,mod2cout}<={3{2'b11}};
               end
                endcase
              end
          
            
              
            
            
           
          
        end
    end
endmodule
            
              
            
  