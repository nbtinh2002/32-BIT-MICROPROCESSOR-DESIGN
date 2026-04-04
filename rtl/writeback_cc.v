`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2024 11:52:09 PM
// Design Name: 
// Module Name: writeback_cc
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


module writeback_cc(
	input ResultSrcW,
	input [31:0] ALUResultW,ReadDataW,
	output [31:0] ResultW
    );

	mux2 MUX_W (
		 .a(ALUResultW), 
		 .b(ReadDataW), 
		 .s(ResultSrcW), 
		 .c(ResultW)
		 );

endmodule

