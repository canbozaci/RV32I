`timescale 1ns / 1ps

module Core(
    input clk,
    input rst,
    input  [31:0] instruction,
    input  [31:0] read_data,
    output [31:0] next_pc,
    output [31:0] write_data,
    output [31:0] address_data,
    output write_mem_data,
    output read_mem_data
  );
  // IF
  wire [31:0] next_pc_CU;
  reg [31:0]  next_pc_IF_ID;
  reg branch_EX_MEM;
  reg jal_EX_MEM;
  reg jalr_EX_MEM;
  reg [4:0] funct_select_IF_ID;
  reg [4:0] rs1_IF_ID;
  reg [4:0] rs2_IF_ID;
  reg [4:0] rd_IF_ID;
  reg [31:0] immediate_out_IF_ID;
  reg MB_select_IF_ID;
  reg MD_select_IF_ID;
  reg MF_select_IF_ID;
  reg read_mem_IF_ID;
  reg write_mem_IF_ID;
  reg load_enable_IF_ID;
  reg PC_MUX_IF_ID;
  reg branch_out_IF_ID;
  reg jal_out_IF_ID;
  reg jalr_out_IF_ID;
  wire [4:0] funct_select;
  wire [4:0] rs1;
  wire [4:0] rs2;
  wire [4:0] rd;
  wire [31:0] immediate_out;
  wire MB_select;
  wire MD_select;
  wire MF_select;
  wire read_mem;
  wire write_mem;
  wire load_enable;
  wire PC_MUX;
  wire branch_out;
  wire jal_out;
  wire jalr_out;
  // ID
  reg branch_true;
  wire [4:0] branch_select;
  wire branch_instr;
  reg [4:0] branch_select_IF_ID;
  reg branch_instr_IF_ID;
  reg [31:0]  next_pc_ID_EX;
  reg [4:0] funct_select_ID_EX;
  reg [4:0] rd_ID_EX;
  reg [4:0] rs1_ID_EX;
  reg [4:0] rs2_ID_EX;
  reg [31:0] immediate_out_ID_EX;
  reg MB_select_ID_EX;
  reg MD_select_ID_EX;
  reg MF_select_ID_EX;
  reg read_mem_ID_EX;
  reg write_mem_ID_EX;
  reg load_enable_ID_EX;
  reg PC_MUX_ID_EX;
  reg branch_out_ID_EX;
  reg jal_out_ID_EX;
  reg jalr_out_ID_EX;
  reg [31:0] A_data_out_ID_EX;
  reg [31:0] B_data_out_ID_EX;
  wire [31:0] A_data_out;
  wire [31:0] B_data_out;
  reg  branch_true_ID_EX;
  reg branch_instr_ID_EX;
  // EX
  reg [31:0] branch_dataA;
  reg [31:0] branch_dataB;
  wire [31:0] Mux_ForwardB_0_out;
  wire [31:0] Mux_ForwardB_1_out;
  wire [31:0] Mux_ForwardA_0_out;
  wire [31:0] Mux_ForwardA_1_out;
  wire [31:0] fu_out;
  reg [31:0]  next_pc_EX_MEM;
  wire[31:0] Bus_B;
  reg [4:0] rd_EX_MEM ;
  reg [31:0] immediate_out_EX_MEM;
  reg read_mem_EX_MEM;
  reg write_mem_EX_MEM ;
  reg load_enable_EX_MEM;
  reg PC_MUX_EX_MEM;
  reg branch_out_EX_MEM;
  reg jal_out_EX_MEM ;
  reg jalr_out_EX_MEM;
  reg [31:0] B_data_out_EX_MEM;
  reg [31:0] fu_out_EX_MEM;
  reg MD_select_EX_MEM;
  wire Z;
  wire c_out;
  // WB
  reg [31:0]  next_pc_MEM_WB;
  reg [31:0] read_data_MEM_WB;
  wire [31:0] data_MEM_WB;
  reg [4:0] rd_MEM_WB;
  reg load_enable_MEM_WB;
  reg PC_MUX_MEM_WB;
  reg MD_select_MEM_WB ;
  reg [31:0] fu_out_MEM_WB;
  wire [31:0] MUX_PC_OUT;
  // Hazard Detect Unit Inst
  wire load_use_hazard_out;
  Hazard_detect_unit hazard_detect_inst(
    .rd_ID_EX(rd_ID_EX),
    .rs1_IF_ID(rs1_IF_ID),
    .rs2_IF_ID(rs2_IF_ID),
    .read_mem_ID_EX(read_mem_ID_EX),
    .load_use_hazard_out(load_use_hazard_out)
  );
  // Forwarding Unit inst
  wire [1:0] ForwardA;
  wire [1:0] ForwardB;
  Forward_unit Forward_unit_inst(
        .load_enable_EX_MEM(load_enable_EX_MEM),
        .rd_EX_MEM(rd_EX_MEM),
        .rs1_ID_EX(rs1_ID_EX),
        .rs2_ID_EX(rs2_ID_EX),
        .load_enable_MEM_WB(load_enable_MEM_WB),
        .rd_MEM_WB(rd_MEM_WB),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );

  // IF Inst
  CU CU_inst(
       .clk(clk),
       .rst(rst),
       .fu_out(branch_true),
       .instruction(instruction),
       .branch_out_reg(branch_instr_IF_ID),
       .jal_out_reg(jal_out_IF_ID), //EX_MEM to IF_ID
       .jalr_out_reg(jalr_out_EX_MEM),
       .immediate_in_ID_EX(immediate_out_ID_EX),
       .immediate_in_IF_ID(immediate_out_IF_ID),
       .load_use_hazard_out(load_use_hazard_out),
       .next_pc(next_pc_CU),
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
       .branch_out(branch_out),
       .jal_out(jal_out),
       .jalr_out(jalr_out),
       .branch_select(branch_select),
       .branch_instr(branch_instr)
      );

     
    wire a; // temp wire for jal_out_IF_ID
    wire b; // temp wire for branch_instr_IF_ID
    assign next_pc = (load_use_hazard_out) ? next_pc_CU - 4 : next_pc_CU;
		assign a = jal_out_IF_ID;
assign b = branch_instr_IF_ID;
  always @(posedge clk) begin
    if(~rst) begin
      branch_instr_IF_ID <= 0;
      branch_select_IF_ID <= 0;
      next_pc_IF_ID <= 0;
      funct_select_IF_ID <= 0;
      rs1_IF_ID <= 0;
      rs2_IF_ID <= 0;
      rd_IF_ID <= 0;
      immediate_out_IF_ID <= 0;
      MB_select_IF_ID <= 0;
      MD_select_IF_ID <= 0;
      MF_select_IF_ID <= 0;
      read_mem_IF_ID <= 0;
      write_mem_IF_ID <= 0;
      load_enable_IF_ID <= 0;
      PC_MUX_IF_ID <= 0;
      branch_out_IF_ID <= 0;
      jal_out_IF_ID <= 0;
      jalr_out_IF_ID <= 0;
    end
    else if (a | (branch_true & b)) begin
      branch_instr_IF_ID <= 0;
      branch_select_IF_ID <= 0;
      next_pc_IF_ID <= 0;
      funct_select_IF_ID <= 0;
      rs1_IF_ID <= 0;
      rs2_IF_ID <= 0;
      rd_IF_ID <= 0;
      immediate_out_IF_ID <= 0;
      MB_select_IF_ID <= 0;
      MD_select_IF_ID <= 0;
      MF_select_IF_ID <= 0;
      read_mem_IF_ID <= 0;
      write_mem_IF_ID <= 0;
      load_enable_IF_ID <= 0;
      PC_MUX_IF_ID <= 0;
      branch_out_IF_ID <= 0;
      jal_out_IF_ID <= 0;
      jalr_out_IF_ID <= 0;
    end
    else begin
      branch_instr_IF_ID <= branch_instr;
      branch_select_IF_ID <= branch_select;
      next_pc_IF_ID <= next_pc_CU + 4;
      funct_select_IF_ID <= funct_select;
      rs1_IF_ID <= rs1;
      rs2_IF_ID <= rs2;
      rd_IF_ID <= rd;
      immediate_out_IF_ID <= immediate_out;
      MB_select_IF_ID <= MB_select;
      MD_select_IF_ID <= MD_select;
      MF_select_IF_ID <= MF_select;
      read_mem_IF_ID <= read_mem;
      write_mem_IF_ID <= write_mem;
      load_enable_IF_ID <= load_enable;
      PC_MUX_IF_ID <= PC_MUX;
      branch_out_IF_ID <= branch_out;
      jal_out_IF_ID <= jal_out;
      jalr_out_IF_ID <= jalr_out;
    end
  end
  // ID Stage
  RegisterFile RegisterFile_inst(
                 .clk(clk),
                 .load_enable(load_enable_MEM_WB),
                 .rst(rst),
                 .D_addr(rd_MEM_WB), //rd 5.stagede gelcek
                 .A_select(rs1_IF_ID),
                 .B_select(rs2_IF_ID),
                 .D_data(data_MEM_WB),  //data 5.stageden gelcek
                 .A_data(A_data_out),
                 .B_data(B_data_out)
               );

     always @* begin
    case(branch_select_IF_ID)
    5'b00110 : branch_true = (branch_dataA == branch_dataB) ? 1'd1 : 1'd0; // BEQ
    5'b00111 : branch_true = (branch_dataA == branch_dataB) ? 1'd0 : 1'd1; // BNE
    5'b00101 : branch_true = ($signed(branch_dataA) < $signed(branch_dataB)) ? 1'd1 : 1'd0; // BLT
    5'b01001 : branch_true = ($signed(branch_dataA) >= $signed(branch_dataB)) ? 1'd1 : 1'd0; // BGE
    5'b00100 : branch_true = (branch_dataA < branch_dataB) ? 1'd1 : 1'd0; // BLTU
    5'b01000 : branch_true = (branch_dataA >= branch_dataB) ? 1'd1 : 1'd0; // BGEU
    endcase
  end

  always @* begin
        branch_dataA = A_data_out;
        branch_dataB = B_data_out;
        if(load_enable_ID_EX && rd_ID_EX && branch_instr_IF_ID) begin
            if(rd_ID_EX == rs1_IF_ID) begin
                branch_dataA = fu_out; // take from EX_MEM
            end
            if(rd_ID_EX == rs2_IF_ID) begin
                branch_dataB = fu_out; // take from EX_MEM
            end
        end
        if(load_enable_EX_MEM && rd_EX_MEM && branch_instr_IF_ID) begin
          if(rd_EX_MEM == rs1_IF_ID) begin
            branch_dataA = fu_out_EX_MEM;// take from EX_MEM
          end
          if(rd_EX_MEM == rs2_IF_ID) begin
            branch_dataB = fu_out_EX_MEM;
          end
      end
      if(load_enable_MEM_WB && rd_MEM_WB && branch_instr_IF_ID) begin
          if((rd_MEM_WB == rs1_IF_ID)) begin
              branch_dataA = fu_out_MEM_WB; // take from MEM_WB
          end
          if((rd_MEM_WB == rs2_IF_ID)) begin
             branch_dataB = fu_out_MEM_WB
          end
      end
    end
  always @(posedge clk) begin
    if(~rst) begin
      branch_instr_ID_EX  <= 0;
      branch_true_ID_EX   <= 0;
      rs1_ID_EX           <= 0;
      rs2_ID_EX           <= 0;
      next_pc_ID_EX       <= 0;
      funct_select_ID_EX  <= 0;
      rd_ID_EX            <= 0;
      immediate_out_ID_EX <= 0;
      MB_select_ID_EX     <= 0;
      MD_select_ID_EX     <= 0;
      MF_select_ID_EX     <= 0;
      read_mem_ID_EX      <= 0;
      write_mem_ID_EX     <= 0;
      load_enable_ID_EX   <= 0;
      PC_MUX_ID_EX        <= 0;
      branch_out_ID_EX    <= 0;
      jal_out_ID_EX       <= 0;
      jalr_out_ID_EX      <= 0;
      A_data_out_ID_EX    <= 0;
      B_data_out_ID_EX    <= 0;
    end
    else if (load_use_hazard_out) begin
      branch_instr_ID_EX  <= 0;
      branch_true_ID_EX   <= 0;
      rs1_ID_EX           <= 0;
      rs2_ID_EX           <= 0;
      next_pc_ID_EX       <= 0;
      funct_select_ID_EX  <= 0;
      rd_ID_EX            <= 0;
      immediate_out_ID_EX <= 0;
      MB_select_ID_EX     <= 0;
      MD_select_ID_EX     <= 0;
      MF_select_ID_EX     <= 0;
      read_mem_ID_EX      <= 0;
      write_mem_ID_EX     <= 0;
      load_enable_ID_EX   <= 0;
      PC_MUX_ID_EX        <= 0;
      branch_out_ID_EX    <= 0;
      jal_out_ID_EX       <= 0;
      jalr_out_ID_EX      <= 0;
      A_data_out_ID_EX    <= 0;
      B_data_out_ID_EX    <= 0;
    end
    else begin
      branch_instr_ID_EX  <= branch_instr_IF_ID;
      branch_true_ID_EX   <= branch_true;
      rs1_ID_EX           <= rs1_IF_ID;
      rs2_ID_EX           <= rs2_IF_ID;
      next_pc_ID_EX       <= next_pc_IF_ID;
      funct_select_ID_EX  <= funct_select_IF_ID;
      rd_ID_EX            <= rd_IF_ID;
      immediate_out_ID_EX <= immediate_out_IF_ID;
      MB_select_ID_EX     <= MB_select_IF_ID;
      MD_select_ID_EX     <= MD_select_IF_ID;
      MF_select_ID_EX     <= MF_select_IF_ID;
      read_mem_ID_EX      <= read_mem_IF_ID;
      write_mem_ID_EX     <= write_mem_IF_ID;
      load_enable_ID_EX   <= load_enable_IF_ID;
      PC_MUX_ID_EX        <= PC_MUX_IF_ID;
      branch_out_ID_EX    <= branch_out_IF_ID;
      jal_out_ID_EX       <= jal_out_IF_ID;
      jalr_out_ID_EX      <= jalr_out_IF_ID;
      A_data_out_ID_EX    <= A_data_out;
      B_data_out_ID_EX    <= B_data_out;
    end
  end
  // EX Stage
  FU FU_inst(
       .fu_in1(Mux_ForwardA_1_out),
       .fu_in2(Bus_B),
       .funct_select(funct_select_ID_EX),
       .unit_sel(MF_select_ID_EX),
       .fu_out(fu_out),
       .c_out(c_out),
       .Z(Z)
     );
  MUX2to1 MUX_B(.data_in1(Mux_ForwardB_1_out),.data_in2(immediate_out_ID_EX),.select(MB_select_ID_EX),.data_out(Bus_B)); // constant pick
  MUX2to1 MUX_ForwardB_0(.data_in1(B_data_out_ID_EX),.data_in2(fu_out_EX_MEM),.select(ForwardB[0]),.data_out(Mux_ForwardB_0_out)); // forward from ex/mem
  MUX2to1 MUX_ForwardB_1(.data_in1(Mux_ForwardB_0_out),.data_in2(data_MEM_WB),.select(ForwardB[1]),.data_out(Mux_ForwardB_1_out)); // forward from mem/wb
  MUX2to1 MUX_ForwardA_0(.data_in1(A_data_out_ID_EX),.data_in2(fu_out_EX_MEM),.select(ForwardA[0]),.data_out(Mux_ForwardA_0_out)); 
  MUX2to1 MUX_ForwardA_1(.data_in1(Mux_ForwardA_0_out),.data_in2(data_MEM_WB),.select(ForwardA[1]),.data_out(Mux_ForwardA_1_out));
  always @(posedge clk) begin
    if(~rst) begin
      next_pc_EX_MEM        <=0;
      rd_EX_MEM             <=0;
      immediate_out_EX_MEM  <=0;
      write_mem_EX_MEM      <=0;
      load_enable_EX_MEM    <=0;
      PC_MUX_EX_MEM         <=0;
      branch_out_EX_MEM     <=0;
      jal_out_EX_MEM        <=0;
      jalr_out_EX_MEM       <=0;
      B_data_out_EX_MEM     <=0;
      fu_out_EX_MEM         <=0;
      MD_select_EX_MEM      <=0;
      read_mem_EX_MEM       <=0;
    end
  else begin
    next_pc_EX_MEM        <= next_pc_ID_EX      ;
    rd_EX_MEM             <= rd_ID_EX           ;
    immediate_out_EX_MEM  <= immediate_out_ID_EX;
    write_mem_EX_MEM      <= write_mem_ID_EX    ;
    load_enable_EX_MEM    <= load_enable_ID_EX  ;
    PC_MUX_EX_MEM         <= PC_MUX_ID_EX       ;
    branch_out_EX_MEM     <= branch_out_ID_EX   ;
    jal_out_EX_MEM        <= jal_out_ID_EX      ;
    jalr_out_EX_MEM       <= jalr_out_ID_EX     ;
    B_data_out_EX_MEM     <= Mux_ForwardB_1_out ;
    fu_out_EX_MEM         <= fu_out             ;
    MD_select_EX_MEM      <= MD_select_ID_EX    ;
    read_mem_EX_MEM       <= read_mem_ID_EX     ;
  end
end
// Mem Stage
assign write_data = B_data_out_EX_MEM;
assign address_data = fu_out_EX_MEM;
assign write_mem_data = write_mem_EX_MEM;
assign read_mem_data = read_mem_EX_MEM;
always @(posedge clk) begin
  if(~rst) begin
    next_pc_MEM_WB      <= 0;
    rd_MEM_WB           <= 0;
    load_enable_MEM_WB  <= 0;
    PC_MUX_MEM_WB       <= 0;
    MD_select_MEM_WB    <= 0;
    fu_out_MEM_WB       <= 0;
    read_data_MEM_WB    <= 0;
  end
  else begin
    next_pc_MEM_WB      <= next_pc_EX_MEM    ;
    rd_MEM_WB           <= rd_EX_MEM         ;
    load_enable_MEM_WB  <= load_enable_EX_MEM;
    PC_MUX_MEM_WB       <= PC_MUX_EX_MEM     ;
    MD_select_MEM_WB    <= MD_select_EX_MEM  ;
    fu_out_MEM_WB       <= fu_out_EX_MEM     ;
    read_data_MEM_WB    <= read_data        ;
  end
end
// Writeback Stage
MUX2to1 MUX_PC(.data_in1(fu_out_MEM_WB),.data_in2(next_pc_MEM_WB),.select(PC_MUX_MEM_WB),.data_out(MUX_PC_OUT));
MUX2to1 MUX_D(.data_in1(MUX_PC_OUT),.data_in2(read_data_MEM_WB),.select(MD_select_MEM_WB),.data_out(data_MEM_WB));
endmodule

