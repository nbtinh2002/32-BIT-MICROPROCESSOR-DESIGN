//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : mux2.v
// Created      : 2026-04-04
// Description  : 2-to-1 multiplexer.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2024 03:05:48 PM
// Design Name: 
// Module Name: mux2
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


module mux2(
    input s,
    input [31:0] a,b,
    output[31:0] c
    );
    
    assign c = (s)? b : a;

endmodule


