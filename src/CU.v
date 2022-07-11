`timescale 1ns / 1ps

module CU(
    input clk,
    input rst,
    input [31:0] fu_out,
    input [31:0] instruction,
    input branch_out_reg,
    input jal_out_reg,
    input jalr_out_reg,
    input [31:0] immediate_in_ID_EX,
    input [31:0] immediate_in_IF_ID,
    input load_use_hazard_out,
    output [31:0] next_pc,
    output [4:0] funct_select,
    output [4:0] rs1,
    output [4:0] rs2,
    output [4:0] rd,
    output [31:0] immediate_out,
    output MB_select,
    output MD_select,
    output MF_select,
    output read_mem,
    output write_mem,
    output load_enable,
    output PC_MUX,
    output branch_out,
    output jal_out,
    output jalr_out,
    output [4:0] branch_select,
    output branch_instr
    );

ID ID_inst(
    .instruction(instruction),
    .funct_select(funct_select), 
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .immediate_out(immediate_out),
    .MB_select(MB_select),
    .MD_select(MD_select),
    .MF_select(MF_select),
    .read_mem(read_mem),
    .write_mem(write_mem),
    .load_enable(load_enable),
    .PC_MUX(PC_MUX),
    .branch_select(branch_select),
    .branch_instr(branch_instr)
    );

PC PC_inst(
    .clk(clk),
    .rst(rst),
    .instruction(instruction),
    .fu_out(fu_out),
    .immediate_in_ID_EX(immediate_in_ID_EX),
    .immediate_in_IF_ID(immediate_in_IF_ID),
    .branch_out_reg(branch_out_reg),
    .jal_out_reg(jal_out_reg),
    .jalr_out_reg(jalr_out_reg),
    .load_use_hazard_out(load_use_hazard_out),
    .next_pc(next_pc),
    .branch_out(branch_out),
    .jal_out(jal_out),
    .jalr_out(jalr_out)
    );
endmodule


