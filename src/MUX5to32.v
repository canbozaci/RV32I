`timescale 1ns / 1ps

module MUX5to32#(parameter data_width = 32, parameter depth = 32)( // data_width is parametrized, 64x1 multiplexer for output of the blocks.
    input [depth*data_width-1:0] mux_input,
    input [$clog2(depth)-1:0] select,
    output reg [data_width-1:0] mux_out
  );
  wire [data_width -1:0] mux_in_wire [depth-1:0]; //2d array of mux inputs, purpose of this to write case statements easier
  genvar i;
  generate // to write case statements more clear, it will not consume any power it is just connecting wires.
    for (i = 0; i<depth; i = i +1) begin
      assign mux_in_wire[i] = mux_input[(i*data_width + data_width-1):(i*data_width)];
    end
  endgenerate

  always @(*) begin
    case(select)
      5'd0:
        mux_out = mux_in_wire[0];
      5'd1:
        mux_out = mux_in_wire[1];
      5'd2:
        mux_out = mux_in_wire[2];
      5'd3:
        mux_out = mux_in_wire[3];
      5'd4:
        mux_out = mux_in_wire[4];
      5'd5:
        mux_out = mux_in_wire[5];
      5'd6:
        mux_out = mux_in_wire[6];
      5'd7:
        mux_out = mux_in_wire[7];
      5'd8:
        mux_out = mux_in_wire[8];
      5'd9:
        mux_out = mux_in_wire[9];
      5'd10:
        mux_out = mux_in_wire[10];
      5'd11:
        mux_out = mux_in_wire[11];
      5'd12:
        mux_out = mux_in_wire[12];
      5'd13:
        mux_out = mux_in_wire[13];
      5'd14:
        mux_out = mux_in_wire[14];
      5'd15:
        mux_out = mux_in_wire[15];
      5'd16:
        mux_out = mux_in_wire[16];
      5'd17:
        mux_out = mux_in_wire[17];
      5'd18:
        mux_out = mux_in_wire[18];
      5'd19:
        mux_out = mux_in_wire[19];
      5'd20:
        mux_out = mux_in_wire[20];
      5'd21:
        mux_out = mux_in_wire[21];
      5'd22:
        mux_out = mux_in_wire[22];
      5'd23:
        mux_out = mux_in_wire[23];
      5'd24:
        mux_out = mux_in_wire[24];
      5'd25:
        mux_out = mux_in_wire[25];
      5'd26:
        mux_out = mux_in_wire[26];
      5'd27:
        mux_out = mux_in_wire[27];
      5'd28:
        mux_out = mux_in_wire[28];
      5'd29:
        mux_out = mux_in_wire[29];
      5'd30:
        mux_out = mux_in_wire[30];
      5'd31:
        mux_out = mux_in_wire[31];
    endcase
  end
endmodule


