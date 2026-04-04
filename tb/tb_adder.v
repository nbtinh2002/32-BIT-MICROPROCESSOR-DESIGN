//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : tb_adder.v
// Created      : 2026-04-04
// Description  : Directed testbench for the adder.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2024 02:54:44 PM
// Design Name: 
// Module Name: tb_adder
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
module tb_adder();
    reg [31:0] a, b;
    wire [31:0] c;
    
    adder ADDER(.a(a), .b(b), .c(c));
 
    initial begin
    a = 32'h0000aaaa;b = 32'h0000bbbb;#10;
    a = 32'hffffffff;b = 32'hffffffff;#10;
    a = 32'hfffffffa;b = 32'h0000002c;#10;
    $finish;
    end
    
endmodule


