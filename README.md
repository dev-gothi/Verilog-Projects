# ⚡ Verilog HDL Projects

> A structured collection of digital circuits implemented in SystemVerilog/Verilog HDL — from basic logic gates to complex sequential systems. Simulated using **EDA Playground (Icarus Verilog)** and verified with **EPWave**.

---

## 👨‍💻 Author
**Dev** | Electronics & Communication Engineering | SVNIT Surat  
[![GitHub](https://img.shields.io/badge/GitHub-Dev--VL55-181717?style=flat&logo=github)](https://github.com/Dev-VL55)

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| SystemVerilog / Verilog HDL | Hardware Description |
| EDA Playground | Online Simulation |
| Icarus Verilog | Compiler/Simulator |
| EPWave | Waveform Viewer |
| DigitalJS Online | Logic Visualization |

---

## 📁 Project Structure

```
Verilog-Projects/
├── Combinational Circuits/
│   ├── Half Adder/
│   ├── Full Adder/
│   ├── Full Subtractor/
│   ├── Mux/
│   ├── Demux/
│   ├── Encoder/
│   ├── Decoder/
│   └── Latches/
│
├── Sequential Circuits/
│   ├── Counters/
│   │   ├── MOD-3 Counter (50% duty cycle)
│   │   ├── MOD-4 Counter
│   │   └── MOD-8 Counter
│   ├── Multiple Mod Counter/
│   ├── Frequency Division Circuits/
│   ├── Shift Registers/
│   │   ├── SISO
│   │   ├── SIPO
│   │   ├── PISO
│   │   └── PIPO
│   ├── Universal Shift Register/
│   └── RAM/
```

---

## 🔷 Combinational Circuits

### ➕ Adders & Subtractors
| Module | Description |
|--------|-------------|
| Half Adder | 1-bit addition, no carry-in |
| Full Adder | 1-bit addition with carry-in |
| Full Subtractor | 1-bit subtraction with borrow |

### 🔀 Multiplexers & Demultiplexers
| Module | Description |
|--------|-------------|
| MUX | Multiple input selection |
| DEMUX | Single input to multiple outputs |

### 🔢 Encoders & Decoders
| Module | Description |
|--------|-------------|
| Encoder | Priority encoder implementation |
| Decoder | Binary to one-hot decoder |

---

## 🔶 Sequential Circuits

### 🔁 Shift Registers
| Module | Description |
|--------|-------------|
| SISO | Serial In Serial Out |
| SIPO | Serial In Parallel Out |
| PISO | Parallel In Serial Out |
| PIPO | Parallel In Parallel Out |
| **Universal Shift Register** | All 4 modes — controlled by `s1, s0` select lines |

### 🔢 Counters
| Module | Description | Special Feature |
|--------|-------------|-----------------|
| MOD-3 Counter | Counts 0→1→2→0 | 50% duty cycle using dual-edge triggering |
| MOD-4 Counter | Counts 0→1→2→3→0 | Synchronous reset |
| MOD-8 Counter | Counts 0 to 7 | 3-bit output |
| Multiple MOD Counter | Configurable MOD | N-bit generic design |

### 📡 Frequency Division Circuits
| Module | Description |
|--------|-------------|
| Divide by 2 | Output = clk/2 |
| Divide by 3 | 50% duty cycle — posedge + negedge logic |

### 💾 RAM
| Module | Description |
|--------|-------------|
| Single Port RAM | Read/Write with address, data bus |

---

## ▶️ How to Simulate

1. Go to [EDA Playground](https://www.edaplayground.com/)
2. Select **Icarus Verilog 12.0** as simulator
3. Paste design code in left panel, testbench in right panel
4. Check **"Open EPWave after run"**
5. Click **Run** ▶️

---

## 🎯 Key Concepts Covered

- ✅ Blocking vs Non-Blocking assignments
- ✅ Always blocks — posedge, negedge, dual-edge triggering
- ✅ Moore & Mealy state machines
- ✅ Synchronous & Asynchronous Reset
- ✅ Parameterized modules
- ✅ Testbench writing & waveform verification

---

## 📌 Highlight Project — MOD-3 Counter (50% Duty Cycle)

```verilog
// Dual edge triggering for 50% duty cycle
always @(posedge clk) ...  // posedge logic
always @(negedge clk) ...  // negedge logic
// Final output = OR of both
```
> Standard single-edge MOD-3 cannot achieve 50% duty cycle.  
> Solved using dual always blocks — a common VLSI interview question!

---

## 📄 License
MIT License — free to use for learning and reference.

---

⭐ **Star this repo if you found it useful!**
