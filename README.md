# 4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM

##📝 Overview
This project implements a 4-Bit Pushbutton-Based Digital Lock System using a Finite State Machine (FSM) approach. The system allows access only when a preset 4-bit code is entered in correct sequence using pushbuttons, making it suitable for low-cost secure entry systems. Unlock status and intermediate states can be indicated with LEDs.

##📜 Problem Statement
Design a Digital Lock FSM that:

Uses 4 pushbuttons for code input (1 bit per button press).

Compares sequential input with the preset access code.

Unlocks system if code matches; remains locked otherwise.

Optionally indicates state transitions and errors using LEDs.

##✨ Features
FSM Stages:

IDLE → INPUT1 → INPUT2 → INPUT3 → INPUT4 → UNLOCKED/LOCKED

Functionality:

Receives input on each button press, compares with the preset code.

Incorrect input resets FSM to IDLE or ERROR state.

Unlock output/LED gets enabled if code matches.

Manual reset option to initialize system.

Inputs:

clk – Clock signal

reset – System reset

button_in – Input from pushbuttons (1 bit per cycle)

Outputs:

unlock – High when code is correct

state_leds – (Optional) Visualize FSM stages

error_led – (Optional) Error indication

##🛠 Tools & Hardware
Software: (e.g., Vivado, Quartus, ModelSim, etc.)

Hardware: Any generic FPGA/MCU board with 4 buttons, 1+ LEDs

##🔌 Inputs & Outputs
Signal Name	Direction	Description
clk	Input	System clock signal
reset	Input	Active-high reset
button_in	Input	Single bit pushbutton input
unlock	Output	High when system is unlocked
state_leds	Output	(Optional) FSM state visibility
error_led	Output	(Optional) Error status indicator

##🔄 FSM States
IDLE – Waiting for input

INPUT1 – First bit received

INPUT2 – Second bit received

INPUT3 – Third bit received

INPUT4 – Fourth bit received, check code

UNLOCKED – Access granted

ERROR/LOCKED – Incorrect input triggers reset

FSM transition example:

Correct input for each step: move to next state

Incorrect input: move to ERROR/IDLE

##📊 FSM State Diagram
(Include a diagram image if available)

##📂 design.v
(Insert your main Verilog/VHDL or code, or link to files)

##📂 testbench.v
(Insert your testbench code, or link to files)

##🧪 Simulation
(Describe or show results of simulation, with waveform screenshots if possible)

##⚙️ Schematic View
(Attach images or describe the hardware schematic)

##📂 File Structure
text
/src
  |- design.v
  |- testbench.v
/docs
  |- schematic.png
  |- fsm_diagram.png
README.md
##💫 Implementation Notes
Code is four bits, entered sequentially via pushbuttons.

Each wrong entry resets the FSM.

System can be enhanced with additional features like auditory buzzer or LCD for user prompts.

##👥 Contributors
Kirubakaran [add affiliation and LinkedIn if desired
