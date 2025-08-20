module top_digital_lock_4bit(input clk,
    input reset,        
    input admin_reset,   
    input enter,        
    input [3:0] code_in, 
    output unlock_led,
    output lockout_led,
    output [2:0] attempt_led,
    output clkout);
  wire c_out;
  assign clkout=c_out;
  clockdivider uut1(c_out,clk,reset);
  digital_lock_4bit uut2(c_out,reset,admin_reset,enter,code_in,unlock_led,lockout_led,attempt_led);  
endmodule
