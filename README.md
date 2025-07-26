# Asynchronous FIFO in Verilog

This project implements an **Asynchronous FIFO (First-In-First-Out) buffer** in **Verilog** that transfers data safely between different clock domains. This is a crucial design element in modern VLSI systems.

## What is an Asynchronous FIFO?

An Asynchronous FIFO is a memory buffer used to pass data between two subsystems that operate on **independent clocks**. It uses synchronizers and Gray code pointers to avoid metastability issues.

## Project Structure

asynchronous-fifo

├── src/

│ ├── fifo.v # FIFO memory array

│ ├── wr_ptr_handler.v # Write pointer logic

│ ├── rd_ptr_handler.v # Read pointer logic

│ └── synchronizer.v # 2-stage synchronizer module
│

├── tb/

│ ├── fifo_tb.v # FIFO testbench

│ └── synchronizer_tb.v # Synchronizer testbench



## Features

 **Dual-clock FIFO**  
  Supports separate read and write clocks for asynchronous data transfer.

 **Gray code pointer conversion**  
  Ensures safe crossing of clock domains by minimizing bit changes.

 **Full and Empty flag generation**  
  Accurate flag logic for reliable FIFO status monitoring.

 **2-flip-flop Synchronizers**  
  Used to safely transfer control signals between clock domains.

 **Verilog RTL + Testbenches**  
  Includes modular Verilog code and testbenches for all components.


##  Data Flow Diagram

```text
Write Clock Domain              Read Clock Domain

 wr_data  ─┬──▶ FIFO ───▶ rd_data

 wr_ptr  ─┘             ┌───▶ rd_ptr

     │   sync(rd_ptr)   │

     └──────────────▶ g_rd_ptr_sync

     ▲                           │

g_wr_ptr_sync ◀───────────────┘ sync(wr_ptr)


```

## Tool Chain


Language: Verilog

Simulator: Icarus Verilog (via EDAPlayground)

Waveform Viewer: EPWave / GTKWave

Optional Synthesis: Vivado / Synopsys Design Compiler

## Result 

<img width="926" height="278" alt="fifoop" src="https://github.com/user-attachments/assets/b0be5d06-759b-4057-aa3b-6661e7ed26a4" />

<img width="913" height="193" alt="fifo_synchronization" src="https://github.com/user-attachments/assets/3f01c027-208a-4157-8c14-47f0db397507" />
