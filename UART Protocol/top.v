`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2025 10:59:05
// Design Name: 
// Module Name: top
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


module top(
    input clock,
    input [7:0] i_data_byte,
    input i_data_avail,
    input i_rx,
    output o_tx,
    output active,
    output done,
    output o_data_avail,
    output [7:0] o_data_byte,
    output error
    );
    
    uart_tx #(.clk_per_bit(868)) I1(
        .clock(clock),
        .i_data_avail(i_data_avail),
        .i_data_byte(i_data_byte),
        .o_tx(o_tx),
        .active(active),
        .done(done)
    );
    uart_rx #(.clk_per_bit(868)) I2(
        .clock(clock),
        .i_rx(i_rx),
        .o_data_avail(o_data_avail),
        .o_data_byte(o_data_byte),
        .error(error)
    );
    
endmodule
