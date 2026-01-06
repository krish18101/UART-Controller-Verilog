module uart_tb;

reg clk;
reg rst;

reg rx;
wire tx;

reg tx_wr_en;
reg [7:0] tx_wr_data;

reg rx_rd_en;
wire [7:0] rx_rd_data;

wire tx_full;
wire rx_empty;

uart_top dut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .tx_wr_en(tx_wr_en),
    .tx_wr_data(tx_wr_data),
    .rx_rd_en(rx_rd_en),
    .rx_rd_data(rx_rd_data),
    .tx_full(tx_full),
    .rx_empty(rx_empty)
);

always #5 clk = ~clk;

always @(*) rx = tx;

initial begin
    clk = 0;
    rst = 1;
    tx_wr_en = 0;
    tx_wr_data = 0;
    rx_rd_en = 0;

    #50;
    rst = 0;
end

initial begin
    #200;

    tx_wr_data = 8'h55;
    tx_wr_en = 1;
    #10;
    tx_wr_en = 0;

    #200;

    tx_wr_data = 8'hA3;
    tx_wr_en = 1;
    #10;
    tx_wr_en = 0;
end

initial begin
    #5000;

    rx_rd_en = 1;
    #10;
    rx_rd_en = 0;

    #200;

    rx_rd_en = 1;
    #10;
    rx_rd_en = 0;
end

endmodule
