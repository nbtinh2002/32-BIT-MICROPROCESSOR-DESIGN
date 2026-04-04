//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : tb_instruction_memory.v
// Created      : 2026-04-04
// Description  : Directed testbench for the instruction memory.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2024 02:55:27 PM
// Design Name: 
// Module Name: tb_instruction_memory
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


module tb_instruction_memory();
    reg rst;
    reg [31:0] A;
    wire [31:0] RD;
    
    instruction_memory IM_Module (.rst(rst), .A(A), .RD(RD));

    initial begin
        rst = 0; 
        A = 32'h00000000;#10;
        A = 32'h00000004;#10;
        A = 32'h00000008;#10;
        A = 32'h0000000C;#10;
        A = 32'h00000010;#10;
        rst = 1;
        A = 32'h0000000C;#10;
        A = 32'h00000010;#10;
        $stop;
    end   
	
endmodule


