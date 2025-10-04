`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2025 11:41:47
// Design Name: 
// Module Name: bcdadder
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


module bcdadder(
    input clk,
    input [7:0] a, b,
    input cin,
    output reg [6:0] display,
    output reg [3:0] segnum
    );
    
    wire c1,c2;
    wire [7:0] sum;
    wire [3:0] one,ten,hun;
    wire [6:0] dis1,dis2,dis3;
    
    reg [19:0] clk_count = 15'd0;
    reg [1:0] seg_count = 2'd0;
    
    fadder4 I1(.a(a[3:0]),.b(b[3:0]),.cin(cin),.sum(sum[3:0]),.cout(c1));
    fadder4 I2(.a(a[7:4]),.b(b[7:4]),.cin(c1),.sum(sum[7:4]),.cout(c2)); 
    shiftadd3 D1(.in(sum),.cin(c2),.out1(one),.out2(ten),.out3(hun));
    btdconverter U1(.in(one),.out(dis1));
    btdconverter U2(.in(ten),.out(dis2));
    btdconverter U3(.in(hun),.out(dis3));
    
    //Segment refresh rate"
    always @(posedge clk) begin        
            clk_count <= clk_count + 1;
            seg_count <= clk_count[19:18];
    end
    
    //Segment selection and Data change
    always @(*)begin
    case (seg_count)
            2'b00: segnum  = 4'b1110;   // enable digit1
            2'b01: segnum  = 4'b1101;   // enable digit2
            2'b10: segnum  = 4'b1011;   // enable digit3
            2'b11: segnum  = 4'b0111;   // enable digit4
        endcase
    end
    
    always @(*)begin
    case (seg_count)
            2'b00: display  = dis1;
            2'b01: display  = dis2;   
            2'b10: display  = dis3;   
            2'b11: display  = 7'b0000_001;
    endcase 
    end
endmodule