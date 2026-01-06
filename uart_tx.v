module uart_tx (
    input  wire clk,
    input  wire rst,
    input  wire baud_tick,
    input  wire tx_start,
    input  wire [7:0] tx_data,
    output reg  tx,
    output reg  tx_busy
);

    localparam [1:0]
        IDLE  = 2'b00,
        START = 2'b01,
        DATA  = 2'b10,
        STOP  = 2'b11;

    reg [1:0] state;
    reg [7:0] shift_reg;
    reg [2:0] bit_cnt;

    always @(posedge clk) begin
        if (rst) begin
            state     <= IDLE;
            tx        <= 1'b1;
            tx_busy  <= 1'b0;
            bit_cnt  <= 3'd0;
            shift_reg<= 8'd0;
        end else begin
            case (state)

                IDLE: begin
                    tx <= 1'b1;
                    tx_busy <= 1'b0;
                    if (tx_start) begin
                        shift_reg <= tx_data;
                        bit_cnt   <= 3'd0;
                        state     <= START;
                        tx_busy   <= 1'b1;
                    end
                end

                START: begin
                    tx <= 1'b0;
                    if (baud_tick)
                        state <= DATA;
                end

                DATA: begin
                    tx <= shift_reg[0];
                    if (baud_tick) begin
                        shift_reg <= shift_reg >> 1;
                        bit_cnt   <= bit_cnt + 1;
                        if (bit_cnt == 3'd7)
                            state <= STOP;
                    end
                end

                STOP: begin
                    tx <= 1'b1;
                    if (baud_tick) begin
                        state    <= IDLE;
                        tx_busy  <= 1'b0;
                    end
                end

            endcase
        end
    end

endmodule
