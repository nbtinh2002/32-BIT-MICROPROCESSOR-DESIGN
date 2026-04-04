`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:10:20 04/22/2024
// Design Name:   hazard_unit
// Module Name:   E:/KLTN NH23-24/CPU_RISCV_PIPELINING/Hazard_Unit_tb.v
// Project Name:  CPU_RISCV_PIPELINING
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: hazard_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_hazard_unit;

    // Inputs
    reg rst;
    reg RegWriteM;
    reg RegWriteW;
    reg [4:0] RS1E;
    reg [4:0] RS2E;
    reg [4:0] RDM;
    reg [4:0] RDW;

    // Outputs
    wire [1:0] ForwardAE;
    wire [1:0] ForwardBE;

    // Instantiate the Unit Under Test (UUT)
    hazard_unit uut (
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

    // Test case procedure
    initial begin
    // Test Case 1: Reset
    rst = 1; #10;
    // Test Case 2: No forwarding 
    rst = 0; 
    RegWriteM = 0; 
    RegWriteW = 0; 
    RS1E = 5'h1; 
    RS2E = 5'h2; 
    RDM = 5'h3; 
    RDW = 5'h4;
    #10;
                 //  No forwarding due to zero registers
    RDM = 5'h0;
    RDW = 5'h0;
    #10;
    // Test Case 3: Forward from MEM to alu input A
    RDM = 5'h3; 
    RDW = 5'h4;
    RS1E = 5'h1;
    RegWriteM = 1;
    RDM = 5'h1;
    #10;
                   // Forward from WB to alu input A
    RegWriteM = 0;
    RDM = 5'h0;
    RegWriteW = 1;
    RDW = 5'h1;
    #10;
    // Test Case 4: Forward from MEM to alu input B
    RS1E = 5'h0;
    
    RS2E =5'h1;
    RegWriteM = 1;
    RDM = 5'h1;
    #10;
                // : Forward from WB to alu input B
    RegWriteM = 0;
    RDM = 5'h0;
    RegWriteW = 1;
    RDW = 5'h1;
    #10;
    
    // Test Case 5: Both forwarding paths active
    RegWriteM = 1;
    RegWriteW = 1;
    RS1E = 5'h1;
    RS2E = 5'h1;
    RDM = 5'h1;
    RDW = 5'h1;
    #10;
       
    $finish;
    end
endmodule


