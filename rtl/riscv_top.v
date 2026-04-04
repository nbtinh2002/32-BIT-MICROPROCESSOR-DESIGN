//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : riscv_top.v
// Created      : 2026-04-04
// Description  : Top-level pipelined RISC-V microprocessor integration.
//=============================================================================
`timescale 1ns / 1ps
module riscv_top(
    input clk,
    input rst,
    output [31:0] ResultW 
);

    wire PCSrcE, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE;
    wire RegWriteM, ResultSrcM, MemWriteM;
    wire RegWriteW, ResultSrcW;
    wire [1:0] ForwardAE, ForwardBE;
    wire [3:0] ALUControlE;
    wire [4:0] RDW, RDE, RS1E, RS2E, RDM;
    wire [31:0] PCTargetE, InstrD, PCD, RD1E, RD2E, ImmExtE, PCE;
    wire [31:0] ALUResultW, ALUResultM, WriteDataM, ReadDataW;

    instruction_fetch_cc IF(
        .clk(clk),
        .rst(rst),
        .PCSrcE(PCSrcE),
        .PCTargetE(PCTargetE),
        .InstrD(InstrD),
        .PCD(PCD)
    );

    instruction_decode_cc ID(
        .clk(clk),
        .rst(rst),
        .RegWriteW(RegWriteW),
        .RDW(RDW),
        .PCD(PCD),
        .InstrD(InstrD),
        .ResultW(ResultW), 
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .BranchE(BranchE),
        .ALUSrcE(ALUSrcE),
        .ALUControlE(ALUControlE),
        .RDE(RDE),
        .RS1E(RS1E),
        .RS2E(RS2E),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .PCE(PCE),
        .ImmExtE(ImmExtE)
    );

    execute_cc EX(
        .clk(clk),
        .rst(rst),
        .RegWriteE(RegWriteE),
        .ResultSrcE(ResultSrcE),
        .MemWriteE(MemWriteE),
        .BranchE(BranchE),
        .ALUSrcE(ALUSrcE),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE),
        .ALUControlE(ALUControlE),
        .RDE(RDE),
        .RD1E(RD1E),
        .RD2E(RD2E),
        .ImmExtE(ImmExtE),
        .PCE(PCE),
        .ResultW(ResultW),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .MemWriteM(MemWriteM),
        .PCSrcE(PCSrcE),
        .RDM(RDM),
        .WriteDataM(WriteDataM),
        .PCTargetE(PCTargetE),
        .ALUResultM(ALUResultM)
    );

    memory_access_cc MEM(
        .clk(clk),
        .rst(rst),
        .RegWriteM(RegWriteM),
        .ResultSrcM(ResultSrcM),
        .MemWriteM(MemWriteM),
        .RDM(RDM),
        .ALUResultM(ALUResultM),
        .WriteDataM(WriteDataM),
        .RegWriteW(RegWriteW),
        .ResultSrcW(ResultSrcW),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .RDW(RDW)
    );

    writeback_cc WB(
        .ResultSrcW(ResultSrcW),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .ResultW(ResultW)
    );

    hazard_unit FB(
        .rst(rst),
        .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW),
        .RS1E(RS1E),
        .RS2E(RS2E),
        .RDM(RDM),
        .RDW(RDW),
        .ForwardAE(ForwardAE),
        .ForwardBE(ForwardBE)
    );

endmodule





