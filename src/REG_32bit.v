`timescale 1ns / 1ps

module REG_32bit( //25 bit register to hold tag & valid bits for each block.
    input clk,
    input rst,
    input load_enable,
    input [31:0] data_in,
    output [31:0] data_out
  );
  genvar i;
  generate
    for (i= 0;i<32; i = i+1) begin
      REG_bit REG_bit_inst(.clk(clk),.rst(rst),.load_enable(load_enable),.d(data_in[i]),.q(data_out[i]));
    end
  endgenerate
endmodule
