module FULL_ADDER_ARCH_MODEL (
    output wire S,
    output wire CO,
    input  wire A,
    input  wire B,
    input  wire CI
);

    wire half_adder_instant0_y, half_adder_instant0_c;
    wire half_adder_instant1_y, half_adder_instant1_c;

    HALF_ADDER HA1 (.Y(half_adder_instant0_y), .C(half_adder_instant0_c), .A(A), .B(B));
    HALF_ADDER HA2 (.Y(half_adder_instant1_y), .C(half_adder_instant1_c), .A(half_adder_instant0_y), .B(CI));
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
