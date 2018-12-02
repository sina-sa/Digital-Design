/* Detect a dot. A dot is a sequence of exactly one 1 and one 0. The cb signal will be 1 when a valid sequence is being received. The is signal will be 1 when the complete sequence has been received. */

module Dot(input clk,
           input rst,
           input in,
           output cb,
           output is);
           //output reg current_state,
           //output reg next_state);
  
  reg [1:0] current_state;
  reg [1:0] next_state;
  
  always @(posedge clk) begin
    if(rst)		current_state <= 1'd0;
  	else		current_state <= next_state;
  end
  
  always @(negedge clk)	begin
    case(current_state)
      1'd0:	if(in)	next_state <= 1'd1;
      		else	next_state <= 1'd0;
      
      1'd1:	if(in)	next_state <= 1'd1;
      		else	next_state <= 1'd0;
      
      default:		next_state <= 1'd0;
    endcase
  end
      
  assign cb = (next_state == 1'd1) ? 1'b1 : 1'b0;
  assign is = (next_state == 1'd0 & current_state == 1'd1) ? 1'b1 : 1'b0;
  
endmodule
