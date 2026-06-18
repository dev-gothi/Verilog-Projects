# 🛗 4-Floor Elevator Controller — FSM-Based Verilog Design

It is **Finite State Machine (FSM)** based digital design of a 4-floor elevator controller implemented in Verilog HDL. The design includes a combinational priority encoder for floor requests, a Moore-style FSM for movement control, and an emergency stop feature — all driven by a synchronous clock.

---

## 📌 Project Overview

My project models the core control logic of a 4-floor elevator system (Floor 0 to Floor 3). It determines the elevator's target floor from incoming requests using a **priority encoder**, drives the motor UP or DOWN accordingly, and handles **emergency stop** conditions. The design is fully synchronous and simulation-verified on EDA Playground.

---

## 🗂️ Repository Structure

```
Elevator-Controller/
├── src/
│   ├── elevatordesign.v          # Main FSM + encoder module
│   └── elevatordesign_tb.v       # Testbench
├── sim/
│   └── waveform_screenshot.png   # EPWave simulation output
└── README.md
```

---

## ⚙️ Features

- ✅ 4-state FSM — IDLE, MOVEUP, MOVEDOWN, EMERGENCY
- ✅ Combinational priority encoder to resolve simultaneous floor requests
- ✅ Emergency stop handled from **any state**
- ✅ Separate motor control signals — `moveup`, `movedown`, `motorstop`
- ✅ `dooropen` signal — HIGH when elevator is idle at a floor
- ✅ `currentfloor` register tracks elevator position in real time
- ✅ Active-high synchronous reset
- ✅ 4 always-block architecture (encoder + next-state + state register + output)
- ✅ Simulated and verified on **EDA Playground** (Aldec Riviera-PRO)

---

## 📐 Module Interface

```verilog
module elevatordesign (
    input             clk,           // System clock
    input             reset,         // Active-high synchronous reset
    input             emergencystop, // HIGH → immediately halts elevator
    input       [3:0] floorreq,      // Floor request: bit 0 = Floor 0, bit 3 = Floor 3
    output reg        motorstop,     // HIGH when motor is stopped
    output reg        moveup,        // HIGH when elevator moving up
    output reg        movedown,      // HIGH when elevator moving down
    output reg        dooropen,      // HIGH when door is open (IDLE state only)
    output reg  [1:0] currentfloor   // Current floor position (0–3)
);
```

---

## 🔷 FSM States

| State Encoding | State Name  | Description                                        |
|:--------------:|-------------|----------------------------------------------------|
| `2'b00`        | `IDLE`      | Elevator stationary; door open; awaiting requests  |
| `2'b01`        | `MOVEUP`    | Motor running upward; floor counter incrementing   |
| `2'b10`        | `MOVEDOWN`  | Motor running downward; floor counter decrementing |
| `2'b11`        | `EMERGENCY` | Motor stopped; door closed; all movement halted    |

### State Transition Diagram

```
                        ┌─── emergencystop (from any state) ───┐
                        │                                       ▼
                     [IDLE] ─── target > current ──────► [MOVEUP]
                        │                                    │    │
                        │                              reached    emergencystop
                        │  target < current              │         │
                        │                                ▼         ▼
                        └────────────────────────► [MOVEDOWN]  [EMERGENCY]
                                                       │    │       │
                                                 reached    └───────┘
                                                   │      emergencystop
                                                   ▼
                                                [IDLE]
                                          (!emergencystop)
                                          [EMERGENCY] → [IDLE]
```

**Transition Rules (per state):**

| Current State | Condition                         | Next State   |
|---------------|-----------------------------------|--------------|
| `IDLE`        | `emergencystop`                   | `EMERGENCY`  |
| `IDLE`        | `targetfloor > currentfloor`      | `MOVEUP`     |
| `IDLE`        | `targetfloor < currentfloor`      | `MOVEDOWN`   |
| `IDLE`        | `targetfloor == currentfloor`     | `IDLE`       |
| `MOVEUP`      | `emergencystop`                   | `EMERGENCY`  |
| `MOVEUP`      | `targetfloor == currentfloor`     | `IDLE`       |
| `MOVEUP`      | otherwise                         | `MOVEUP`     |
| `MOVEDOWN`    | `emergencystop`                   | `EMERGENCY`  |
| `MOVEDOWN`    | `targetfloor == currentfloor`     | `IDLE`       |
| `MOVEDOWN`    | otherwise                         | `MOVEDOWN`   |
| `EMERGENCY`   | `emergencystop` still HIGH        | `EMERGENCY`  |
| `EMERGENCY`   | `emergencystop` LOW               | `IDLE`       |

