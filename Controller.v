`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2025 09:03:11 PM
// Design Name: 
// Module Name: Controller
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


module Controller (
    Opcode,
    ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite,
    ALUOp
    );
    input [6:0] Opcode;
    output reg ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite;
    output reg [1:0] ALUOp;
    
    always@(*) begin
        if (Opcode == 6'b0110011) begin
            MemtoReg = 0;
            MemWrite = 0;
            MemRead = 0;
            ALUSrc = 0;           
            RegWrite = 1;
            ALUOp = 2'b10;
        end
        else if (Opcode == 6'b0010011) begin
            MemtoReg = 0;
            MemWrite = 0;
            MemRead = 0;
            ALUSrc = 1;           
            RegWrite = 1;
            ALUOp = 2'b00;
        end
        else if (Opcode == 6'b0000011) begin       
            MemtoReg = 1;
            MemWrite = 0;
            MemRead = 1;
            ALUSrc = 1;
            RegWrite = 1;
            ALUOp = 2'b01;
        end
        else if (Opcode == 6'b0100011) begin
            MemtoReg = 0;
            MemWrite = 1;
            MemRead = 0;
            ALUSrc = 1;           
            RegWrite = 0;
            ALUOp = 2'b01;
        end  
    end
endmodule
