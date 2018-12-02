/* This module combines the Fibonacci generator and the memory module together. The output from the Fibonacci module gets stored in the memory and then it will read the data from the memory. Writing to the memory happens at the negative edge of the clock and reading from the memory happens at the positive edge of the clock.
“value” is the actual sequence generated from the Fibonacci module.
“dataout” is the data that was read from the memory.
“address” is where in the memory the data is stored in. */

`include "Fibonacci.sv"
`include "Memory.sv"

module Fib_and_Mem(clk, rst, n, ready, value, counter, address, dataout);

  input clk;
  input rst;
  input [5:0] n;
  
  output ready;
  output [31:0] value;
  output [5:0] counter; 
  output reg [5:0]address;
  output [31:0] dataout;
  
  reg	wr;
  reg [31:0] datain;

  Mem mem(clk, rst, datain, dataout, address, wr);
  Fib fib(clk, rst, n, ready, value, counter);
  
  always @(negedge clk)
    	begin
          if(rst == 1'b0)
            begin
              wr = 1'b1;
              address <= counter;
              datain <= value;
            end
    	end
  
  always @(posedge clk)
    	begin
          if(rst == 1'b0)
            begin
              wr = 1'b0;
            end
    	end

endmodule