---

## 🔢 Priority Encoder Logic

The `targetfloor` is resolved from the 4-bit `floorreq` input using a **lowest-floor-first priority encoder** (Floor 0 has highest priority). It is implemented as a combinational `always@(*)` block:

```verilog
if      (floorreq[0])  targetfloor = 2'b00;  // Floor 0 — highest priority
else if (floorreq[1])  targetfloor = 2'b01;
else if (floorreq[2])  targetfloor = 2'b10;
else if (floorreq[3])  targetfloor = 2'b11;  // Floor 3 — lowest priority
```

> If no floor is requested, `targetfloor` defaults to `currentfloor`, keeping the FSM in `IDLE`.

> If multiple floors are requested simultaneously, **Floor 0 is always served first**.

---

## 🔌 Output Behavior Per State

| State       | `moveup` | `movedown` | `motorstop` | `dooropen` | `currentfloor`      |
|-------------|:--------:|:----------:|:-----------:|:----------:|---------------------|
| `IDLE`      |   `0`    |    `0`     |     `1`     |    `1`     | Unchanged           |
| `MOVEUP`    |   `1`    |    `0`     |     `0`     |    `0`     | Increments by 1/clk |
| `MOVEDOWN`  |   `0`    |    `1`     |     `0`     |    `0`     | Decrements by 1/clk |
| `EMERGENCY` |   `0`    |    `0`     |     `1`     |    `0`     | Unchanged           |

> **Note:** Outputs are registered and updated on `posedge clk` based on **next state (`ns`)** — single-cycle lookahead output style. On `reset`, all outputs go to their safe defaults (`motorstop = 1`, `moveup = 0`, `movedown = 0`, `currentfloor = 0`).

---

## 🔁 Design Architecture (4 Always Blocks)

```
floorreq ──► [1. Priority Encoder — always@(*)]
                       │
                       ▼ targetfloor
             [2. Next-State Logic — always@(*)] ◄── ps, currentfloor, emergencystop
                       │
                       ▼ ns
             [3. State Register — always@(posedge clk)] ──► ps
                       │
                       ▼ ns
             [4. Output Logic — always@(posedge clk)] ──► moveup, movedown,
                                                           motorstop, dooropen,
                                                           currentfloor
```

| Block | Type              | Sensitivity        | Function                                      |
|:-----:|-------------------|--------------------|-----------------------------------------------|
| 1     | Combinational     | `always @(*)`      | Priority encoder → resolves `targetfloor`     |
| 2     | Combinational     | `always @(*)`      | Next-state logic → computes `ns` from `ps`    |
| 3     | Sequential (FF)   | `always @(posedge clk)` | State register → `ps <= ns` on clock    |
| 4     | Sequential (FF)   | `always @(posedge clk)` | Output logic → drives all output ports  |

---

## 🧪 Simulation

### Tool Used
- **Platform:** [EDA Playground](https://www.edaplayground.com/)
- **Simulator:** Aldec Riviera-PRO
- **Waveform Viewer:** EPWave

### How to Simulate

1. Open [EDA Playground](https://www.edaplayground.com/)
2. Paste `elevatordesign.v` into the **Design** tab
3. Paste `elevatordesign_tb.v` into the **Testbench** tab
4. Select **Aldec Riviera-PRO** as the simulator
5. Enable **"Open EPWave after run"** and click ▶ **Run**

### Testbench Scenarios Covered

- Single floor request from IDLE (upward movement)
- Single floor request from IDLE (downward movement)
- Simultaneous floor requests (priority encoder resolution)
- Emergency stop mid-movement
- Reset from any state

### Simulation Waveform

![Waveform](waveform_screenshot.png)

---



## 🛠️ Tools & Technologies

| Tool              | Purpose                       |
|-------------------|-------------------------------|
| Verilog HDL       | Hardware Description Language |
| EDA Playground    | Online simulation platform    |
| Aldec Riviera-PRO | Verilog simulator             |
| EPWave            | Waveform viewer               |
| GitHub            | Version control & portfolio   |

---

## 👤 Author

**Dev Gothi**  
B.Tech — Electronics & VLSI Engineering 
Sardar Vallabhbhai National Institute of Technology (SVNIT), Surat

🔗 GitHub: [github.com/dev-gothi](https://github.com/dev-gothi)  
🔗 LinkedIn: *(add your LinkedIn URL here)*  
🔗 EDA Playground: *(https://www.edaplayground.com/x/XWRf)*

---

## 📄 License

This project is open-source under the [MIT License](../LICENSE).

---

> ⭐ If you found this useful, consider starring my repository!
