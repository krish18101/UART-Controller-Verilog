`timescale 1ns / 1ps

module uart_rx (
    input  wire clk,
    input  wire rst,
    input  wire baud_tick,
    input  wire rx,
    output reg  [7:0] rx_data,
    output reg  rx_done
);

    // FSM states
    localparam [1:0]
        IDLE  = 2'b00,
        START = 2'b01,
        DATA  = 2'b10,
        STOP  = 2'b11;

    reg [1:0] state;
    reg [7:0] shift_reg;
    reg [2:0] bit_cnt;
    reg       rx_prev;

    always @(posedge clk) begin
        if (rst) begin
            state     <= IDLE;
            shift_reg <= 8'd0;
            bit_cnt   <= 3'd0;
            rx_data   <= 8'd0;
            rx_done   <= 1'b0;
            rx_prev   <= 1'b1;   
        end else begin
            
            rx_done <= 1'b0;

            
            rx_prev <= rx;

            case (state)

               
                IDLE: begin
                    bit_cnt <= 3'd0;
                    if (rx_prev == 1'b1 && rx == 1'b0) begin
                        
                        state <= START;
                    end
                end

               
                START: begin
                    if (baud_tick) begin
                        if (rx == 1'b0) begin
                            
                            state <= DATA;
                        end else begin
                            
                            state <= IDLE;
                        end
                    end
                end

               
                DATA: begin
                    if (baud_tick) begin
                       
                        shift_reg <= {rx, shift_reg[7:1]};
                        bit_cnt   <= bit_cnt + 1'b1;

                        if (bit_cnt == 3'd7) begin
                            state <= STOP;
                        end
                    end
                end

             
                STOP: begin
                    if (baud_tick) begin
                        if (rx == 1'b1) begin
                            
                            rx_data <= shift_reg;
                            rx_done <= 1'b1;   
                        end
                        state <= IDLE;
                    end
                end

            endcase
        end
    end

endmodule
