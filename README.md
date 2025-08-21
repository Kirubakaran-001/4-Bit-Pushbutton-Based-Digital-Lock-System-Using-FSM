# 4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM

---

## 📝 Overview
This project implements a 4-Bit Pushbutton-Based Digital Lock System using a Finite State Machine (FSM) approach. The system allows access only when a preset 4-bit code is entered in correct sequence using pushbuttons, making it suitable for low-cost secure entry systems. Unlock status and Lockout state and number of Attempts are indicated with LEDs .

---

## Pin Mapping
![Fpga](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/ee7ad96bfb2fd96f9d4ace90fd6d3b418579ef29/IMAGES%20%26%20VIDEO/fpga_pinmapping.png)

---

## 📜 Problem Statement
Design an FSM-based Digital Lock System where a 4-digit password is entered,Use 4 pushbuttons for code input (1 bit per button press). Compares input with the access code.
Unlocks system if code matches and remains locked otherwise.If more than three attempts of wrong password then the door should lockout and remains in the lockout state untill admin reset.
if admin reset is given then all three attempts should be again reset to three.

---

## ✨ Features
### Schematic view :
![schematic_view_expanded]()
### Functionality :
Receives input on each button press,totally 4 bit input, so 4 pushbutton are used, the input are not feeded untill enter is given, when the enter is high the input is feeded and then input is compared with the preset code.
Incorrect input resets FSM to IDLE , Unlock output/LED gets enabled if code matches. At initial state system has 3 attempts. 
#### Two cases :
#### case 1 : if three wrong attempts then the led will set into a lockout, remain in the lockout untill admin reset. When the admin reset is high, all 3 attempts are regained.
#### case 2 : if correct code is entered within 3 attempts then the output led will be high and all 3 attempts are regained again.
There are two resets :
1) admin reset  : used to over come the lockout state and to regain the attempts.
2) clk reset    : used to stop the clk signal.

---

## 🛠 Tools & Hardware

Software :  Vivado.
Hardware :  Avnet AES-Z7EV-7Z020-G Evaluation Kit Zynq-7000 System-on-Chip (SoC) Zedboard Diligent Pmod Compatible.

---

## 🔌 Inputs & Outputs

| Signal Name  | type      | Description                                  |
|--------------|-----------|----------------------------------------------|
|`clk`         |   Input   | clock signal                                 |
|`reset`       |   Input   | clk reset                                    |
|`admin_reset` |   Input   | user reset                                   |
|`enter`       |   Input   | use to feed input                            |
|`code_in`     |   Input   | Input from pushbuttons (1 bit per pushbutton)| 
|`unlock_led`  |   Output  | High when code is correct                    |
|`attempt_leds`|   Output  |show the number of attmpts left               |
|`lockout_led` |   Output  | freeze the system untill admin reset         |
|`clkout`      |   Output  | clock signal output                          |

---

## 🔄 FSM States

- **IDLE**           – Waiting for input to be entered.
- **Enter password** – First bit received.
- **UNLOCK**         – Access granted.
- **LOCKOUT**        – Incorrect input for more than 3 times.
- **Admin_Reset**    – reset agian all attempts to 3.

---

## 📊 FSM State Diagram

![Fpga_statediagram]()

---

## 📂 design.v
(Insert your main Verilog/VHDL or code, or link to files)

---

## 📂 testbench.v
(Insert your testbench code, or link to files)

---

## 🧪 Simulation
![wavefrom]()

---

## ⚙️ Schematic View
![Schematic]()

---
## ⚙️Technology view
![Technology view]()
---
## ⚙️Resource utilisation
![Resource utilisation]()
---
## ⚙️Timing analysis
![Timing analysis]()
---
## ⚙️power summary
![power summary]()
---
## FPGA I/O Port Assignments
![Resource utilisation]()
---

## 📂 File Structure
![filemanager]()

---

## 💫 Implementation Notes
Code is four bits, entered sequentially via pushbuttons.

Each wrong entry resets the FSM.

System can be enhanced with additional features like auditory buzzer or LCD for user prompts.

---

## 👥 Contributors
Kirubakaran [add affiliation and LinkedIn if desired

---
