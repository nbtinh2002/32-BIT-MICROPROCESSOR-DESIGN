//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : instruction_memory.v
// Created      : 2026-04-04
// Description  : Instruction memory initialized from a hex program image.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2024 02:40:53 PM
// Design Name: 
// Module Name: instruction_memory
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
module instruction_memory(
    input wire rst,
    input wire [31:0] A,
    output wire [31:0] RD
);
    reg [31:0] mem[0:1023];

    assign RD = (rst) ? 32'd0 : mem[A[31:2]];

    initial begin
        $readmemh("tb/memfile.hex", mem, 0, 1023);
    end
endmodule

