# 4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM

---

## 📝 Overview
This project implements a 4-Bit Pushbutton-Based Digital Lock System using a Finite State Machine (FSM) approach. The system allows access only when a 4-bit code is entered in correct sequence using pushbuttons, making it suitable for low-cost secure entry systems. Unlock status and Lockout state and number of Attempts are indicated with LEDs .

---

## 👉 Pin Mapping
![Fpga](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/ee7ad96bfb2fd96f9d4ace90fd6d3b418579ef29/IMAGES%20%26%20VIDEO/fpga_pinmapping.png)

---

## 📜 Problem Statement
Design an FSM-based Digital Lock System where a 4-digit password is entered, Use 4 pushbuttons for code input (1 bit per button press). Compares input with the access code.
Unlocks system if code matches and remains locked otherwise. If more than three attempts of wrong password then the door should lockout and remains in the lockout state untill admin reset.
if admin reset is given then all three attempts should be again reset.

---

## ✨ Features
### Functionality :
Receives input on each button press,totally 4 bit input, so 4 pushbutton are used, the input are not feeded untill enter is given, when the enter is high the input is feeded and then input is compared with the pre-set code.
Incorrect input resets FSM to IDLE , Unlock output/LED gets enabled if code matches. At initial state system has 3 attempts. 
#### Two cases :
#### case 1 : if three wrong attempts then the led will set into a lockout, remain in the lockout untill admin reset. When the admin reset is high, all 3 attempts are regained.
#### case 2 : if correct code is entered within 3 attempts then the output/Unlock led will be high and all 3 attempts are regained again.
There are two resets :
1) admin reset  : used to over come the lockout state and to regain the attempts.
2) clk reset    : used to stop the clk signal.

---

## 🛠 Tools & Hardware

- **Software** :  Vivado.
- **Hardware** :  Avnet AES-Z7EV-7Z020-G Evaluation Kit Zynq-7000 System-on-Chip (SoC) Zedboard Diligent Pmod Compatible.

---

## 🔌 Inputs & Outputs

| Signal Name  | type      | Description                                  |
|--------------|-----------|----------------------------------------------|
|`clk`         |   Input   | clock signal                                 |
|`reset`       |   Input   | clk reset                                    |
|`admin_reset` |   Input   | attempts reset                               |
|`enter`       |   Input   | use to feed input                            |
|`code_in`     |   Input   | Input from pushbuttons (1 bit per pushbutton)| 
|`unlock_led`  |   Output  | High when input is correct                   |
|`attempt_leds`|   Output  |show the number of attmpts left               |
|`lockout_led` |   Output  | freeze the system untill reset               |
|`clkout`      |   Output  | clock signal output                          |

---

## 🔄 FSM States

- **IDLE**           – Waiting for input to be feeded.
- **Enter password** – feed input and compare the input with the pre-set password.
- **UNLOCK**         – Access granted.
- **LOCKOUT**        – Incorrect input for more than 3 times.
- **Admin_Reset**    – reset agian all attempts to 3.

---

## 📊 FSM State Diagram

![Fpga_statediagram](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/8b7e74f01600ae5250db6c9583e9c002f75f1576/IMAGES%20%26%20VIDEO/State_diagram.png)

---

## 📂 design.v

```
module digital_lock_4bit(
    input clk,
    input reset,         
    input admin_reset,   
    input enter,        
    input [3:0] code_in, 
    output reg unlock_led,
    output reg lockout_led,
    output reg [2:0] attempt_led 
);
    parameter PASS = 4'b1010; 
    reg [2:0] attempts;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            attempts <= 3;
            unlock_led <= 0;
            lockout_led <= 0;
        end
        else if (admin_reset) begin
            attempts <= 3;
            unlock_led <= 0;
            lockout_led <= 0;
        end
        else if (enter) begin
            if (!lockout_led) begin
                if (code_in == PASS) begin
                    unlock_led <= 1;
                    attempts <= 3; 
                end
                else begin
                    unlock_led <= 0;
                    if (attempts > 0)
                        attempts <= attempts - 1;
                    if (attempts == 1) 
                        lockout_led <= 1;
                end
            end
        end
    end
    always @(*) begin
        case (attempts)
            3: attempt_led = 3'b111;
            2: attempt_led = 3'b110;
            1: attempt_led = 3'b100;
            0: attempt_led = 3'b000;
            default: attempt_led = 3'b000;
        endcase
    end
endmodule
```

