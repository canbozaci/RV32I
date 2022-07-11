`timescale 1ns / 1ps
module Forward_unit(
        input load_enable_EX_MEM,
        input [4:0] rd_EX_MEM,
        input [4:0] rs1_ID_EX,
        input [4:0] rs2_ID_EX,
        input load_enable_MEM_WB,
        input [4:0] rd_MEM_WB,
        output reg [1:0] ForwardA,
        output reg [1:0] ForwardB
    );

    always @* begin
        ForwardA = 2'b00; // take from reg file
        ForwardB = 2'b00;
        if(load_enable_EX_MEM && rd_EX_MEM) begin
            if(rd_EX_MEM == rs1_ID_EX) begin
                ForwardA = 2'b01; // take from EX_MEM
            end
            if(rd_EX_MEM == rs2_ID_EX) begin
                ForwardB = 2'b01;
            end
        end
        if(load_enable_MEM_WB && rd_MEM_WB) begin
            if((rd_MEM_WB == rs1_ID_EX) && (rd_EX_MEM != rs1_ID_EX) ) begin
                ForwardA = 2'b10; // take from MEM_WB
            end
            if((rd_MEM_WB == rs2_ID_EX) && (rd_EX_MEM != rs2_ID_EX)) begin
                ForwardB = 2'b10;
            end
        end
    end
endmodule

