# Verilog HDL Projects

![Verilog](https://img.shields.io/badge/Verilog-IEEE1364-blue?style=flat-square&logo=v&logoColor=white)
![SystemVerilog](https://img.shields.io/badge/SystemVerilog-IEEE1800-purple?style=flat-square)
![EDA Playground](https://img.shields.io/badge/Simulator-EDA%20Playground-orange?style=flat-square)
![Riviera-PRO](https://img.shields.io/badge/Compiler-Aldec%20Riviera--PRO-red?style=flat-square)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-lightgrey?style=flat-square)

It is the collection of digital circuits that I built while learning Verilog/SystemVerilog. Starts from the basics (half adder, gates) and goes up to sequential stuff like shift registers, counters, and RAM, and now FSM-based designs like vending machines and debouncers. Everything properly tested and simulated.

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
├── Ram/
├── Digital_Door_Lock/
├── Elevator_Controller/
├── Debouncer/
├── Vending_Machine/
└── Sequence_Detector_1011/
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
- **T FF** — Toggles output when `tin=1`, holds when `tin=0`

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

### FSM Based

**Debouncer**  
4-state Moore-ish FSM (`s0`, `s0w`, `s1`, `s1w`) that filters out switch-bounce glitches on a noisy input line. The two "wait" states (`s0w`, `s1w`) act as a buffer — a single-cycle glitch back to the old value doesn't immediately flip the output, only a sustained level change does. Output is registered, so `dout` only updates once the FSM has actually settled into a stable state. Basic building block before touching real switch/button inputs on an FPGA.

**Vending Machine**  
5-state FSM (IDLE, COLLECTING, SUFFICIENT, DISPENSE, RETURNCHANGE) that accepts coins of varying denominations and dispenses an item once the running total crosses the price threshold (15). Tracks the inserted sum in a running register, flags `insufficient` while still collecting, and computes change combinationally in the RETURNCHANGE state before resetting the sum and looping back to IDLE. Good example of separating a datapath (the sum accumulator) from the controlling FSM.

**Sequence Detector (1011, Mealy)**  
4-state Mealy FSM (`s0`–`s3`) that detects the overlapping bit pattern `1011` on a serial input line. Each state tracks how much of the sequence has been matched so far — `s3` is reached once `101` has been seen, and `dout` pulses high the same cycle `din=1` completes the pattern, which is the defining trait of a Mealy machine (output depends on state *and* current input, not just state). Overlapping sequences are handled correctly too — after a detection, the FSM falls back to `s1` instead of `s0` if the last bit could also be the start of a new match, so back-to-back `1011011` style streams don't miss a hit.

**Elevator Controller**  
4-floor elevator controller implemented as a 4-state FSM — IDLE, MOVEUP, MOVEDOWN, and EMERGENCY. Floor requests come in as a 4-bit one-hot input; a priority encoder decodes the highest-priority request into a 2-bit target floor. The FSM compares target floor with current floor and decides direction. Current floor increments or decrements each clock cycle while moving. Door opens only in IDLE state, stays closed during movement. Emergency stop overrides any state immediately — motor halts, door stays closed — and holds until the signal is released. Reset brings the elevator to floor 0 with door open.

**Digital Door Lock**  
4-bit password-based door lock implemented as a Mealy/Moore FSM with 4 states — IDLE, UNLOCKED, ERROR, and ALARM. Wrong password increments an attempt counter; three consecutive wrong attempts trigger the alarm, which stays active until manual reset. Correct password from ERROR state unlocks directly without needing a reset. Supports runtime password update via a `setmode` signal, accessible only from the UNLOCKED state. Attempt counter resets only on successful unlock, not on reset — preventing alarm bypass.

---

## Tools used

| Tool | Purpose |
|------|---------|
| ![EDA Playground](https://img.shields.io/badge/-EDA%20Playground-orange?style=flat-square) | Online simulator, no local setup needed |
| ![Riviera-PRO](https://img.shields.io/badge/-Aldec%20Riviera--PRO-red?style=flat-square) | The compiler |
| ![EPWave](https://img.shields.io/badge/-EPWave-yellow?style=flat-square) | Checking waveforms after simulation |
| ![DigitalJS](https://img.shields.io/badge/-DigitalJS%20Online-lightblue?style=flat-square) | Occasional quick logic visualization |

---

## How to run any project

1. Open [edaplayground.com](https://edaplayground.com)
2. Set the simulator to **Aldec Riviera-PRO**
3. Paste the design (`.sv` file) in the left panel
4. Paste the testbench in the right panel
5. Tick **"Open EPWave after run"** so waveforms load automatically
6. Hit Run

---

## A few things I learned along the way

- Mixing blocking and non-blocking assignments in the same always block causes subtle bugs that don't always show up immediately in simulation
- For odd-modulus counters, you can't get 50% duty cycle with a single clock edge — need to combine posedge and negedge logic
- Splitting an FSM into separate `always` blocks for state register, next-state logic, and output logic makes debugging a lot easier than cramming everything into one block
- Testbench quality matters as much as the design itself — a bad testbench gives false confidence
- Always check your port directions — `input`/`output` mismatches in module instantiation are a common source of silent failures

---

## About

**Dev Gothi** — VLSI Engineering student, SVNIT Surat  

[![GitHub](https://img.shields.io/badge/GitHub-dev--gothi-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/dev-gothi)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-dev--gothi-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://LinkedIn.com/dev-gothi)
