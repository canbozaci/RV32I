`timescale 1ns / 1ps
module REG_bit( // classic D-FF implementation, if we is 1 we write to the FF.
    input clk,
    input rst,
    input load_enable,
    input d,
    output reg q
  );
 // reg temp_q;
  always @(negedge clk) begin
    if(rst == 0) begin
      q <= 0;
    end
    else if (load_enable) begin
      q <= d;
    end
  end
 endmodule
