`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2025 10:59:05
// Design Name: 
// Module Name: uart_rx
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


module uart_rx #(parameter clk_per_bit = 868)(
    input clock,
    input i_rx,
    output reg o_data_avail,
    output reg [7:0] o_data_byte,
    output reg error
    );
    
    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam GET_BITS = 2'b10;
    localparam STOP = 2'b11;
    
    reg [15:0] counter = 16'd0;
    reg [8:0] data_bits = 9'd0;
    reg [3:0] bit_index = 4'd0;
    reg [1:0] state = IDLE;
    
    reg rx_buff,rx;
    
    always@(posedge clock)
    begin
        rx_buff <= i_rx;
        rx <= rx_buff; 
    end
       
    always@(posedge clock)
    begin
    
        case(state)
        IDLE: begin
            counter <= 16'd0;
            data_bits <= 9'd0;
            bit_index <= 4'd0;
            o_data_avail <= 1'b0;
            if(rx == 1'b0)begin
                state <= START;
                counter <= 16'd0;
            end  
        end
        
        START: begin
            if(counter == (clk_per_bit - 1)/2)begin
                if(rx == 1'b0)begin
                    state <= GET_BITS;
                    counter <= 16'd0;
                end else begin
                    state <= IDLE;
                    counter <= 16'd0;
                end
            end else begin
                counter <= counter + 1;
            end
        end
        
        GET_BITS: begin
            if(counter == clk_per_bit - 1)begin
                data_bits[bit_index] <= rx;
                counter <= 16'd0;
                if(bit_index == 8)begin
                    state <= STOP;
                    bit_index <= 4'd0;
                end else begin
                    bit_index <= bit_index + 1;
                end 
            end else begin
                counter <= counter + 1;
            end  
        end
        
        STOP: begin
            if(counter == clk_per_bit - 1)begin
                counter <= 16'd0;
                if(rx == 1'b1)begin
                    if(data_bits[8] == ^data_bits[7:0]) begin
                    o_data_byte <= data_bits[7:0];
                    o_data_avail <= 1'b1;
                    error <= 1'b0;
                    end else begin
                    o_data_byte <= data_bits[7:0];
                    o_data_avail <= 1'b1;
                    error <= 1'b1;
                    end
                end
                state <= IDLE;
            end else begin
                counter <= counter + 1;
                o_data_avail <= 1'b0;
            end
        end
        
        default: begin
            state <= IDLE;
            o_data_avail <= 1'b0;
        end
        endcase   
    end     
endmodule