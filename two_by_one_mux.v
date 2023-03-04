`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2022 08:04:37 PM
// Design Name: 
// Module Name: 2_to_1_multiplexer
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


module two_by_one_mux(
    input [7:0] data1,
    input [7:0] data2,
    input control_signal_mux_2_by_1,
    input clk,
    output [7:0] mux_output
    );

reg [7:0] mux_output;
begin
always@(data1 or data2 or control_signal_mux_2_by_1,posedge clk)

    begin
        if(control_signal_mux_2_by_1 == 1'b0)
           begin
           mux_output = data1;
           end 
        else if(control_signal_mux_2_by_1 == 1'b1)
           begin
           mux_output = data2;
           end
    end 
end
endmodule
