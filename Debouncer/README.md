# Pulse Filter / Debounce FSM (Verilog)

## Problem Statement

Design a digital circuit to eliminate short-duration ("glitch") pulses from a sampled data stream.

- A single `0` sample surrounded by `1`s should be corrected to `1`.
- A single `1` sample surrounded by `0`s should be corrected to `0`.
- In other words, the output only changes when the *same* input value is observed for **two consecutive samples** — a lone opposite-value sample is treated as noise and ignored.

### Example

```
Input  : 0 1 0 0 1 1 0 1 1 0 0
Output : 0 0 0 0 0 1 1 1 1 1 0
```

## Approach

This is a classic **debounce** problem, modeled as a 4-state Mealy FSM with a registered (synchronous) output.

### States

| State | Meaning |
|-------|---------|
| `s0`  | Confirmed output = 0 |
| `s0w` | In `s0`, but just saw a single `1` — waiting to confirm |
| `s1`  | Confirmed output = 1 |
| `s1w` | In `s1`, but just saw a single `0` — waiting to confirm |

### State Transition Table

| Current State | din = 0 | din = 1 |
|---------------|---------|---------|
| `s0`  | → `s0`  (out=0) | → `s0w` (out=0) |
| `s0w` | → `s0`  (out=0) | → `s1`  (out=1) |
| `s1`  | → `s1w` (out=1) | → `s1`  (out=1) |
| `s1w` | → `s0`  (out=0) | → `s1`  (out=1) |

The output only flips (`s0w → s1` or `s1w → s0`) when the *same* new value is seen **twice in a row**. A single opposite sample sends the FSM back to the confirmed state without changing the output.

### Design Notes

- Implemented as a **Mealy machine** for the next-state and combinational output logic, but the final `dout` is **registered** (updated only on `posedge clk`) to guarantee a clean, glitch-free output — appropriate for a circuit whose entire purpose is signal cleanup.
- Three functional blocks:
  1. Combinational next-state logic (`ps`, `din` → `ns`)
  2. Combinational Mealy output logic (`ps`, `din` → `temp`)
  3. Sequential block: `posedge clk` updates `ps <= ns` and `dout <= temp`; `posedge reset` resets to `s0` with `dout = 0`

## Files

- `debouncer.v` — RTL design
- `debouncer_tb.v` — Testbench

## Verification

Simulated on [EDA Playground](https://www.edaplayground.com/) using Aldec Riviera-PRO.

Testbench drives the exact example sequence `0 1 0 0 1 1 0 1 1 0 0` into `din`, one sample per clock cycle, and the resulting `dout` waveform (delayed by one clock cycle due to output registration) was verified against the expected `0 0 0 0 0 1 1 1 1 1 0`.

## Tools Used

- Aldec Riviera-PRO (via EDA Playground)
- EPWave for waveform inspection
