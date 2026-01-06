module fifo_sync #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8,
    parameter ADDR_WIDTH = 3
)(
    input  clk,
    input  rst,
    input  wr_en,
    input  rd_en,
    input  [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output full,
    output empty
);

reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
reg [ADDR_WIDTH-1:0] wr_ptr;
reg [ADDR_WIDTH-1:0] rd_ptr;
reg [ADDR_WIDTH:0]   count;

assign empty = (count == 0);
assign full  = (count == DEPTH);

always @(posedge clk) begin
    if (rst) begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count  <= 0;
    end
    else begin
        if (wr_en && rd_en && !full && !empty) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end
        else if (wr_en && !rd_en && !full) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
            count <= count + 1;
        end
        else if (rd_en && !wr_en && !empty) begin
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            count <= count - 1;
        end
    end
end

endmodule
