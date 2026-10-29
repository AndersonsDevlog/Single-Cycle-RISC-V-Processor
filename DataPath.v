`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 01:13:31 AM
// Design Name: 
// Module Name: DataPath
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


module DataPath #(
parameter PC_W = 8, // Program Counter
parameter INS_W = 32, // Instruction Width
parameter RF_ADDRESS = 5, // Register File Address
parameter DATA_W = 32, // Data WriteData
parameter DM_ADDRESS = 9, // Data Memory Address
parameter ALU_CC_W = 4 // ALU Control Code Width
)(
    input clk, // CLK in Datapath figure
    input reset, // Reset in Datapath figure
    input reg_write, // RegWrite in Datapath figure
    input mem2reg, // MemtoReg in Datapath figure
    input alu_src, // ALUSrc in Datapath figure
    input mem_write, // MemWrite in Datapath Figure
    input mem_read, // MemRead in Datapath Figure
    input [ALU_CC_W -1:0] alu_cc, // ALUCC in Datapath Figure
    output [6:0] opcode, // opcode in Datapath Figure
    output [6:0] funct7, // Funct7 in Datapath Figure
    output [2:0] funct3, // Funct3 in Datapath Figure
    output [DATA_W -1:0] alu_result // Datapath_Result in Datapath Figure
);
// Write your code here
    wire [PC_W-1:0] pc_plus4;
    wire [PC_W-1:0] pc;
    wire [INS_W-1:0] instr_data;
    wire [DATA_W -1:0] writeback_data;
    wire [DATA_W -1:0] reg1;
    wire [DATA_W -1:0] reg2;
    wire [DATA_W -1:0] ext_imm;
    wire [DATA_W -1:0] src_b;
    wire [DATA_W -1:0] datamem_read;
    
    wire [ RF_ADDRESS -1:0] rd_rg_wrt_wire;
    wire [ RF_ADDRESS -1:0] rd_rg_addr_wire1;
    wire [ RF_ADDRESS -1:0] rd_rg_addr_wire2;
    assign rd_rg_wrt_wire = instr_data [11:7];
    assign rd_rg_addr_wire1 = instr_data [19:15];
    assign rd_rg_addr_wire2 = instr_data [24:20];
    
    assign opcode = instr_data[6:0];
    assign funct3= instr_data[14:12];
    assign funct7 = instr_data[31:25];
    
    FlipFlop flipflop( 
        .clk(clk), 
        .reset(reset),
        .d(pc_plus4), 
        .q(pc)
    );
    
    InstMem instmem(
        .addr(pc),
        .instruction(instr_data)
    );
    
    assign pc_plus4 = pc + 4;

    ImmGen immgen ( 
        .InstCode(instr_data),
        .ImmOut(ext_imm)
    );
    
    RegFile regfile (
        .clk(clk), 
        .reset(reset), 
        .rg_wrt_en(reg_write),
        .rg_wrt_addr(rd_rg_wrt_wire),
        .rg_rd_addr1(rd_rg_addr_wire1),
        .rg_rd_addr2(rd_rg_addr_wire2),
        .rg_wrt_data(writeback_data),
        .rg_rd_data1(reg1),
        .rg_rd_data2(reg2)
    );
    
    
    Mux mux_to_alu (
        .S(alu_src),
        .D1(reg2),
        .D2(ext_imm),
        .Y(src_b)
    );
    
    ALU_32 alu (
        .A_in(reg1),
        .B_in(src_b),
        .ALU_Sel(alu_cc), 
        .ALU_Out(alu_result),
        .Carry_Out(),
        .Zero(),
        .Overflow()
    );
    
    DataMem datamem (
        .MemRead(mem_read), 
        .MemWrite(mem_write), 
        .addr(alu_result), 
        .write_data(reg2), 
        .read_data(datamem_read)
    );
    
    Mux mux_to_flipflop (
        .S(mem2reg),
        .D1(alu_result),
        .D2(datamem_read),
        .Y(writeback_data)
    );

endmodule