---

## 📂 testbench.v

```
module tb_digital_lock_4bit;
    reg clk, reset, admin_reset, enter;
    reg [3:0] code_in;
    wire unlock_led, lockout_led;
    wire [2:0] attempt_led;
    digital_lock_4bit uut(
        .clk(clk),
        .reset(reset),
        .admin_reset(admin_reset),
        .enter(enter),
        .code_in(code_in),
        .unlock_led(unlock_led),
        .lockout_led(lockout_led),
        .attempt_led(attempt_led)
    );
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        reset = 1; admin_reset = 0; enter = 0; code_in = 4'b0000;
        #10 reset = 0;
        code_in = 4'b0001; enter = 1; #10 enter = 0; #10;
        code_in = 4'b0010; enter = 1; #10 enter = 0; #10;
        code_in = 4'b1010; enter = 1; #10 enter = 0; #10;
        code_in = 4'b0100; enter = 1; #10 enter = 0; #10;
        code_in = 4'b0101; enter = 1; #10 enter = 0; #10;
        code_in = 4'b0110; enter = 1; #10 enter = 0; #10;
        admin_reset = 1; #10 admin_reset = 0;
        code_in = 4'b1010; enter = 1; #10 enter = 0;
        #50 $stop;
    end
endmodule
```
---

## 🧪 Simulation
![wavefrom](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/8b7e74f01600ae5250db6c9583e9c002f75f1576/IMAGES%20%26%20VIDEO/output_waveform.png)

---

## 🛠️ Schematic View
![Schematic](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/8b7e74f01600ae5250db6c9583e9c002f75f1576/IMAGES%20%26%20VIDEO/schematic_view.png)

---
## ⚙️ Technology view
![Technology view](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/8b7e74f01600ae5250db6c9583e9c002f75f1576/IMAGES%20%26%20VIDEO/schematic_view_expanded.png)
---
## 🛠️ Resource utilisation
![Resource utilisation](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/518da3dacf8b7db131c04870fbd485a7ca50bb1a/IMAGES%20%26%20VIDEO/utilization.png)
---
## ⚙️ Timing analysis
![Timing analysis](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/518da3dacf8b7db131c04870fbd485a7ca50bb1a/IMAGES%20%26%20VIDEO/time_analysis.png)
---
## 🛠️ power summary
![power summary](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/a2ca6bbe21877c26aa93428b61123a64b3c5a288/IMAGES%20%26%20VIDEO/Power_utilization.png)
---
## ⚙️ FPGA I/O Port Assignments
![i/o declaration](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/df22cccfb4918c83e43f14bbedc8ec11ed74554f/IMAGES%20%26%20VIDEO/pin_declaration.png)
---
## ⚙️Package
![package](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/a2ca6bbe21877c26aa93428b61123a64b3c5a288/IMAGES%20%26%20VIDEO/package.png)
---

## 📂 File Structure
![filemanager](https://github.com/Kirubakaran-001/4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM/blob/0bf8a32a4a4ebaaa7b5073763496de1edd5c63a5/IMAGES%20%26%20VIDEO/project_manager.png)

---


## 💫 Implementation Video
### the output Video of the our project is here check it out.

[4-Bit-Pushbutton-Based-Digital-Lock-System-Using-FSM.mp4](https://drive.google.com/file/d/1oQnhxVV3mWzcZlVZffv1pIT6zSr_PAW6/view?usp=sharing)

---

## 👥 Contributors

### Kirubakaran S, Bannari Amman Institute Of Technology ( [linkedin](https://www.linkedin.com/in/kirubakaran-s-b086ab355/) )
### Kavin V, Bannari Amman Institute Of Technology ( [linkedin](https://www.linkedin.com/in/kavin-v-b45969304/) )

---
