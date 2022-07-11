`timescale 1ns / 1ps

//`define POSTSYN

`ifdef POSTSYN
`include "../liberty/D_CELLS_3V/verilog/D_CELLS_3V.v"
`include "../liberty/D_CELLS_3V/verilog/VLG_PRIMITIVES.v"
`endif 

module Core_tb();

parameter instrFile  = "tb/instr_mem.txt"; 
parameter dataFile  = "tb/data_mem.txt"; 

parameter CLK_FREQ = 10e6;
real CLK_PER = (1.0 / CLK_FREQ) * 1e9;

reg clk;
reg rst;
reg [31:0] DIN_instr;
reg CE_instr;
reg WE_instr;
reg POR, HS, HR;
wire RDY_instr;
wire RDY_data;
wire [31:0] instruction;
wire [31:0] read_data;
wire [31:0] next_pc;
wire [31:0] next_pc_div_4;
wire [31:0] write_data;
wire [31:0] address_data;
wire write_mem_data;
wire read_mem_data;
reg CE_data;
reg WE_data;
reg SYS_RESET_DONE;
Core Core_inst(
    .clk(clk),
    .rst(rst),
    .instruction(instruction),
    .read_data(read_data),
    .next_pc(next_pc),
    .write_data(write_data),
    .address_data(address_data),
    .write_mem_data(write_mem_data),
    .read_mem_data(read_mem_data)
    );
NVR_TOP Instr_MEM(
    .A(next_pc_div_4),
    .DIN(DIN_instr),
    .TM_NVCP(4'h0),
    .CE(CE_instr),
    .HR(HR),
    .HS(HS),
    .MEM_ALLC(1'b0),
    .NVREF_EXT(1'b0), 
    .PEIN(1'b0),
    .POR(POR),
    .WE(WE_instr),
    .MEM_SEL(4'd0),
    .DUP(1'b0),
    .DSCLK(1'b0), 
    .DRSTN(1'b1),
    .DSI(1'b0), 
    .DSO(),
    .CLK4M(),
    .DOUT(instruction),
    .RDY(RDY_instr)
    );
NVR_TOP Data_MEM(
    .A(address_data),
    .DIN(write_data),
    .TM_NVCP(4'h0),
    .CE(CE_data),
    .HR(HR),
    .HS(HS),
    .MEM_ALLC(1'b0),
    .NVREF_EXT(1'b0),
    .PEIN(1'b0),
    .POR(POR),
    .WE(WE_data),
    .MEM_SEL(4'd0),
    .DUP(1'b0),
    .DSCLK(1'b0),
    .DRSTN(1'b1),
    .DSI(1'b0),
    .DSO(),
    .CLK4M(),
    .DOUT(read_data),
    .RDY(RDY_data)
    );


assign next_pc_div_4 = next_pc / 4;

always #(CLK_PER/2) clk = ~clk;
initial begin
    clk = 1;
    WE_instr = 0;
    WE_data = 0;
    CE_instr = 0;
    CE_data = 0;
    $timeformat(-6,6," us");
	$readmemb(instrFile, Instr_MEM.XNVR._SR_MEMORY, 0, 21);
	$display("%.1fns XNVR %m : INFO : Loading Initial Instr File ... %s \n", $realtime, instrFile);
    $readmemb(dataFile, Data_MEM.XNVR._SR_MEMORY, 0, 127); 
    $display("%.1fns XNVR %m : INFO : Loading Initial Data File ... %s \n", $realtime, dataFile);
    sys_reset;
	rst = 0;
	#(CLK_PER*3/2);
	rst = 1;
	#1000000;
    end
always@* begin
	if(next_pc == 32'd88) begin
		#(CLK_PER);
			#(CLK_PER);
		#(CLK_PER);
		#(CLK_PER);
		$finish;
	end
end
    always @(posedge clk) begin
        if(SYS_RESET_DONE == 1) begin
        CE_instr = 1;
        @(posedge RDY_instr);
        CE_instr = 0;
        end
    end
    always @(negedge clk) begin
        if(read_mem_data == 1) begin
            CE_data = 1;
            @(posedge RDY_instr);
            CE_data = 0;
        end
        if(write_mem_data == 1) begin
            WE_data = 1;
            #8;
            CE_data = 1;
            @(posedge RDY_instr);
            CE_data = 0;
            WE_data = 0;
        end
    end
    task sys_reset;
	// Description: Apply a low-active reset pulse
		begin
			POR= 0;
			rst = 1;
			$display("Applying system reset at %t",$time);
			#(CLK_PER);
			POR = 1;
			rst = 0;
			#(CLK_PER);
			POR = 0;
			rst = 1;
			#(CLK_PER);
            		SYS_RESET_DONE = 1;
		end
	endtask

endmodule

