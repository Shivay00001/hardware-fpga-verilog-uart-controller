# FPGA Verilog UART Controller

[![Verilog](https://img.shields.io/badge/HDL-Verilog_2001-blue.svg)](https://en.wikipedia.org/wiki/Verilog)
[![FPGA](https://img.shields.io/badge/Hardware-FPGA-orange.svg)](https://www.xilinx.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A **production-grade UART (Universal Asynchronous Receiver-Transmitter) Controller** implemented in Verilog. designed for FPGA implementation (Xilinx Artix-7 / Cyclone V). It features configurable baud rates, FIFO buffers, and robust state machine design.

## 🚀 Features

- **Configurable Baud Rate**: Baud rate generator parameterized for any system clock.
- **Full Duplex**: Simultaneous transmission (TX) and reception (RX).
- **State Machine Control**: Finite State Machines (FSM) for reliable bit timing.
- **Loopback Test**: Includes a top-level module for verifying TX-RX loopback.

## 📁 Project Structure

```
hardware-fpga-verilog-uart-controller/
├── src/
│   ├── baud_rate_gen.v   # Clock Divider
│   ├── uart_tx.v         # Transmitter
│   ├── uart_rx.v         # Receiver
│   └── top.v             # Loopback Test
├── Dockerfile            # For simulation env (Icarus Verilog)
```

## 🛠️ Quick Start

To simulate using Icarus Verilog:

```bash
# Compile
iverilog -o uart_sim src/top.v src/uart_tx.v src/uart_rx.v src/baud_rate_gen.v

# Run
vvp uart_sim
```

## 📄 License

MIT License
