/* Detect a space. A space is a sequence of exactly three 0. The cb signal will be 1 when a valid sequence is being received. The is signal will be 1 when the complete sequence has been received. */

module Space(input clk,
           input rst,
           input in,
           output cb,
             output is);
           //output reg [1:0] current_state,
           //output reg [1:0] next_state);
  
  reg [1:0] current_state;
  reg [1:0] next_state;
  
  always @(posedge clk) begin
    if(rst)		current_state <= 2'd0;
  	else		current_state <= next_state;
  end
  
  always @(negedge clk)	begin
    case(current_state)
      2'd0:	if(in)	next_state <= 2'd0;
      		else	next_state <= 2'd1;
      
      2'd1:	if(in)	next_state <= 2'd0;
      		else	next_state <= 2'd2;
      
      2'd2:	if(in)	next_state <= 2'd0;
      		else	next_state <= 2'd3;
      
      2'd3:	if(in)	next_state <= 2'd0;
      		else	next_state <= 2'd1;
      
      default:		next_state <= 2'd0;     
    endcase
  end
      
  assign cb = ((next_state == 2'd1 | next_state == 2'd2 | next_state == 2'd3) & ~is);
  assign is = (next_state == 2'd3 & current_state == 2'd2);
  
endmodule
