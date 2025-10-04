`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2025 11:41:47
// Design Name: 
// Module Name: fadder4
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


module fadder4(
    input [3:0] a, b,
    input cin,
    output [3:0] sum,
    output cout
    );
    wire c1;
    fadder2 I1(.a(a[1:0]),.b(b[1:0]),.cin(cin),.sum(sum[1:0]),.cout(c1));
    fadder2 I2(.a(a[3:2]),.b(b[3:2]),.cin(c1),.sum(sum[3:2]),.cout(cout));
endmodule