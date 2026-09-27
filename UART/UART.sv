module uarttop(
  input clk,
  input reset,
  input txstart,
  input [7:0] datain,
  output txbusy,
  output txdone,
  output rxbusy,
  output rxdone,
  output error,
  output [7:0] rxdata
);

  wire serialline;

  tx U1 (clk,reset,txstart,datain,serialline,txbusy,txdone);
  rx U2 (clk,reset,serialline,rxdone,rxbusy,error,rxdata);
 

endmodule

// Code your design here
module baudrategenerator(input clk,reset,output reg tick);
  
  parameter clkfreq = 8000;
  parameter baudrate = 100;
  parameter maxcount = clkfreq/(baudrate*16);
  parameter n = $clog2(maxcount);
  reg [n-1:0]temp;
  
  always @(posedge clk)
    begin
      if(reset)
        begin
          temp<=0;
          tick<=0;
        end
      else if(temp==maxcount)
        begin
          temp<=0;
          tick<=1'b1;
        end
      else
        begin
          temp<=temp + 1'b1;
          tick<=0;
        end
    end
endmodule
      

module tx(input clk,reset,txstart,input[7:0]datain,output reg serialout,txbusy,txdone);
  wire tick;
  baudrategenerator b1(clk,reset,tick);
  parameter IDLE = 2'b00;
  parameter START = 2'b01;
  parameter DATA = 2'b10;
  parameter STOP = 2'b11;
  reg [3:0]count;
  reg [7:0]temp;
  reg [2:0]bitcount;
  reg txtick;
  reg[1:0]ns,ps;
  //converter of 16X Tick to 1X
 always @(posedge clk)
  begin
    if(reset)
      begin
        count<=0;
        txtick<=0;
      end
    else
      begin
        txtick<=0;  
        if(tick)
          begin
            if(count==4'd15)
              begin
                count<=0;
                txtick<=1'b1;
              end
            else
              begin
                count<=count+1'b1;
              end
          end
      end
  end

  //sequential logic
  always @(posedge clk)
    begin
      if(reset)       
        begin
          ps<=IDLE;
        end
      else if(txtick || (ps==IDLE && txstart))
  begin
    ps<=ns;
  end
      
      
    end
  
  
  //index tracking Counter
 always @(posedge clk)
  begin
    if(reset)
      bitcount <= 3'd0;
    else if(ps==IDLE && txstart)
      bitcount <= 3'd0;
    else if(txtick && ps==DATA)
      bitcount <= bitcount + 1'b1;
  end
  
  
  //Shifting Logic
  
  
  always@(posedge clk)
    begin
      if(reset)
        temp<=0;
      else if(ps==IDLE && txstart)
        temp<=datain;
      else if(txtick && ps==DATA)
        temp<= temp>>1'b1;
      
    end
  
  //Combinational Logic
  always @(*)
    begin
      case(ps)
        
        IDLE:
          begin
            if(txstart)
              ns=START;
            else 
              ns = IDLE;
          end
        START:
          begin
           ns = DATA;
          end
        
        DATA: 
          begin
            if(bitcount==3'd7)
              ns = STOP;
            else 
              ns = DATA;
          end
        STOP : ns = IDLE;
        
        default : ns = IDLE;
      endcase   
    end
  
  //output logic
  
  always@(*)
    begin
      {serialout,txbusy,txdone}=0;
      case(ps)
        IDLE: 
          begin
            serialout=1'b1;
            
          end
        START:
          begin
            txbusy = 1'b1;
            serialout = 0;
          end
        DATA:
          begin
            txbusy = 1'b1;
            serialout = temp[0];
            
          end
        STOP : 
          begin
            txdone = 1'b1;
            serialout = 1'b1;
            txbusy = 1'b1;
            
          end
        default: {serialout,txbusy,txdone} = 0;
        
      endcase
        
    end
endmodule
  
module rx(input clk,reset,rxin,output reg rxdone,rxbusy,error,output reg [7:0]rxdata);
  
  parameter IDLE = 2'b00;
  parameter START = 2'b01;
  parameter DATA = 2'b10;
  parameter STOP = 2'b11;
  reg[1:0]ps,ns;
  reg[3:0]bitcounter;
  reg [2:0]databits;
  reg rxinprev;
  wire tick;
  baudrategenerator b1(clk,reset,tick);
  
  
  //falling edge detection
  always@(posedge clk)
    begin
      if(reset)
      rxinprev<=1'b1;
      else
        rxinprev<=rxin;
    end
  
  //shifting block
  always@(posedge clk)
    begin
      if(reset)
        rxdata<=0;
      else if(rxsample && ps==DATA)
        rxdata<={rxin,rxdata[7:1]};
      
    end
  
  
  
  
  
  //bitcounter
  always @(posedge clk)
    begin
      if(reset)begin
        bitcounter<=0;
      	databits<=0;
      end
      
      else if(ps==IDLE)begin
        bitcounter <=0;
      	databits<=0;
      end
      
      else if(tick && ps==START)
        begin
          if(bitcounter==4'd7)
            bitcounter<=0;
          else 
            bitcounter <= bitcounter +1'b1;
        end
      
      else if(tick && (ps==DATA || ps==STOP))
        begin
          if(bitcounter==4'd15)
            begin
            bitcounter<=0;
              if(ps==DATA)
                databits <= databits + 1'b1; 
            end
          else 
            bitcounter <= bitcounter + 1'b1;
        end
      
    end
  
  wire rxsample;
  assign rxsample = (ps==START && tick && bitcounter==4'd7) || (bitcounter==4'd15 && tick && (ps==DATA || ps==STOP));
  
  //sequential logic
  always @(posedge clk)
    begin
      if(reset)
        ps<=IDLE;
      else if(ps==IDLE && (rxinprev && (!rxin)))
        ps<=START;
      else if(rxsample)
        ps<=ns;
    end
  
  //combinational logic
  
  always @(*)
    begin
      case(ps)
        IDLE :
          begin
            ns=IDLE;
          end
        START:
          begin
            if(rxin)
              ns = IDLE;
            else 
              ns = DATA;
          end
        DATA: 
          begin
            if(databits==3'd7)
              ns = STOP;
            else
              ns = DATA;
          end
        
        STOP:ns = IDLE;
          default : ns = IDLE;
      endcase
    end
  
  
  //output logic
  always@(*)
  begin
    {rxbusy,error}=0;
    case(ps)
      IDLE:rxbusy = 1'b0;
      START: rxbusy = 1'b1;
      DATA: rxbusy = 1'b1;
      STOP: begin
      
        rxbusy = 1'b1;
        error = (rxsample && rxin==0) ? 1'b1 : 0;
      end
        default: rxbusy = 0;
        endcase
  end

  always@(posedge clk)
    begin
      if(reset)
        rxdone<=0;
      else if(ps==STOP && rxsample)
        rxdone<=1'b1;
      else 
        rxdone<=0;
    end
endmodule

     
        
        
   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  