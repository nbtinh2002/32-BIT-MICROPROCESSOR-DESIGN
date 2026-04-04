//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : execute_cc.v
// Created      : 2026-04-04
// Description  : Executes ALU and branch operations in the pipeline.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:36:47 04/20/2024 
// Design Name: 
// Module Name:    execute_cc 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module execute_cc (
    input clk, rst,
    input RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE,
    input [1:0] ForwardAE, ForwardBE,
    input [3:0] ALUControlE,
    input [4:0] RDE,
    input [31:0] RD1E, RD2E, 
    input [31:0] ImmExtE, 
    input [31:0] PCE, 
    input [31:0] ResultW,

    output RegWriteM, ResultSrcM, MemWriteM, PCSrcE,
    output [4:0] RDM,
    output [31:0] WriteDataM, 
    output [31:0] PCTargetE, 
    output [31:0] ALUResultM
);

    wire ZeroE;
    wire [31:0] SrcAE, SrcBE, ALUResultE, SrcBE_out;

    mux3 MUX3_E1 (
        .a(RD1E), 
        .b(ResultW), 
        .c(ALUResultM), 
        .s(ForwardAE), 
        .d(SrcAE)
    );

    mux3 MUX3_E2 (
        .a(RD2E), 
        .b(ResultW), 
        .c(ALUResultM), 
        .s(ForwardBE), 
        .d(SrcBE)
    ); 

    mux2 MUX_E (
        .a(SrcBE), 
        .b(ImmExtE), 
        .s(ALUSrcE), 
        .c(SrcBE_out)
    );

    alu alu (
        .A(SrcAE), 
        .B(SrcBE_out), 
        .ALUControl(ALUControlE), 
        .Carry(), 
        .OverFlow(), 
        .Zero(ZeroE), 
        .Negative(), 
        .Result(ALUResultE)
    );

    adder ADDER_E (
        .a(PCE), 
        .b(ImmExtE), 
        .c(PCTargetE)
    );

    reg_3 REG_EXMEM (
        .clk(clk), 
        .rst(rst), 
        .ResultSrcE(ResultSrcE), 
        .MemWriteE(MemWriteE), 
        .RegWriteE(RegWriteE), 
        .ALUResultE(ALUResultE), 
        .SrcBE(SrcBE), 
        .RDE(RDE), 
        .ResultSrcM(ResultSrcM), 
        .MemWriteM(MemWriteM), 
        .RegWriteM(RegWriteM), 
        .ALUResultM(ALUResultM), 
        .WriteDataM(WriteDataM), 
        .RDM(RDM)
    );

    assign PCSrcE = BranchE & ZeroE;

endmodule



