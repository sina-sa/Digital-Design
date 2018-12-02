/* Detect a character S. A character S in morse code is defined by a sequence of exactly three dots and one space. The space is necessary because it defines the separation between characters. The cb signal will be 1 when a valid sequence is being received. The is signal will be 1 when the complete sequence has been received. */

`include "DOT.sv"
`include "SPACE.sv"

module S_detect(input clk,
           		input rst,
           		input in,
           		output cb,
                output is);
           		//output reg [2:0] current_state,
           		//output reg [2:0] next_state);
  
  wire cb_dot, is_dot, cb_space, is_space;
  
  reg [2:0] current_state;
  reg [2:0] next_state;
  
  Dot Dot_check(clk, rst, in, cb_dot, is_dot);
  Space Space_check(clk, rst, in, cb_space, is_space);
  
  always @(posedge clk) begin
    if(rst)		current_state <= 0;
  	else		current_state <= next_state;
  end
  
  always @(cb_dot or is_dot or cb_space or is_space) begin
    case(current_state)
      3'd0:	if(cb_dot)			next_state <= 3'd1;
      		else				next_state <= 3'd0;
      
      3'd1:	if(cb_dot)			next_state <= 3'd1;
      		else if(is_dot)		next_state <= 3'd2;
      		else				next_state <= 3'd0;
      
      3'd2:	if(cb_dot)			next_state <= 3'd2;
      		else if(is_dot)		next_state <= 3'd3;
      		else				next_state <= 3'd0;
      
      3'd3:	if(cb_dot)			next_state <= 3'd3;
      		else if(is_dot)		next_state <= 3'd4;
      		else				next_state <= 3'd0;
      
      3'd4:	if(cb_space)		next_state <= 3'd4;
      		else if(is_space)	next_state <= 3'd1;
      		else if(cb_dot)		next_state <= 3'd3;
      		else				next_state <= 3'd0;
      
      default:		next_state <= 3'd0;     
    endcase
  end
      
  assign cb = ((next_state == 3'd1 | next_state == 3'd2 | next_state == 3'd3 | next_state == 3'd4) & ~is) ? 1'b1 : 1'b0;
  assign is = (next_state == 3'd1 & current_state == 3'd4) ? 1'b1 : 1'b0;
  
endmodule
