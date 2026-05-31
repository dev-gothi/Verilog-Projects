module tb;
    reg clk, reset, enable;
    wire fdiv5;

   dutycycle uut(.clk(clk), .reset(reset), 
                 .enable(enable), .fdiv5(fdiv5));

    // 10ns clock period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        // Step 1: apply reset
        reset = 1; enable = 0;
        #15;

        // Step 2: release reset, assert enable
        reset = 0; enable = 1;

        // Step 3: run for at least 4 full output periods (4×3=12 clk cycles = 120ns)
        #200;

        enable = 0;
        #20;
        $finish;
    end
endmodule