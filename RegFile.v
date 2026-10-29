`timescale 1 ns / 1 ps
module RegFile (
clk , reset , rg_wrt_en ,
rg_wrt_addr ,
rg_rd_addr1 ,
rg_rd_addr2 ,
rg_wrt_data ,
rg_rd_data1 ,
rg_rd_data2
);
    input clk, reset, rg_wrt_en;
    input [4:0] rg_wrt_addr;
    input [4:0] rg_rd_addr1;
    input [4:0] rg_rd_addr2;
    input [31:0] rg_wrt_data;
    output [31:0] rg_rd_data1, rg_rd_data2;
    
    reg [31:0] register[31:0];
    integer i = 0;
    always @(posedge clk, reset) begin
        if (reset == 1) begin
            for (i = 0; i < 32; i = i + 1) begin
               register[i] = 0;
            end
        end
        else if (rg_wrt_en)
            register[rg_wrt_addr] = rg_wrt_data;
    end
    assign rg_rd_data1 = register[rg_rd_addr1];
    assign rg_rd_data2 = register[rg_rd_addr2];

endmodule