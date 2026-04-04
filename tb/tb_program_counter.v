//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : tb_program_counter.v
// Created      : 2026-04-04
// Description  : Directed testbench for the program counter.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2024 03:22:43 PM
// Design Name: 
// Module Name: tb_program_counter
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


module tb_program_counter();
    reg clk, rst;
    reg [31:0] PC_Next;
    wire [31:0] PC;

    program_counter ModulePC (.clk(clk), .rst(rst), .PC_Next(PC_Next), .PC(PC));

    initial begin
        clk = 1'b1;
        forever #10 clk = ~clk;
    end

    initial begin
        rst = 1'b0;
        PC_Next = 32'h0000aaaa; #20;
        PC_Next = 32'h0000bbbb; #20;
        PC_Next = 32'h0000cccc; #20;
        rst = 1'b1;#20;
        $finish;
    end
endmodule


