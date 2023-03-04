`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2022 12:21:51 PM
// Design Name: 
// Module Name: alu
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


module ALU_Unit(
       
       input [7:0] readData1,
       input [7:0] readData2,       
       output [7:0] aluResult
       );
       reg [7:0] aluResult;
       
       always@(readData1,readData2)
       begin
       #5 aluResult = readData1 + readData2; // Perform add instruction
       end
       
endmodule
