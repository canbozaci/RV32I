`timescale 1ns / 1ps

module FU(

    input   [31:0]  fu_in1,
    input   [31:0]  fu_in2,
    input   [4:0]   funct_select,
    input           unit_sel,
    output  [31:0]  fu_out,
    output          c_out,Z    
    );

wire[4:0] shamt; 
wire[31:0] alu_out, shift_out;
wire[1:0] shift_sel;
wire c;
assign shamt = fu_in2[4:0];
assign c_out = c;
assign shift_sel = funct_select[1:0];
ALU alu (fu_in1,fu_in2,funct_select,alu_out,c,Z);
shifter shifter (fu_in1,shamt,shift_out,shift_sel);

assign fu_out = (~unit_sel) ? alu_out : shift_out; 

endmodule

