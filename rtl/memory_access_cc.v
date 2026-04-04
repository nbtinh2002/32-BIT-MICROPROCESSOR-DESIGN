//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : memory_access_cc.v
// Created      : 2026-04-04
// Description  : Handles memory-stage pipeline registers and access.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:00:56 04/21/2024 
// Design Name: 
// Module Name:    memory_access_cc
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
module memory_access_cc(
	input clk, rst,
	input RegWriteM, ResultSrcM, MemWriteM,
	input [4:0] RDM,
	input [31:0] ALUResultM, WriteDataM,
	
	output RegWriteW, ResultSrcW, 
	output [4:0] RDW,
	output [31:0] ALUResultW, ReadDataW
    );
	
	wire [31:0] ReadDataM;
	
	data_memory DT_MEM (
		 .clk(clk), 
		 .rst(rst), 
		 .WE(MemWriteM), 
		 .A(ALUResultM), 
		 .WD(WriteDataM), 
		 .RD(ReadDataM)
		 );
	reg_4 REG_MEMWB (
        .clk(clk),
        .rst(rst),
        .ResultSrcM(ResultSrcM),
        .RegWriteM(RegWriteM),
        .ALUResultM(ALUResultM),
        .ReadDataM(ReadDataM),
        .RDM(RDM),
        .ResultSrcW(ResultSrcW),
        .RegWriteW(RegWriteW),
        .ALUResultW(ALUResultW),
        .ReadDataW(ReadDataW),
        .RDW(RDW)
    );

endmodule


