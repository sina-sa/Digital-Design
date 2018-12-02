/* Detect SOS. SOS is a sequence of one S followed by one O followed by one S. The cb signal will be 1 when a valid sequence is being received. The is signal will be 1 when the complete sequence has been received. */

`include "O_DETECT.sv"
`include "S_DETECT.sv"

module SOS_detect(input clk,
           		input rst,
           		input in,
           		output cb,
           		output is,
           		output reg [2:0] current_state,
              	output reg [2:0] next_state,
                output cb_S,
                output is_S,
                output cb_O,
                output is_O);
  
  //wire cb_S, is_S, cb_O, is_O;
  
  //reg [2:0] current_state;
  //reg [2:0] next_state;
  
  S_detect S_check(clk, rst, in, cb_S, is_S);
  O_detect O_check(clk, rst, in, cb_O, is_O);
  
  always @(posedge clk) begin
    if(rst)		current_state <= 0;
  	else		current_state <= next_state;
  end
  
  always @(cb_S or is_S or cb_O or is_O) begin
    case(current_state)
      3'd0:	if(cb_S)			next_state <= 3'd1;
      		else				next_state <= 3'd0;
      
      3'd1:	if(cb_S)			next_state <= 3'd1;
      		else if(is_S)		next_state <= 3'd2;
      		else				next_state <= 3'd0;
      
      3'd2:	if(cb_O)			next_state <= 3'd2;
      		else if(is_O)		next_state <= 3'd3;
      		else if(cb_S)		next_state <= 3'd1;
      		else				next_state <= 3'd0;
      
      3'd3:	if(cb_S)			next_state <= 3'd3;
      		else if(is_S)		next_state <= 3'd1;
      		else				next_state <= 3'd0;
      
      default:		next_state <= 3'd0;     
    endcase
  end
      
  assign cb = ((next_state == 3'd1 | next_state == 3'd2 | next_state == 3'd3) & ~is) ? 1'b1 : 1'b0;
  assign is = (next_state == 3'd1 & current_state == 3'd3) ? 1'b1 : 1'b0;
  
endmodule
