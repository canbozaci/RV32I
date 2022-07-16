# RV32I
RISC-V 32-bit Integer Core Codes written for university class

We have designed 5-stage pipelined RISC-V Core. Core.v is the top level design for the Core. Memories are instantiated with the NVRAM modules synthesized in the Cadence. We used xfab_018 library for the process.

Structural Hazards are solved, Data Hazards - Read-After-Write Hazards are solved in CPI = 1, Data Hazards - Load-Use Hazards are solved with CPI 1.2, Control Hazards, Branches are solved with CPI 1.2, Control Hazards - Jumps are solved by flushing the next instruction after a jump instruction. 

Under the sim/tb file a basic Left-to-right modular multiplication algorithm is being tested on the core by using add operations to realize multiplication.

This implementation was done using Cadence. We have used Genus for RTL analysis and synthesis. Used Innovus for placement and routing (in final design we could not manage to do placement and routing). We have used Cadence Xcelium for simulation purposes. 

Without hazard handling core was working without any problems. While solving the Branch Hazards in second stage there were some problems regarding to that. At that time
we could not solve that problem however I am planning to solve this in anytime.
