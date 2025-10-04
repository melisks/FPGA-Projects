`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2025 11:41:47
// Design Name: 
// Module Name: fadder2
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


module fadder2(
    input [1:0] a, b,
    input cin,
    output [1:0] sum, 
    output cout
    );
    wire c1;
    fadder1 I1(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(c1));
    fadder1 I2(.a(a[1]),.b(b[1]),.cin(c1),.sum(sum[1]),.cout(cout));

endmodule
