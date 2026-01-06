`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.01.2026 21:15:09
// Design Name: 
// Module Name: uart_baud_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_baud_gen

 # (parameter integer  clk_freq  = 50000000,
    parameter integer  baud_rate = 9600 ) 
(
input clk , rst,
output reg baud_tick 

    );
    
    localparam integer baud_div = clk_freq / baud_rate;
     reg [$clog2(baud_div)-1:0] baud_cnt;

always @(posedge clk)begin
if(rst)
begin 
baud_tick <= 1'b0 ;
baud_cnt <= 1'b0;
end
else
begin
if(baud_cnt == baud_div -1)
begin
baud_cnt <= 1'b0;
baud_tick <= 1'b1;
end
else
begin
baud_cnt <= baud_cnt + 1;
baud_tick <= 1'b0;
 end
 end  
  end
  
  
    
    
    
    
endmodule
