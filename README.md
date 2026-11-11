# 1-Bit Full Adder: Multi-Modeling & Equivalence Verification

An RTL design and digital verification project implemented in **Verilog HDL**. This repository demonstrates two different hardware modeling methodologies for a 1-bit Full Adder and verifies their functional equivalence using an automated, self-checking testbench with assertion-based checking.

---

## Architecture Overview

### 1. Structural / Architecture Model (`src/full_adder_arch.v`)
* Modeled at the **gate level** by cascading two `HALF_ADDER` modules (`XOR` and `AND` primitives) connected via an `OR` gate and output buffer (`BUF`).
* Represents physical hardware gate interconnection and timing delay paths.

### 2. Behavioral Model (`src/full_adder_beh.v`)
* Modeled at the **Register Transfer Level (RTL)** using procedural continuous evaluation (`always @(A or B or CI)`).
* Uses Verilog arithmetic concatenation `{CO, S} = A + B + CI` for concise functional abstraction.

---

## Verification Strategy
The testbench (`sim/full_adder_tb.v`) runs an **exhaustive equivalence checking loop**:
* Injects all $2^3 = 8$ truth table combinations (`{CI, A, B}` from `000` to `111`).
* Compares outputs cycle-by-cycle via the assertion condition:
  $$\text{Equal} = (S_{\text{ARCH}} == S_{\text{BEH}}) \land (CO_{\text{ARCH}} == CO_{\text{BEH}})$$
* Triggers an immediate assertion error if any bit disparity occurs.
* Dumps signal transitions to `dump.vcd` for visual inspection in GTKWave or ModelSim.

---

## Truth Table Reference

| A | B | CI | S (Sum) | CO (Carry Out) |
| :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 0 | 1 | 0 | 1 |
| 1 | 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 1


---

## Project Structure

```text
verilog-full-adder-verification/
├── src/
│   ├── full_adder_arch.v   # Structural Gate-level model
│   └── full_adder_beh.v    # Behavioral RTL model
├── sim/
│   └── full_adder_tb.v     # Automated self-checking testbench
├── LICENSE                 # MIT License
└── README.md               # Technical documentation
```

--- 
###License
Distributed under the MIT License.
