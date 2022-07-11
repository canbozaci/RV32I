`timescale 1ns / 1ps
module RegisterFile#(
    parameter data_width = 32,
    parameter depth = 32
  )
  (
    input clk,
    input load_enable,
    input rst, //active low
    input [$clog2(depth)-1:0]	D_addr,
    input [$clog2(depth)-1:0]	A_select,
    input [$clog2(depth)-1:0]	B_select,
    input [data_width-1:0] D_data,
    output [data_width-1:0] A_data,
    output [data_width-1:0] B_data
  );
  
  wire [data_width*depth-1:0] data_out;
  wire [depth-1:0] load_enable_decoder_output;
  genvar i;
  generate  
    for (i= 0;i<depth; i = i+1) begin
      REG_32bit REG_32bit_inst(.clk(clk),.rst(rst),.load_enable(load_enable_decoder_output[i]),.data_in(D_data),.data_out(data_out[data_width-1+data_width*i:data_width*i]));
    end
  endgenerate
  DECODER5to32 decoder5to32_inst(.D_addr(D_addr),.load_enable(load_enable),.load_enable_decoder_output(load_enable_decoder_output));
  MUX5to32 muxA_inst(.mux_input(data_out),.select(A_select),.mux_out(A_data));
  MUX5to32 muxB_inst(.mux_input(data_out),.select(B_select),.mux_out(B_data));
endmodule
