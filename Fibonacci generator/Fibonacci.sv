/* This module generates a Fibonacci sequence to n steps. The sequence is generated using a counter and a register to keep track of the previous value and each time the new value is added to the sum of the last 2 values, thus creating a Fibonacci sequence. 
Example (n = 5): 1, 1, 2, 3, 5
The ready signal indicates that the sequence has finished, this could be used to stop the simulation. */

module Fib(clk, rst, n, ready, value, counter);

  input clk;
  input rst;
  input [5:0] n;
  
  output reg ready;
  output [31:0] value;
  
  reg [31:0] previous, current;
  output reg [5:0] counter;
  
	always @(posedge clk)
    	begin
          if(rst == 1'b1)
            begin
              previous <= 32'd0;
        	  current <= 32'd1;
        	  counter <= 6'd1;
          	  ready <= 1'b0;
            end
          else
            begin
              counter <= counter + 1;
              current <= current + previous;
              previous <= current;
              
       		  if (counter == n)
           		  ready <= 1;
            end
    	end

	assign value = current;

endmodule
