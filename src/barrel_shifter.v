`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.05.2022 11:38:10
// Design Name: 
// Module Name: barrel_shifter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module barrel_shifter_left(
        input [31:0] A,
        input [4:0] shamt,
        output reg [31:0] out 
    );


    always @(*)
        begin
            case(shamt)
                5'd0 : out = {A[31:0]};
                5'd1 : out = {A[30:0], 1'd0};   
                5'd2 : out = {A[29:0], 2'd0};   
                5'd3 : out = {A[28:0], 3'd0};   
                5'd4 : out = {A[27:0], 4'd0};   
                5'd5 : out = {A[26:0], 5'd0};   
                5'd6 : out = {A[25:0], 6'd0};   
                5'd7 : out = {A[24:0], 7'd0};   
                5'd8 : out = {A[23:0], 8'd0};   
                5'd9 : out = {A[22:0], 9'd0};   
                5'd10 : out = {A[21:0], 10'd0}; 
                5'd11 : out = {A[20:0], 11'd0}; 
                5'd12 : out = {A[19:0], 12'd0}; 
                5'd13 : out = {A[18:0], 13'd0}; 
                5'd14 : out = {A[17:0], 14'd0}; 
                5'd15 : out = {A[16:0], 15'd0};
                5'd16 : out = {A[15:0], 16'd0};
                5'd17 : out = {A[14:0], 17'd0};
                5'd18 : out = {A[13:0], 18'd0}; 
                5'd19 : out = {A[12:0], 19'd0};
                5'd20 : out = {A[11:0], 20'd0};
                5'd21 : out = {A[10:0], 21'd0};
                5'd22 : out = {A[9:0], 22'd0};
                5'd23 : out = {A[8:0], 23'd0};
                5'd24 : out = {A[7:0], 24'd0};
                5'd25 : out = {A[6:0], 25'd0}; 
                5'd26 : out = {A[5:0], 26'd0};
                5'd27 : out = {A[4:0], 27'd0};
                5'd28 : out = {A[3:0], 28'd0};
                5'd29 : out = {A[2:0], 29'd0};
                5'd30 : out = {A[1:0], 30'd0};
                5'd31 : out = {A[0], 31'd0};       
    endcase 
    end
endmodule

module barrel_shifter_right(
        input [31:0] A,
        input [4:0] shamt,
        output reg [31:0] out 
    );


    always @(*)
        begin
            case(shamt)
                5'd0 : out = {A[31:0]};
                5'd1 : out = {1'd0, A[31:1]}; 
                5'd2 : out = {2'd0, A[31:2]};
                5'd3 : out = {3'd0, A[31:3]};
                5'd4 : out = {4'd0, A[31:4]};
                5'd5 : out = {5'd0, A[31:5]}; 
                5'd6 : out = {6'd0, A[31:6]};
                5'd7 : out = {7'd0, A[31:7]};
                5'd8 : out = {8'd0, A[31:8]};
                5'd9 : out = {9'd0, A[31:9]};
                5'd10 : out = {10'd0, A[31:10]};
                5'd11 : out = {11'd0, A[31:11]};
                5'd12 : out = {12'd0, A[31:12]}; 
                5'd13 : out = {13'd0, A[31:13]};
                5'd14 : out = {14'd0, A[31:14]};
                5'd15 : out = {15'd0, A[31:15]};
                5'd16 : out = {16'd0, A[31:16]};
                5'd17 : out = {17'd0, A[31:17]};
                5'd18 : out = {18'd0, A[31:18]}; 
                5'd19 : out = {19'd0, A[31:19]};
                5'd20 : out = {20'd0, A[31:20]};
                5'd21 : out = {21'd0, A[31:21]};
                5'd22 : out = {22'd0, A[31:22]};
                5'd23 : out = {23'd0, A[31:23]};
                5'd24 : out = {24'd0, A[31:24]};
                5'd25 : out = {25'd0, A[31:25]};
                5'd26 : out = {26'd0, A[31:26]}; 
                5'd27 : out = {27'd0, A[31:27]};
                5'd28 : out = {28'd0, A[31:28]};
                5'd29 : out = {29'd0, A[31:29]};
                5'd30 : out = {30'd0, A[31:30]};
                5'd31 : out = {31'd0, A[31]};
    endcase 
    end
endmodule
