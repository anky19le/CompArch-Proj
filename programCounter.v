`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2022 10:06:26 AM
// Design Name: 
// Module Name: pc_counter
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


module programCounter(
    input [7:0] cur_pc,
    output [7:0] next_ins_add
    );
//wire [7:0] cur_pc;
//wire [7:0] next_ins_add;
reg [7:0] next_ins_add;
// Here since the next address is only 8 bits wide we are adding only 1 instead of 4.
begin
always @(cur_pc) begin
next_ins_add <= cur_pc + 1;
end
end
endmodule
