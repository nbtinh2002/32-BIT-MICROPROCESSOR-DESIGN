//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : control_unit.v
// Created      : 2026-04-04
// Description  : Generates top-level control signals.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2024 03:59:38 PM
// Design Name: 
// Module Name: control_unit
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

module control_unit(
    input [6:0]Op,funct7,
    input [2:0]funct3,
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch,
    output [1:0]ImmSrc,
    output [3:0]ALUControl
    );
    
    wire [1:0]ALUOp;
    
    main_decoder MAIN_DE (
        .Op(Op), 
        .RegWrite(RegWrite), 
        .ALUSrc(ALUSrc), 
        .MemWrite(MemWrite), 
        .ResultSrc(ResultSrc), 
        .Branch(Branch), 
        .ImmSrc(ImmSrc), 
        .ALUOp(ALUOp)
        );  
    alu_decoder ALU_DE (
        .ALUOp(ALUOp), 
        .funct3(funct3), 
        .funct7(funct7), 
        .op(Op), 
        .ALUControl(ALUControl)
        );
endmodule

