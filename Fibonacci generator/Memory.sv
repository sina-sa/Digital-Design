/* This is a basic memory module to write data to a given address or read data from it. It stores the data in a register the write enable signal (wr) determines whether the data is being written to the memory or read from it.  */

module Mem(clk, rst, datain, dataout, address, wr);

  input clk;
  input rst;
  input [5:0]address;
  input	wr;
  output reg [31:0] dataout;
  input [31:0] datain;
  
  reg [31:0] mem [15:0];
  
  always @(datain or address or wr)
    begin
      if(rst == 1'b1)
        dataout = 32'bz;
      else
        begin
          if(wr == 1'b1)
            mem[address] <= datain;
          else
            dataout = mem[address];
        end
    end
endmodule
