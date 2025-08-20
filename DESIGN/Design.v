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
