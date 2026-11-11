/**
 * @file full_adder_arch.v
 * @brief Structural Gate-Level Implementation of 1-bit Full Adder
 * @details Implemented by cascading two Half Adders and an OR gate.
 */

module FULL_ADDER_ARCH_MODEL (
    output wire S,
    output wire CO,
    input  wire A,
    input  wire B,
    input  wire CI
);

    wire half_adder_instant0_y, half_adder_instant0_c;
    wire half_adder_instant1_y, half_adder_instant1_c;

    // Instantiate two Half Adders
    HALF_ADDER HA1 (
        .Y(half_adder_instant0_y),
        .C(half_adder_instant0_c),
        .A(A),
        .B(B)
    );

    HALF_ADDER HA2 (
        .Y(half_adder_instant1_y),
        .C(half_adder_instant1_c),
        .A(half_adder_instant0_y),
        .B(CI)
    );

    // Gate-level glue logic
    or  or_gate_ins   (CO, half_adder_instant0_c, half_adder_instant1_c);
    buf buf_gate_inst (S,  half_adder_instant1_y);

endmodule


module HALF_ADDER (
    output wire Y,
    output wire C,
    input  wire A,
    input  wire B
);

    xor xor_gate_0 (Y, A, B);
    and and_gate_0 (C, A, B);

endmodule
