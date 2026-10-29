`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 01:10:00 AM
// Design Name: 
// Module Name: DataMem
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


module DataMem ( MemRead , MemWrite , addr , write_data , read_data );
    input MemRead , MemWrite;
    input [8:0] addr;
    input [31:0] write_data;
    output reg [31:0] read_data;
    reg [31:0] memory[127:0];
    always @(*) begin
        if (MemRead) begin
            read_data = memory[addr[8:2]];
        end
        if (MemWrite) begin
            memory[addr[8:2]] = write_data;
        end
    end
    

endmodule
