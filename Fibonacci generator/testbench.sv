
module Fibonacci_TB;
  
  reg clk;
  reg rst;
  reg [5:0] n;
  
  wire [31:0] value;
  wire ready;
  wire [31:0] mem_data;
  
  reg [31:0] datain;  
  wire [5:0] address;
  reg wr;
  wire [31:0] dataout;
  wire [5:0] counter;

  Fib_and_Mem Fib_and_Mem_t(
    		.clk(clk),
            .rst(rst),
            .n(n),
            .ready(ready),
            .value(value),
    		.counter(counter),
    		.address(address),
    		.dataout(dataout));
 
  initial
    begin
      rst = 1;		#4; 
      n = 6'd5;
      
      
      #4;
      rst = 0;
      
      
      //$dumpfile("dump.vcd");
  	  //$dumpvars(1);
      
      
    end
  
  always
    begin
    	clk = 0;
      $display("") ;
      $display("clk=%b  rst=%b:", clk, rst) ;
      $display("address=%4d   counter=%4d   value=%4d   dataout=%4d", address, counter, value, dataout) ;
      #2;
      	clk = 1;	
      $display("") ;
      $display("clk=%b  rst=%b:", clk, rst) ;
      $display("address=%4d   counter=%4d   value=%4d   dataout=%4d", address, counter, value, dataout) ;
      #2; 
      if(ready == 1'b1)
        $finish;
    end
  
endmodule
