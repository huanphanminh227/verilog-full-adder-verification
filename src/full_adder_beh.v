/**
 * @file full_adder_beh.v
 * @brief Behavioral RTL Implementation of 1-bit Full Adder
 * @details Uses procedural always block and arithmetic addition.
 */

module FULL_ADDER_BEH_MODEL (
    output reg S,
    output reg CO,
    input  wire A,
    input  wire B,
    input  wire CI
);

    always @(A or B or CI) begin
        {CO, S} = A + B + CI;
    end

endmodule
