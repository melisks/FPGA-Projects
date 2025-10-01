`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2025 10:59:05
// Design Name: 
// Module Name: uart_tx
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


module uart_tx #(parameter clk_per_bit = 868)(
    input clock,
    input i_data_avail,
    input [7:0] i_data_byte,
    output reg o_tx,
    output reg active,
    output reg done
    );

    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam SEND_BITS = 2'b10;
    localparam STOP = 2'b11;
    
    reg [15:0] counter = 16'd0;
    reg [8:0] data_bits = 9'd0;
    reg [3:0] bit_index = 4'd0;
    reg [1:0] state = IDLE;
    
    always@(posedge clock)begin
        done <= 1'b0;
        
        case(state)
        IDLE: begin
            o_tx <= 1'b1;
            active <= 1'b0;
            counter <= 16'd0;
            bit_index <= 4'd0;
            if(i_data_avail)begin
                data_bits <= {^i_data_byte,i_data_byte};
                active <= 1'b1;
                state <= START;
            end
        end
        START: begin
            o_tx <= 1'b0;
            if(counter == clk_per_bit - 1)begin
                counter <= 16'd0;
                bit_index <= 4'd0;
                state <= SEND_BITS;
            end else counter <= counter + 1;
        end
        SEND_BITS: begin
            o_tx <= data_bits[bit_index];
            if(counter == clk_per_bit - 1)begin
                counter <= 16'd0;
                if(bit_index == 8)begin
                    active <= 1'b0;
                    state <= STOP;
                end else bit_index <= bit_index + 1;
            end else counter <= counter + 1;
        end
        STOP: begin
            o_tx <= 1'b1;
            if(counter == clk_per_bit - 1)begin
                counter <= 16'd0;
                bit_index <= 4'd0;
                done <= 1'b1;
                state <= IDLE;
            end else counter <= counter + 1;
        end
        default: begin
            state <= IDLE;
            active <= 1'b0;
            done <= 1'b0;
            counter <= 16'd0;
        end
        endcase
    end
    
endmodule
