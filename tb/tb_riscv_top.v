`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2024 03:35:32 PM
// Design Name: 
// Module Name: tb_riscv_top
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
module tb_riscv_top();
    reg clk, rst;

    // Instantiate the riscv_top module
    riscv_top uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end

    // Reset generation
    initial begin
        rst = 1; 
        #20;        // Ensure reset is held for at least one clock cycle
        rst = 0; 
        #480;      // Run simulation for a sufficient period
    $finish;    // End the simulation
    end

endmodule


