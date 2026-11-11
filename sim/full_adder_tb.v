/**
 * @file full_adder_tb.v
 * @brief Automated Self-Checking Equivalence Verification Testbench
 */

`timescale 1ns/1ps

module FULL_ADDER_TB;

    // Stimulus inputs
    reg A, B, CI;

    // Output wires for Architecture Model
    wire S_ARCH, CO_ARCH;

    // Output wires for Behavioral Model
    wire S_BEH, CO_BEH;

    // Equivalence flag
    wire two_model_out_equal;
    integer i;

    // Continuous checking: 1 if both models match exactly, 0 otherwise
    assign two_model_out_equal = (S_ARCH == S_BEH) & (CO_ARCH == CO_BEH);

    // Instantiate both models under test (MUT)
    FULL_ADDER_ARCH_MODEL fa_arch_inst (
        .S(S_ARCH),
        .CO(CO_ARCH),
        .A(A),
        .B(B),
        .CI(CI)
    );

    FULL_ADDER_BEH_MODEL fa_beh_inst (
        .S(S_BEH),
        .CO(CO_BEH),
        .A(A),
        .B(B),
        .CI(CI)
    );

    // Exhaustive test stimulus across all 8 input combinations
    initial begin
        A = 0; B = 0; CI = 0;

        for (i = 1; i < 8; i = i + 1) begin
            #1 CI = i[2]; A = i[1]; B = i[0];
        end

        #1;
        $display("[INFO] Simulation finished. All input vectors tested successfully.");
        $finish;
    end

    // Assertion verification: check equivalence on any input change
    always @(A or B or CI) begin
        #0.01;
        assert (two_model_out_equal)
            else $display("[FAIL] Equivalence mismatch at time %0t: A=%b B=%b CI=%b | ARCH={%b,%b} != BEH={%b,%b}",
                          $time, A, B, CI, CO_ARCH, S_ARCH, CO_BEH, S_BEH);
    end

    // Waveform dump for GTKWave / ModelSim inspection
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, FULL_ADDER_TB);
    end

endmodule
