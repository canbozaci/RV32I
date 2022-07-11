`timescale 1ns / 1ps
module DECODER5to32(
    input [4:0] D_addr,
    input load_enable,
    output reg [31:0] load_enable_decoder_output
    );
    always @(*) 
    begin
        if(load_enable == 0) begin
            load_enable_decoder_output = 0;
        end
        else begin
            case(D_addr)
            5'd0:
              load_enable_decoder_output = 32'h1;
            5'd1:
              load_enable_decoder_output = 32'h2;
            5'd2:
              load_enable_decoder_output = 32'h4;
            5'd3:
              load_enable_decoder_output = 32'h8;
            5'd4:
              load_enable_decoder_output = 32'h10;
            5'd5:
              load_enable_decoder_output = 32'h20;
            5'd6:
              load_enable_decoder_output = 32'h40;
            5'd7:
              load_enable_decoder_output = 32'h80;
            5'd8:
              load_enable_decoder_output = 32'h100;
            5'd9:
              load_enable_decoder_output = 32'h200;
            5'd10:
              load_enable_decoder_output = 32'h400;
            5'd11:
              load_enable_decoder_output = 32'h800;
            5'd12:
              load_enable_decoder_output = 32'h1000;
            5'd13:
              load_enable_decoder_output = 32'h2000;
            5'd14:
              load_enable_decoder_output = 32'h4000;
            5'd15:
              load_enable_decoder_output = 32'h8000;
            5'd16:
              load_enable_decoder_output = 32'h10000;
            5'd17:
              load_enable_decoder_output = 32'h20000;
            5'd18:
              load_enable_decoder_output = 32'h40000;
            5'd19:
              load_enable_decoder_output = 32'h80000;
            5'd20:
              load_enable_decoder_output = 32'h100000;
            5'd21:
              load_enable_decoder_output = 32'h200000;
            5'd22:
              load_enable_decoder_output = 32'h400000;
            5'd23:
              load_enable_decoder_output = 32'h800000;
            5'd24:
              load_enable_decoder_output = 32'h1000000;
            5'd25:
              load_enable_decoder_output = 32'h2000000;
            5'd26:
              load_enable_decoder_output = 32'h4000000;
            5'd27:
              load_enable_decoder_output = 32'h8000000;
            5'd28:
              load_enable_decoder_output = 32'h10000000;
            5'd29:
              load_enable_decoder_output = 32'h20000000;
            5'd30:
              load_enable_decoder_output = 32'h40000000;
            5'd31:
              load_enable_decoder_output = 32'h80000000;
            endcase
        end
    end
endmodule