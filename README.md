# Verilog HDL Projects

It is A collection of digital circuits that I built while learning Verilog/SystemVerilog. Starts from the basics (half adder, gates) and goes up to sequential stuff like shift registers, counters, and RAM. Everything properly tested and Simulated.

---

## What's inside

```
Verilog-Projects/
├── Half Adder/
├── Full Adder/
├── Full Subtractor/
├── Mux/
├── Demux/
├── Encoder/
├── Decoder/
├── Latches/
├── Flip-Flops/
├── Counters/
├── Multiple Mod counter/
├── Frequency Divison Circuits/
├── Shift Registers/
├── Universal Shift Register/
└── Ram/
```

Each folder has the design file and a testbench. Run them together on EDA Playground.

---

## Projects

### Combinational Circuits

**Half Adder / Full Adder / Full Subtractor**  
Basic arithmetic circuits. Half adder handles single-bit addition, full adder adds carry-in as well. Subtractor uses borrow logic. Good starting point before moving to more complex stuff.

**Mux & Demux**  
Multiplexer selects one of N inputs based on select lines. Demux does the reverse — routes a single input to one of multiple outputs. Both are designed with parameterized select widths.

**Encoder & Decoder**  
Priority encoder takes multiple input lines and encodes the highest-priority active one. Decoder is binary-to-one-hot — standard 2:4 and 3:8 implementations.

---

### Sequential Circuits

**Latches**  
SR and D latches — level-sensitive, not edge-triggered. Useful to understand the difference between latches and flip-flops before moving to registers.

**Flip-Flops**  
All four standard flip-flop types implemented — SR, D, JK, and T. All are synchronous, posedge-triggered with active-high reset and complementary `q`/`qbar` outputs. Key behaviors covered:
- **SR FF** — Set/Reset/Hold, plus the invalid state (S=1, R=1) explicitly handled by driving outputs to `x`
- **D FF** — Output directly follows `din` on clock edge; simplest of the four
- **JK FF** — Extends SR by replacing the invalid case with a toggle condition (J=1, K=1)
- **T FF** — Toggles output when `tin=1`, holds when `tin=0`; good building block for counters

Each has a dedicated testbench covering all input combinations and reset behavior.

**Shift Registers**  
Four types covered:
- SISO — serial in, serial out
- SIPO — serial in, parallel out
- PISO — parallel in, serial out
- PIPO — parallel in, parallel out

**Universal Shift Register**  
All four shift modes combined into one module, controlled by `s1` and `s0` select lines. This one took a bit of debugging — had to be careful with blocking vs non-blocking assignments.

**Counters**  
MOD-3, MOD-4, and MOD-8 counters with synchronous reset. The MOD-3 one is the interesting case — getting a 50% duty cycle out of an odd modulus counter isn't straightforward with a single clock edge, so it uses dual always blocks (posedge + negedge) with the outputs OR'd together.

**Multiple Mod Counter**  
Configurable counter where the modulus can be set as a parameter. More of a general-purpose design.

**Frequency Division Circuits**  
Divide-by-2 is trivial (toggle flip-flop). Divide-by-3 with 50% duty cycle is the tricky one — same dual-edge approach as the MOD-3 counter.

**RAM (Single Port)**  
Simple single-port RAM with separate read/write enable signals. Synchronous write, asynchronous read. Useful for understanding how memory modules are modeled in HDL before touching actual FPGA block RAM.

---

## Tools used

- **EDA Playground** — online simulator, no local setup needed
- **Aldec Riviera-PRO** — the compiler
- **EPWave** — for checking waveforms after simulation
- **DigitalJS Online** — occasionally used for quick logic visualization

---

## How to run any project

1. Open [edaplayground.com](https://edaplayground.com)
2. Set the simulator to **Aldec Riviera-PRO**
3. Paste the design (`.v` file) in the left panel
4. Paste the testbench in the right panel
5. Tick **"Open EPWave after run"** so waveforms load automatically
6. Hit Run

---

## A few things I learned along the way

- Mixing blocking and non-blocking assignments in the same always block causes subtle bugs that don't always show up immediately in simulation
- For odd-modulus counters, you can't get 50% duty cycle with a single clock edge — need to combine posedge and negedge logic
- Testbench quality matters as much as the design itself — a bad testbench gives false confidence
- Always check your port directions — `input`/`output` mismatches in module instantiation are a common source of silent failures

---

## About

**Dev Gothi** — VLSI Engineering student, SVNIT Surat  


GitHub: [@dev-gothi](https://github.com/dev-gothi)
