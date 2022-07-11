`timescale 1ns / 1ps

module barrel_arith_shift(
       input [31:0] A,
        input [4:0] shamt,
        output reg [31:0] out 
    );

wire msb;
assign msb = A[31];
    always @(*)
        begin
            case(shamt)
                5'd0 : out = {A[31:0]};
                5'd1 : out = {{1{msb}}, A[31:1]}; 
                5'd2 : out = {{2{msb}}, A[31:2]}; 
                5'd3 : out = {{3{msb}}, A[31:3]}; 
                5'd4 : out = {{4{msb}}, A[31:4]}; 
                5'd5 : out = {{5{msb}}, A[31:5]}; 
                5'd6 : out = {{6{msb}}, A[31:6]}; 
                5'd7 : out = {{7{msb}}, A[31:7]}; 
                5'd8 : out = {{8{msb}}, A[31:8]}; 
                5'd9 : out = {{9{msb}}, A[31:9]}; 
                5'd10 : out = {{10{msb}}, A[31:10]}; 
                5'd11 : out = {{11{msb}}, A[31:11]}; 
                5'd12 : out = {{12{msb}}, A[31:12]}; 
                5'd13 : out = {{13{msb}}, A[31:13]}; 
                5'd14 : out = {{14{msb}}, A[31:14]}; 
                5'd15 : out = {{15{msb}}, A[31:15]}; 
                5'd16 : out = {{16{msb}}, A[31:16]}; 
                5'd17 : out = {{17{msb}}, A[31:17]}; 
                5'd18 : out = {{18{msb}}, A[31:18]}; 
                5'd19 : out = {{19{msb}}, A[31:19]}; 
                5'd20 : out = {{20{msb}}, A[31:20]};
                5'd21 : out = {{21{msb}}, A[31:21]};
                5'd22 : out = {{22{msb}}, A[31:22]}; 
                5'd23 : out = {{23{msb}}, A[31:23]};
                5'd24 : out = {{24{msb}}, A[31:24]};
                5'd25 : out = {{25{msb}}, A[31:25]};
                5'd26 : out = {{26{msb}}, A[31:26]};
                5'd27 : out = {{27{msb}}, A[31:27]};
                5'd28 : out = {{28{msb}}, A[31:28]};
                5'd29 : out = {{29{msb}}, A[31:29]}; 
                5'd30 : out = {{30{msb}}, A[31:30]};
                5'd31 : out = {{31{msb}}, A[31]};
    endcase 
    end
endmodule