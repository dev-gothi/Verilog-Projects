# Vending Machine FSM (Verilog)

It is a Moore/Mealy-style vending machine controller implemented using a 5-state Finite State Machine in Verilog. The machine accepts coins, accumulates their value, dispenses an item once a sufficient amount has been collected, and returns any excess change.

## Overview

The vending machine requires a minimum total of a configurable **`PRICE`** (default `15`, coin units) to dispense an item. Coins are accepted one at a time via `coinvalid`/`coinvalue`, and any amount collected beyond `PRICE` is returned as `change` once the item is dispensed.

## Parameters

| Parameter | Default   | Description                                      |
|-----------|-----------|---------------------------------------------------|
| `PRICE`   | `5'd15`   | Item price; total coin value required to dispense |



```verilog
vendingmachine #(.PRICE(5'd20)) uut (
  .clk(clk),
  .reset(reset),
  .coinvalid(coinvalid),
  .coinvalue(coinvalue),
  .dispense(dispense),
  .insufficient(insufficient),
  .change(change)
);
```

## States

| State          | Encoding | Description                                              |
|----------------|----------|------------------------------------------------------------|
| `IDLE`         | 3'b000   | Waiting for the first coin to be inserted                 |
| `COLLECTING`   | 3'b001   | Accumulating coin value until `sum >= PRICE`               |
| `SUFFICIENT`   | 3'b010   | Enough money collected; transitions to dispense            |
| `DISPENSE`     | 3'b011   | Item is dispensed; checks if change is owed                |
| `RETURNCHANGE` | 3'b100   | Returns `sum - PRICE` as change, then resets to `IDLE`     |

## Ports

| Signal       | Direction | Width | Description                                  |
|--------------|-----------|-------|-----------------------------------------------|
| `clk`        | input     | 1     | Clock                                          |
| `reset`      | input     | 1     | Synchronous active-high reset                  |
| `coinvalid`  | input     | 1     | High when a valid coin is inserted             |
| `coinvalue`  | input     | 4     | Value of the inserted coin                     |
| `dispense`   | output    | 1     | Asserted while the item is being dispensed     |
| `insufficient` | output  | 1     | Asserted while collected amount is below 15    |
| `change`     | output    | 5     | Amount of change returned (`sum - 15`)         |

## Design Details

- **Sum accumulator**: A separate `sum` register accumulates `coinvalue` on every valid coin insertion while in `IDLE` or `COLLECTING`. It resets to 0 on `reset` or after change has been returned (`RETURNCHANGE` state).
- **State register**: Updates synchronously on `posedge clk`, with a synchronous active-high `reset` forcing the machine back to `IDLE`.
- **Next-state / output logic**: Combinational block (`always @(*)`) that computes `ns` (next state) and drives `dispense`, `insufficient`, and `change` based on the current state `ps`.
- **Threshold check**: The machine moves from `COLLECTING` to `SUFFICIENT` only when `sum >= PRICE`. While below threshold, `insufficient` stays high.
- **Change calculation**: If `sum > PRICE` when dispensing, the FSM enters `RETURNCHANGE`, where `change = sum - PRICE` is output for one cycle before returning to `IDLE`.
- **Configurable price**: `PRICE` is a module parameter (default `5'd15`), so the same RTL can be reused for different item prices without editing the logic.

## State Transition Flow

- **IDLE**
  - `coinvalid` → **COLLECTING**
  - else → stay **IDLE**
- **COLLECTING**
  - `sum >= PRICE` → **SUFFICIENT**
  - `sum < PRICE` → `insufficient = 1`, stay **COLLECTING**
- **SUFFICIENT**
  - → **DISPENSE**
- **DISPENSE**
  - `sum > PRICE` → **RETURNCHANGE**
  - `sum == PRICE` → **IDLE**
- **RETURNCHANGE**
  - `change = sum - PRICE` → **IDLE**

## Simulation Waveform

Below is a simulation waveform captured on EDA Playground / Aldec Riviera-PRO (with the default `PRICE = 15`), showing coin insertions, `coinvalue`, `dispense`, `insufficient`, and `change` behavior over time:

![Vending Machine Waveform](waveform.png)

### Waveform Walkthrough

1. `reset` is asserted initially, then deasserted.
2. First coin insertion: `coinvalid` pulses with `coinvalue = 1100` (12) — total is below 15, so `insufficient` goes high.
3. Second coin insertion: `coinvalue = 1010` (10) — cumulative sum now exceeds 15 (22 total), `insufficient` goes low.
4. `dispense` goes high as the item is dispensed.
5. Since `sum (22) > 15`, the FSM enters `RETURNCHANGE` and outputs `change = 111` (7), then resets `change` back to `0` and returns to `IDLE`.

## Tools Used

- **Language**: Verilog (RTL) with a testbench for functional verification
- **Simulator**: Aldec Riviera-PRO via EDA Playground

