`timescale 1ns / 1ps

module asdfasdf(
    input clk_in,
    input reset,
    input glitch_xor_enable,
    input glitch_enable,
    input glitch_len_select,
    output glitch_out,
    output led_flip_out,
    output led_xor_out,
    output led_out
    );
    wire clk_out1;
    wire locked;
    
    clk_wiz_0 inst
      (
      .clk_out1(clk_out1),            
      .reset(~reset), 
      .locked(locked),
      .clk_in1(clk_in)
      );
      
    reg led_status;
    reg led_flip_status;
    reg [32:1] ctr;
    reg [5:1] glitch_timer;
    reg [5:1] glitch_max_timer;
    reg glitch_out_xor_r;
    reg glitch_out_r;
    
    assign glitch_out = glitch_out_r;
    assign led_out = led_status;
    assign led_flip_out = led_flip_status;
    assign led_xor_out = glitch_xor_enable;
    
    initial begin
        glitch_out_xor_r = 1'b1;
        led_flip_status = 1'b0;
        led_status = 1'b1;
        ctr = 0;
        glitch_out_r = 0;
        glitch_timer = 0;
        glitch_max_timer <= 5'b0000;
    end
    
    always @(posedge clk_out1)
    begin
        if (glitch_enable == 1) begin
            ctr <= ctr + 1;
            if (ctr[29] == 1'b1) begin
                led_status <= 1 - led_status;
                if (glitch_len_select == 1'b1)
                    begin
                    glitch_timer <= glitch_max_timer;
                    glitch_max_timer <= glitch_max_timer + 1;
                    if (glitch_max_timer == 5'b11111) 
                        begin
                            led_flip_status <= 1 - led_flip_status;
                        end
                    end
                else
                    begin
                    glitch_timer <= glitch_max_timer;
                    end
                ctr <= 0;
            end
            if (glitch_timer > 0) begin
                if (glitch_xor_enable == 1) begin
                    glitch_out_xor_r <= 1 - glitch_out_xor_r;
                    glitch_out_r <= glitch_out_xor_r; 
                end
                else
                begin
                    glitch_out_r <= 1;
                end
                glitch_timer <= glitch_timer - 1;
            end
            else
            begin
                glitch_out_r <= 0;
            end
        end
        else
        begin
            glitch_out_r <= 0;
        end
    end
    
endmodule
