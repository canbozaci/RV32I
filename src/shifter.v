`timescale 1ns / 1ps


module shifter(
    
        input [31:0]        A,
        input [4:0]         shamt,
        output reg [31:0]   out, 
        input [1:0]         shift_sel
    );
    
 wire [31:0] out_shifter1,out_shifter2,out_shifter3;   
 barrel_shifter_right shifter1 (A,shamt,out_shifter1);
 barrel_shifter_left shifter2 (A,shamt,out_shifter2);
 barrel_arith_shift shifter3 (A,shamt,out_shifter3);
 
 
 always  @(*) begin
    case(shift_sel)
        2'b00 : out = out_shifter1;
        2'b01 : out = out_shifter2;
        2'b10 : out = out_shifter3;
        default : out = 32'd0;
 
 endcase
 end
 
endmodule
