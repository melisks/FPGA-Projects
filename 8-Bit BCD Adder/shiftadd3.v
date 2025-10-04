`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.08.2025 11:41:47
// Design Name: 
// Module Name: shiftadd3
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


module shiftadd3(
    input [7:0] in,
    input cin,
    output reg [3:0] out1,out2,out3
    );
integer i;
reg [20:0] temp;
reg [20:0] values;
always @(*)begin
    temp[7:0] = in;
    temp[8] = cin;
    temp[20:9] = 12'd0;
    values = temp;
    for(i = 0; i<9; i=i+1)
    begin
    if(values[12:9] >= 3'd5) values[12:9]=values[12:9]+4'd3;
    if(values[16:13] >= 3'd5) values[16:13]=values[16:13]+4'd3;
    if(values[20:17] >= 3'd5) values[20:17]=values[20:17]+4'd3;
    values = values << 1;
    end
    out1 = values[12:9];
    out2 = values[16:13];
    out3 = values[20:17];
end
endmodule
