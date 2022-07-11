# RV32I
RISC-V 32I Core Codes written for university class

We have designed 5-stage pipelined RISC-V Core. Pipeline hazards are solved. Core.v is the top level design for the Core. Memories are instantiated with the NVRAM modules
synthesized in the Cadence. We used xfab_018 library for the process.

This implementation was done using Cadence. We have used Genus for RTL analysis and synthesis. Used Innovus for placement and routing (in final design we could not manage
to do placement and routing). We have used Cadence Xcelium for simulation purposes. 

Without hazard handling core was working without any problems. While solving the Branch Hazards in second stage there were some problems regarding to that. At that time
we could not solve that problem however I am planning to solve this in anytime.
