`timescale 1ns / 1ps

module SQRT_CSLA_ZFC(

    input [31:0] A,B,
    input cin,
    output [31:0] Y,
    output cout, Z
    );

wire [31:0] temp;
wire [6:0] carries;
wire [5:0] csel;
//// stage 1   
RCA #(2) rca1 (A[1:0],B[1:0],cin,carries[0],Y[1:0]);
///// stage 2
RCA_nocin #(2) rca2(A[3:2],B[3:2],carries[1],temp[3:2]);
ZFC #(2) zfc1 (temp[3:2],carries[0],carries[1],Y[3:2],csel[0]);
///// stage 3 
RCA_nocin #(3) rca3 (A[6:4],B[6:4],carries[2],temp[6:4]);
ZFC #(3) zfc2 (temp[6:4],csel[0],carries[2],Y[6:4],csel[1]);
///// stage 4
RCA_nocin #(4) rca4 (A[10:7],B[10:7],carries[3],temp[10:7]);
ZFC #(4) zfc3 (temp[10:7],csel[1],carries[3],Y[10:7],csel[2]);
///// stage 5 
RCA_nocin #(6) rca5 (A[16:11],B[16:11],carries[4],temp[16:11]);
ZFC #(6) zfc4 (temp[16:11],csel[2],carries[4],Y[16:11],csel[3]);
///// stage 6 
RCA_nocin #(7) rca6 (A[23:17],B[23:17],carries[5],temp[23:17]);
ZFC #(7) zfc5 (temp[23:17],csel[3],carries[5],Y[23:17],csel[4]);
///// stage 7 
RCA_nocin #(8) rca7 (A[31:24],B[31:24],carries[6],temp[31:24]);
ZFC #(8) zfc6 (temp[31:24],csel[4],carries[6],Y[31:24],csel[5]);


assign cout = csel[5];
assign Z = (Y == 0)? 1 : 0;   
    
endmodule
