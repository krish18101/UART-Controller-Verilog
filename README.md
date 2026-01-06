# UART-Controller-Verilog
This project implements a UART controller in Verilog with transmit, receive, and FIFO logic. The design was tested using simulation and waveform analysis.
# UART Controller in Verilog

This repository contains a complete UART controller implemented in Verilog HDL.  
The project was built from scratch to understand how UART communication works at the RTL level, including data transmission, reception, and buffering.

---

## Features

- Parameterized baud rate generator  
- FSM-based UART transmitter (TX)  
- FSM-based UART receiver (RX)  
- Start bit, data bits, and stop bit handling  
- Synchronous FIFO for TX buffering  
- Synchronous FIFO for RX buffering  
- Automatic data flow between FIFO and UART  
- Verified using waveform-based loopback simulation  

---

## File Overview


---

## Design Overview

The UART core is built using modular RTL blocks.  
Data written into the TX FIFO is transmitted automatically when the transmitter is idle.  
Received serial data is reconstructed by the RX module and stored in the RX FIFO until it is read.

### Transmit Path

### Receive Path

FIFO buffering is used to decouple UART timing from system logic.

---

## Simulation

The design was verified using a simple loopback testbench where the TX output is connected to the RX input.  
UART frames (start bit, data bits, stop bit) and FIFO behavior were observed using waveform simulation.

---

## Tools Used

- Verilog HDL  
- Vivado Simulator  

---

## Notes

This project focuses on clean RTL design and correct UART behavior rather than advanced verification techniques.  
It is intended for learning and entry-level RTL/VLSI internship preparation.
