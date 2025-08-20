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
