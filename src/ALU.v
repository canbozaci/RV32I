`timescale 1ns / 1ps

module ALU(
    
    input [31:0]        alu_in1,
    input [31:0]        alu_in2,
    input [4:0]         funct_select,
    output reg [31:0]   alu_out,
    output              c_out,Z
    
    );
reg cin;     
wire[31:0] adder_src1,adder_src2,adder_out;
wire cout;

always @(*) begin
    
    
    if (funct_select[4]) begin // add subs karar veren 
        cin = 1;  
    end

    else begin
        cin = 0;
    end
end   
assign adder_src2 = alu_in2 ^ {32{cin}};     
    
SQRT_CSLA_ZFC adder (
                    .A(alu_in1),
                    .B(adder_src2),
                    .cin(cin),
                    .Y(adder_out),    
                    .cout(c_out),
                    .Z(Z)
                    ); 

always @(*) begin
    case (funct_select[3:0])
        4'b0000 : alu_out = adder_out; // ADD, ADDI, SUB
        4'b0001 : alu_out = alu_in1 ^ alu_in2; // XOR, XORI
        4'b0010 : alu_out = alu_in1 | alu_in2; // OR, ORI   
        4'b0011 : alu_out = alu_in1 & alu_in2; // AND, ANDI
        4'b0100 : alu_out = (alu_in1 < alu_in2) ? 32'd1 : 32'd0; // SLTU, SLTIU, BLTU 
        4'b0101 : alu_out = ($signed(alu_in1) < $signed(alu_in2)) ? 32'd1 : 32'd0; // SLT,SLTI,BLT
    //  4'b0110 : alu_out = (alu_in1 == alu_in2) ? 32'd1 : 32'd0; // BEQ 
    //  4'b0111 : alu_out = (alu_in1 == alu_in2) ? 32'd0 : 32'd1; // BNE
    //  4'b1000 : alu_out = (alu_in1 >= alu_in2) ? 32'd1 : 32'd0; // BGEU
    //  4'b1001 : alu_out = ($signed(alu_in1) >= $signed(alu_in2)) ? 32'd1 : 32'd0; // BGE
    endcase 
    end    
endmodule

