//=============================================================================
// Author       : Nguyen Bao Tinh
// Project      : 32-bit RISC-V Microprocessor
// Module       : tb_register_file.v
// Created      : 2026-04-04
// Description  : Directed testbench for the register file.
//=============================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2024 11:16:07 PM
// Design Name: 
// Module Name: tb_register_file
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


module tb_register_file();
	reg clk,rst,WE;
	reg [4:0] A1, A2, A3;
	reg [31:0] WD;
	// Outputs
	wire [31:0] RD1, RD2; 

	// Instantiate the Unit Under Test (UUT)
	register_file REG_FILE (
		.clk(clk), 
		.rst(rst), 
		.WE(WE), 
		.A1(A1), 
		.A2(A2), 
		.A3(A3), 
		.WD(WD), 
		.RD1(RD1), 
		.RD2(RD2)
	);

    initial begin
        clk = 1;
        forever #10 clk = ~clk; 
    end

    initial begin
    rst = 1;#40;
        rst = 0;
        A1 = 5'd3;A2 = 3;A3 = 5'd0;
        WD = 32'hBABABABA;
        WE = 0; #40;
        
        A3 = 5'd3;#40;
        
        WE = 1;#40;
        
        A1 = 5'd4;A2 = 5'd5;#40;
        A3 = 5'd4;#20;
        A3 = 5'd5;#20;
        WD = 32'hBABABABA;
        
        
        $finish;    
    end
        
endmodule


