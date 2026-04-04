//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : reg_1.v
// Created      : 2026-04-04
// Description  : Pipeline register stage 1.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2024 12:25:22 AM
// Design Name: 
// Module Name: reg_1
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
module reg_1(
    input clk,
    input rst,
    input [31:0] InstrF, 
    input [31:0] PCF,
    output reg [31:0] InstrD, 
    output reg [31:0] PCD
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            InstrD <= 32'd0;
            PCD <= 32'd0;
        end else begin
            InstrD <= InstrF;
            PCD <= PCF;
        end
    end
endmodule

