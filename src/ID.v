`timescale 1ns / 1ps
module ID(
    input [31:0] instruction,
    output reg [4:0] funct_select, 
    output reg [4:0] rs1,
    output reg [4:0] rs2,
    output reg [4:0] rd,
    output reg [31:0] immediate_out,
    output reg MB_select,
    output reg MD_select,
    output reg MF_select,
    output reg read_mem,
    output reg write_mem,
    output reg load_enable,
    output reg PC_MUX,
    output reg [4:0] branch_select,
    output reg branch_instr
    );
    always @* begin //instruction decoding, calculating rs1,rs2,rd,funct3,funct7
        case(instruction[6:2]) // last 2 bits are 11 for RV32I, so dont need to look at those
        5'b00000: begin // LOAD| I
            branch_instr = 0;
            PC_MUX = 0;
            rs1 = instruction[19:15];
            rd = instruction[11:7];
            read_mem = 1;
            write_mem = 0;
            MB_select = 1;
            funct_select = 5'b00000;
            MF_select = 0;
            MD_select = 1;
            load_enable = 1;
            case (instruction[14:12])
            3'b000: begin // LB   
            end 
            3'b001: ; // LH
            3'b010: ; // LW
            3'b100: ; // LBU
            3'b101: ; // LHU
            endcase
        end
        5'b01000: begin // STORE| S
            branch_instr = 0;
            PC_MUX = 0;
            rs2 = instruction[24:20];
            rs1 = instruction[19:15];
            read_mem = 0;
            write_mem = 1;
            MB_select = 1;
            funct_select = 5'b00000;
            MF_select = 0;
            MD_select = 0;
            load_enable = 0;
            case (instruction[14:12])
            3'b000: ; // SB
            3'b001: ; // SH
            3'b010: ; // SW
            endcase
        end
        5'b11000: begin // BRANCH| B
            branch_instr = 1;
            PC_MUX = 0;
            rs2 = instruction[24:20];
            rs1 = instruction[19:15];
            read_mem = 0;
            write_mem = 0;
            MB_select = 0;
            MF_select = 0;
            load_enable = 0;
            case (instruction[14:12])
            3'b000: branch_select = 5'b00110; // BEQ
            3'b001: branch_select = 5'b00111; // BNE
            3'b100: branch_select = 5'b00101; // BLT
            3'b101: branch_select = 5'b01001; // BGE
            3'b110: branch_select = 5'b00100; // BLTU
            3'b111: branch_select = 5'b01000; // BGEU
            endcase
        end
        5'b00100: begin // Compare, Arithmetic, Logical | I
            // shiftlerdeki shamt? constant in mi secilcek
            branch_instr = 0;
            PC_MUX = 0;
            rs1 = instruction[19:15];
            rd = instruction[11:7];
            MB_select = 1;
            MD_select = 0;
            load_enable = 1;
            read_mem = 0;
            write_mem = 0;
            case (instruction[14:12])
            3'b000: begin // ADDI
                  funct_select = 5'b00000;
                  MF_select = 0;
            end
            3'b001: begin // SLLI
                funct_select = 5'b00001;
                MF_select = 1;
            end 
            3'b010: begin // SLTI
                funct_select = 5'b00101 ;
                MF_select = 0;
            end 
            3'b011: begin // SLTIU
                funct_select = 5'b00100 ;
                MF_select = 0;
            end 
            3'b100: begin // XORI
               funct_select =  5'b00001;
               MF_select = 0;
            end 
            3'b101: begin // SLLI,SRLI instruction[30] 1 ise SRAI 0'sa SRLI 
                if (instruction[30]) begin
                    funct_select =  5'b00010;
                    MF_select = 1;
                end
                else begin
                    funct_select =  5'b00000;
                    MF_select = 1;
                end
            end 
            3'b110: begin // ORI
                funct_select =  5'b00010;
                MF_select = 0;
            end 
            3'b111: begin // ANDI
                funct_select =  5'b00011;
                MF_select = 0;
            end 
            endcase
        end
        5'b01100: begin // Compare, Arithmetic, Logical | R
            branch_instr = 0;
            PC_MUX = 0;
            rs2 = instruction[24:20];
            rs1 = instruction[19:15];
            rd = instruction[11:7];
            MB_select = 0;
            MD_select = 0;
            load_enable = 1;
            read_mem = 0;
            write_mem = 0;
            case (instruction[14:12])
            3'b000: begin // ADD,SUB instruction[30] 1 ise SUB 0'sa ADD
                if (instruction[30]) begin
                    funct_select =  5'b10000;
                end
                else begin
                    funct_select = 5'b00000;
                end
                MF_select = 0;
            end
            3'b001: begin // SLL
                funct_select = 5'b00001;
                MF_select = 1;
            end 
            3'b010: begin // SLT
                funct_select = 5'b00101 ;
                MF_select = 0;
            end 
            3'b011: begin // SLTU
                funct_select = 5'b00100 ;
                MF_select = 0;
            end 
            3'b100: begin // XOR
                funct_select =  5'b00001;
                MF_select = 0;
             end 
            3'b101: begin // SLL,SRL instruction[30] 1 ise SRA 0'sa SRL 
                if (instruction[30]) begin
                     funct_select =  5'b00010;
                     MF_select = 1;
                end
                else begin
                     funct_select =  5'b00000;
                     MF_select = 1;
                end
            end 
            3'b110: begin // OR
                funct_select =  5'b00010;
                MF_select = 0;
            end 
            3'b111: begin // AND
                funct_select =  5'b00011;
                MF_select = 0;
             end 
            endcase
        end
        5'b01101: begin // LUI|U
            branch_instr = 0;
            PC_MUX = 0;
            rs1 = 0;
            read_mem = 0;
            write_mem = 0;
            MB_select = 1;
            funct_select = 5'b00000;
            MF_select = 0;
            MD_select = 0;
            load_enable = 1;
            rd = instruction[11:7];
        end
        5'b00101: begin // AUIPC|U
            branch_instr = 0;
            // rs1 = 0; AUIPC instructionun addressi olmalı? suan ki PC mi PC + 4 mü?
            PC_MUX = 1;
            read_mem = 0;
            write_mem = 0;
            MB_select = 1;
            funct_select = 5'b00000;
            MF_select = 0;
            MD_select = 0;
            load_enable = 1;
            rd = instruction[11:7];
        end
        5'b11011: begin // JAL|J
            branch_instr = 0;
            read_mem = 0;
            PC_MUX = 1; // mux en snoda reg fileye yazarken gitsin
            rs2 = 0;
            MB_select = 0;
            funct_select = 5'b00000;
            MF_select = 0;
            MD_select = 0;
            load_enable = 1;
            // JAL'da PC+4 'ü rd'ye sakla. Ve gitmek istedigin addresse git.
            rd = instruction[11:7];
        end
        5'b11001: begin // JALR|J
            branch_instr = 0;
            read_mem = 0;
            rs1 = instruction[19:15];
            MB_select = 0;
            funct_select = 5'b00000;
            MF_select = 0;
            MD_select = 0;
            load_enable = 1;
            PC_MUX = 1;
            // JAL'da PC+4 'ü rd'ye sakla. Ve gitmek istedigin addresse git.
            rd = instruction[11:7];
        end
        endcase
    end
    always @* begin // immediate decoding
	case(instruction[6:2])
		5'b01101,5'b00101 : immediate_out = { instruction[31:12], 12'b0 }; // U-type
		5'b11011 : immediate_out = { {12{ instruction[31] }}, instruction[19:12], instruction[20], instruction[30:21], 1'b0 };// J-type
		5'b11001,5'b00000,5'b00100 : immediate_out = { {21{ instruction[31] }}, instruction[30:20] };// I-type
		5'b11000 : immediate_out = { {20{ instruction[31] }}, instruction[7], instruction[30:25], instruction[11:8], 1'b0 };// B-type
		5'b01000 : immediate_out = { {21{ instruction[31] }}, instruction[30:25], instruction[11:7] };// S-type
		default  : immediate_out = 32'b0;
	endcase
    end
endmodule

