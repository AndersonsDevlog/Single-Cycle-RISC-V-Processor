`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2025 09:11:01 PM
// Design Name: 
// Module Name: processor
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


module processor
(
    input clk , reset ,
    output [31:0] Result
);

    wire [6:0] Opcode;
    wire ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite;
    wire [1:0] ALUOp;
    wire [6:0] Funct7;
    wire [2:0] Funct3;
    wire [3:0] Operation_ALU_cc;

    DataPath dp_inst (
        .clk(clk) ,
        .reset(reset) ,
        .reg_write(RegWrite) ,
        .mem2reg(MemtoReg) ,
        .alu_src(ALUSrc) ,
        .mem_write(MemWrite) ,
        .mem_read(MemRead) ,
        .alu_cc(Operation_ALU_cc) ,
        .opcode(Opcode) ,
        .funct7(Funct7) ,
        .funct3(Funct3) ,
        .alu_result(Result)
    );
    
    Controller controller (
        .Opcode(Opcode),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALUOp(ALUOp)
    );
    
    ALUController alu_controller (
        .ALUOp(ALUOp),
        .Funct7(Funct7),
        .Funct3(Funct3),
        .Operation(Operation_ALU_cc)
        
    );
    
endmodule
