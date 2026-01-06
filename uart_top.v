module uart_top (
    input  clk,
    input  rst,

    input  rx,
    output tx,

    input  tx_wr_en,
    input  [7:0] tx_wr_data,

    input  rx_rd_en,
    output [7:0] rx_rd_data,

    output tx_full,
    output rx_empty
);

wire baud_tick;

wire tx_busy;
wire tx_start;
wire [7:0] tx_data;

wire rx_done;
wire [7:0] rx_data;

wire tx_fifo_empty;
wire rx_fifo_full;

uart_baud_gen baud_gen (
    .clk(clk),
    .rst(rst),
    .baud_tick(baud_tick)
);

uart_tx tx_inst (
    .clk(clk),
    .rst(rst),
    .baud_tick(baud_tick),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx(tx),
    .tx_busy(tx_busy)
);

uart_rx rx_inst (
    .clk(clk),
    .rst(rst),
    .baud_tick(baud_tick),
    .rx(rx),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

fifo_sync tx_fifo (
    .clk(clk),
    .rst(rst),
    .wr_en(tx_wr_en),
    .rd_en(tx_start),
    .data_in(tx_wr_data),
    .data_out(tx_data),
    .full(tx_full),
    .empty(tx_fifo_empty)
);

fifo_sync rx_fifo (
    .clk(clk),
    .rst(rst),
    .wr_en(rx_done),
    .rd_en(rx_rd_en),
    .data_in(rx_data),
    .data_out(rx_rd_data),
    .full(rx_fifo_full),
    .empty(rx_empty)
);

assign tx_start = !tx_busy && !tx_fifo_empty;

endmodule
