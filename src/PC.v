`timescale 1ns / 1ps
module PC(
    input  clk,
    input  rst,
    input  [31:0] instruction,
    input  [31:0] fu_out,
    input  [31:0] immediate_in_ID_EX,
    input  [31:0] immediate_in_IF_ID,
    input branch_out_reg,
    input jal_out_reg,
    input jalr_out_reg,
    input load_use_hazard_out,
    output reg [31:0] next_pc,
    output reg branch_out,
    output reg jal_out,
    output reg jalr_out
    );
    always @(posedge clk) begin
        if (rst == 0) begin
            next_pc <= 0;
        end
        else if(load_use_hazard_out) begin
            next_pc <= next_pc;
        end
        else if (jal_out_reg) begin
            next_pc <= next_pc + immediate_in_IF_ID - 32'd4;
        end
        else if (jalr_out_reg) begin
            next_pc <= fu_out; 
        end
        else if (branch_out_reg) begin // ici degiscek
            if(fu_out == 32'd1) begin
                next_pc <= next_pc + immediate_in_IF_ID - 32'd4;
            end
            else begin
                next_pc <= next_pc + 4;
            end
        end
        else begin
            next_pc <= next_pc + 4;
        end
    end
    always @* begin
        case (instruction[6:2])
        5'b11000: begin //branch
            branch_out = 1;
        end
        5'b11011: begin  // JAL
            jal_out = 1;
        end
        5'b11001: begin// JALR
            jalr_out = 1;
        end
        default:  begin 
            branch_out = 0;
            jal_out = 0;
            jalr_out = 0;
        end
        endcase
    end
endmodule

