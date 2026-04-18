# RTL Photocopier Controller (FPGA / VHDL)

This repository contains the VHDL implementation of a digital photocopier control system, designed and synthesized in Quartus II.
The project separates the digital logic into a Finite State Machine (FSM) Controller and a Datapath, implementing precise timing and hardware-level constraints. Target hardware for this design is the Altera DE2 FPGA board.

#Core Features & Operation
Power States: The system boots into a Standby mode. Pressing the wake-up button (i) transitions the machine into the Ready state.
Hardware Quantity Control: Users can increment (a) or decrement (d) the desired number of copies. The Datapath strictly enforces a hard physical constraint, limiting the copy range from 1 to 200.
Real-time User Interface (HMI): The currently selected number of copies is continuously routed to an 8-bit output vector (V), which can be mapped directly to hardware LEDs or 7-segment display decoders.
Precise Hardware Timer: Pressing the print button (c) initiates the copying sequence. For each individual page, the FSM activates the print head output (p) for exactly 50 clock cycles.
Auto-Reset: Once the requested number of copies is reached, the system automatically flushes the internal registers and returns to Standby mode.

#Tech Stack & Architecture
Language: VHDL (RTL level)
Environment: Altera Quartus II (Pin Planner, RTL Viewer, Vector Waveform Simulations)
Architecture: Custom Datapath with an independent Control Unit (HLSM).
Hardware Validation: Tested on the Altera Cyclone II (EP2C35F672C6) FPGA via USB-Blaster.
