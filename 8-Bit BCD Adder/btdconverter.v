`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2025 11:41:47
// Design Name: 
// Module Name: btdconverter
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


module btdconverter(
input [3:0] in,
output reg [6:0] out
    );
    always @(*) begin
    case (in)
        4'd0: out = 7'b0000_001;
        4'd1: out = 7'b1001_111;
        4'd2: out = 7'b0010_010;
        4'd3: out = 7'b0000_110;
        4'd4: out = 7'b1001_100;
        4'd5: out = 7'b0100_100;
        4'd6: out = 7'b0100_000;
        4'd7: out = 7'b0001_111;
        4'd8: out = 7'b0000_000;
        4'd9: out = 7'b0000_100;  
        default: out = 7'b0000_001;
    endcase
    end
endmodule
