`timescale 1ns / 1ps
module Hazard_detect_unit(
    input [4:0] rd_ID_EX,
    input [4:0] rs1_IF_ID,
    input [4:0] rs2_IF_ID,
    input read_mem_ID_EX,
    output reg load_use_hazard_out
    );

    always @* begin
        load_use_hazard_out = 1'b0;
        if(read_mem_ID_EX) begin
            if((rd_ID_EX == rs1_IF_ID) | (rd_ID_EX == rs2_IF_ID)) begin
                load_use_hazard_out = 1'b1;
            end
        end
    end
endmodule
