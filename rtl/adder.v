//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : adder.v
// Created      : 2026-04-04
// Description  : 32-bit adder used in the datapath.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2024 02:53:50 PM
// Design Name: 
// Module Name: adder
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


module adder(
    input [31:0] a,b,
    output[31:0] c
    );
    
assign c = a + b;

endmodule

