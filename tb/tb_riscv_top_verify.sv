`timescale 1ns/1ps

module tb_riscv_top_verify;
    reg clk;
    reg rst;
    wire [31:0] ResultW;

    integer pass_count;
    integer fail_count;
    integer cycle;

    localparam CLK_PERIOD = 10;
    localparam RUN_CYCLES = 25;

    riscv_top dut (
        .clk    (clk),
        .rst    (rst),
        .ResultW(ResultW)
    );

    initial begin
        clk = 1'b0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    task automatic banner;
        input [1023:0] msg;
        begin
            $display("\n====================================================================");
            $display("%0s", msg);
            $display("====================================================================");
        end
    endtask

    task automatic check_reg;
        input integer idx;
        input [31:0] exp;
        reg [31:0] got;
        begin
            got = dut.ID.RegFile.Register[idx];
            if (got === exp) begin
                pass_count = pass_count + 1;
                $display("[PASS] x%0d = 0x%08h", idx, got);
            end else begin
                fail_count = fail_count + 1;
                $display("[FAIL] x%0d mismatch: got=0x%08h exp=0x%08h", idx, got, exp);
            end
        end
    endtask

    task automatic check_mem;
        input integer idx;
        input [31:0] exp;
        reg [31:0] got;
        begin
            got = dut.MEM.DT_MEM.mem[idx];
            if (got === exp) begin
                pass_count = pass_count + 1;
                $display("[PASS] DMEM[%0d] = 0x%08h", idx, got);
            end else begin
                fail_count = fail_count + 1;
                $display("[FAIL] DMEM[%0d] mismatch: got=0x%08h exp=0x%08h", idx, got, exp);
            end
        end
    endtask

    task automatic check_pc;
        input [31:0] exp;
        reg [31:0] got;
        begin
            got = dut.IF.PC.PC;
            if (got === exp) begin
                pass_count = pass_count + 1;
                $display("[PASS] PC = 0x%08h", got);
            end else begin
                fail_count = fail_count + 1;
                $display("[FAIL] PC mismatch: got=0x%08h exp=0x%08h", got, exp);
            end
        end
    endtask

    initial begin
        pass_count = 0;
        fail_count = 0;
        cycle      = 0;

        banner("TB VERIFY RISC-V TOP");
        $display("[INFO] Load program from tb/memfile.hex");
        $display("[INFO] Program intent:");
        $display("       x1 = 5");
        $display("       x2 = 7");
        $display("       x3 = x1 + x2 = 12");
        $display("       MEM[0] = x3 = 12");
        $display("       x4 = MEM[0] = 12");
        $display("       x5 = x4 + x1 = 17");

        rst = 1'b1;
        repeat (5) @(posedge clk);
        rst = 1'b0;

        repeat (RUN_CYCLES) @(posedge clk);

        banner("CHECK FINAL ARCHITECTURAL STATE");
        check_reg(0, 32'd0);
        check_reg(1, 32'd5);
        check_reg(2, 32'd7);
        check_reg(3, 32'd12);
        check_reg(4, 32'd12);
        check_reg(5, 32'd17);
        check_mem(0, 32'd12);
        check_pc(32'd100);

        banner("SUMMARY");
        $display("[INFO] PASS = %0d", pass_count);
        $display("[INFO] FAIL = %0d", fail_count);

        if (fail_count == 0)
            $display("[FINAL] ALL CHECKS PASSED");
        else
            $display("[FINAL] TEST FAILED");

        #20;
        $finish;
    end

    always @(posedge clk) begin
        if (!rst) begin
            cycle <= cycle + 1;
            $display("[MON] cycle=%0d PC=0x%08h InstrD=0x%08h ResultW=0x%08h x1=0x%08h x2=0x%08h x3=0x%08h x4=0x%08h x5=0x%08h mem0=0x%08h",
                     cycle,
                     dut.IF.PC.PC,
                     dut.InstrD,
                     ResultW,
                     dut.ID.RegFile.Register[1],
                     dut.ID.RegFile.Register[2],
                     dut.ID.RegFile.Register[3],
                     dut.ID.RegFile.Register[4],
                     dut.ID.RegFile.Register[5],
                     dut.MEM.DT_MEM.mem[0]);
        end
    end

endmodule
