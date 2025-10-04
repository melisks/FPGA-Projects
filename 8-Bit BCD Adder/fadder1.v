`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2025 11:41:47
// Design Name: 
// Module Name: fadder1
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


module fadder1(
    input a, b, cin,
    output sum, cout
    );
    assign sum = a^b^cin;
    assign cout = a&b|a&cin|b&cin;
endmodule
