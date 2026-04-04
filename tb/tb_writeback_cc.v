//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : tb_writeback_cc.v
// Created      : 2026-04-04
// Description  : Directed testbench for the writeback stage.
//=============================================================================
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:40:05 04/22/2024
// Design Name:   WriteBack_Cycle
// Module Name:   E:/KLTN NH23-24/CPU_RISCV_PIPELINING/WriteBack_Cycle_tb.v
// Project Name:  CPU_RISCV_PIPELINING
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: WriteBack_Cycle
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_writeback_cc;

	// Inputs
	reg ResultSrcW;
	reg [31:0] ALUResultW;
	reg [31:0] ReadDataW;

	// Outputs
	wire [31:0] ResultW;

	// Instantiate the Unit Under Test (UUT)
	writeback_cc uut (
		.ResultSrcW(ResultSrcW), 
		.ALUResultW(ALUResultW), 
		.ReadDataW(ReadDataW), 
		.ResultW(ResultW)
	);

	initial begin
	ALUResultW = 32'hDEADBEEF; 
	ReadDataW = 32'hDADA_DADA;
    ResultSrcW = 0; #10;
    ResultSrcW = 1; #10;
    // Wait and finish
    $finish;
    end
      
endmodule



