
module SOS_detect_TB;
  
  reg clk;
  reg rst;
  reg in;
  
  reg [6:0] counter;
  
  wire cb;
  wire is;
  wire [2:0] current_state;
  wire [2:0] next_state;
  
  wire cb_S, is_S, cb_O, is_O;
  
  SOS_detect SOS_detect_TB(.clk(clk),
                           .rst(rst),
                           .in(in),
                           .cb(cb),
                           .is(is),
                           .current_state(current_state),
                           .next_state(next_state),
                           .cb_S(cb_S),
                           .is_S(is_S),
                           .cb_O(cb_O),
                           .is_O(is_O));
  
  initial
    begin
      $dumpfile("dump.vcd");
  	  $dumpvars(1);
      
      rst = 1;		#10;
      rst = 0;
      counter = 0;
      
      in = 0;	#10;
      in = 0;	#10;
      in = 0;	#10;
      // S
      in = 1;	#10;
      in = 0;	#10;
      in = 1;	#10;
      in = 0;	#10;
      in = 1;	#10;
      in = 0;	#10;
      in = 1;	#10;
      in = 0;	#10;
      // space
      in = 0;	#10;
      in = 0;	#10;
      // O
      in = 1;	#10;
      in = 1;	#10;
      in = 1;	#10;
      in = 0;	#10;
      in = 1;	#10;
      in = 1;	#10;
      in = 1;	#10;
      in = 0;	#10;
      in = 1;	#10;
      in = 1;	#10;
      in = 1;	#10;
      in = 0;	#10;
      // space
      in = 0;	#10;
      in = 0;	#10;
      //S
      in = 1;	#10;
      in = 0;	#10;
      in = 1;	#10;
      in = 0;	#10;
      in = 1;	#10;
      in = 0;	#10;
      // space
      in = 0;	#10;
      in = 0;	#10;
      in = 0;	#10;
      in = 0;	#10;
      
      #10 $finish;
      
    end
  
  always
    begin
    	clk = 0;
      $display("counter=%2d  clk=%b rst=%b in=%b current_state=%b next_state=%b cb_S=%b is_S=%b cb_O=%b is_O=%b cb=%b  is=%b",counter ,clk, rst, in, current_state, next_state, cb_S, is_S, cb_O, is_O, cb, is) ; 
      #5;
      	clk = 1;	
      $display("counter=%2d  clk=%b rst=%b in=%b current_state=%b next_state=%b cb_S=%b is_S=%b cb_O=%b is_O=%b cb=%b  is=%b",counter ,clk, rst, in, current_state, next_state, cb_S, is_S, cb_O, is_O, cb, is) ; 
      #5; 
      $display("-----------------------------------------------------------------------") ;
      counter = counter + 1; 
    end
  
endmodule
