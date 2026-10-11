# 8086-Compatible Memory Subsystem with MMIO Hardware Multiplier



This repository contains the Verilog implementation and behavioral verification of an 8086-compatible memory subsystem featuring a memory-mapped hardware accelerator (16-bit multiplier) with interrupt-driven handshaking.



## 🛠 Features

- \*\*Address Decoding:\*\* 74LS138 decoder logic dividing the 20-bit address bus into ROM (`FxxxxH`), RAM (`0xxxxH`), and Accelerator (`2xxxxH`) regions.

- \*\*Bank Organization:\*\* Even and Odd memory banks handling 16-bit aligned word access via `BHE#` and `A0`.

- \*\*MMIO Accelerator:\*\* Dedicated registers for operands (`A`, `B`), control, and output with level-sensitive interrupt (`INTR`) generation upon computation completion.

- \*\*Bus Contention Management:\*\* Tri-state (`ZZZZ`) CPU data bus arbitration resolving read/write race conditions and hold-time constraints.



## 📐 Architecture

!\[RTL Schematic](docs/schematic.png)



## ⏱ Simulation \& Verification

Verified using Vivado Simulator (XSim). 

- Multiplicands `0003h` and `0005h` written to accelerator registers.

- Computation completed and signaled via `INTR`.

- Product `000Fh` (15) successfully read from offset `20008h`.



!\[Waveform](docs/simulation\_wave.png)

