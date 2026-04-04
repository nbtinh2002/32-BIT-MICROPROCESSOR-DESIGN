//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : tb_mux2.v
// Created      : 2026-04-04
// Description  : Directed testbench for the 2-to-1 multiplexer.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2024 03:07:06 PM
// Design Name: 
// Module Name: tb_mux2
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


module tb_mux2();
    reg s;
    reg [31:0] a, b;
    wire [31:0] c;
    
    mux2 MUX2(.s(s), .a(a), .b(b), .c(c));
  
    initial begin
    a = 32'haaaaaaaa;b = 32'hbbbbbbbb;#10;
    s = 0;#10;
    s = 1;#10;
    $finish;
    end
    
endmodule


