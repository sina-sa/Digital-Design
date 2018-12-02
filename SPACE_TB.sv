
module Space_TB;
  
  reg clk;
  reg rst;
  reg in;
  
  reg [6:0] counter;
  
  wire cb;
  wire is;
  wire [1:0] current_state;
  wire [1:0] next_state;
  
  Space Space_t(.clk(clk),
                .rst(rst),
                .in(in),
                .cb(cb),
                .is(is),
                .current_state(current_state),
               .next_state(next_state));
  
  initial
    begin
      rst = 1;		#10;
      
      rst = 0;
      counter = 0;
      
      in = 1;	#10;
      in = 0;	#10;
      in = 0;	#10;
      in = 0;	#10;
      in = 0;	#10;
      in = 0;	#10;
      in = 0;	#10;
      in = 1;	#10;
      in = 0;	#10;
      in = 0;	#10;
      in = 0;	#10;
      in = 0;	#10;
      in = 0;	#10;
      in = 1;	#10;
      in = 0;	#10;
      
      $dumpfile("dump.vcd");
  	  $dumpvars(1);
      
      #10 $finish;
      
    end
  
  always
    begin
    	clk = 0;
      $display("counter=%2d  clk=%b rst=%b in=%b current_state=%b next_state=%b cb=%b  is=%b",counter ,clk, rst, in, current_state, next_state, cb, is) ; 
      #5;
      	clk = 1;	
      $display("counter=%2d  clk=%b rst=%b in=%b current_state=%b next_state=%b cb=%b  is=%b",counter ,clk, rst, in, current_state, next_state, cb, is) ; 
      #5; 
      $display("-----------------------------------------------------------------------") ;
      counter = counter + 1;
    end
  
endmodule
