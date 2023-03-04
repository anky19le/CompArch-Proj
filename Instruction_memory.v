`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2022 01:12:22 PM
// Design Name: 
// Module Name: Instruction_memory
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


module Instruction_memory(
    input [7:0] PC_Address,
    output [7:0] data_out
    );
    
    reg [7:0] data_out;
    reg [7:0] Instruction_Mem [0:3];// Assuming there are four locations of memory
    
    always @(PC_Address) //Whenever there is a change in this value
       begin
       case(PC_Address)      
      
       
       8'b00000001 :
       // Assuming 001 -> load word , 1 -> s1, 0 -> s0 ,last three bits in the instruction is opcode.
       Instruction_Mem[1] = 8'b00110000;//8'b00000001; // The op code stored in this location is for lw
       
       8'b00000010 :
       // add $s1,$s0,$s1
       Instruction_Mem[2] = 8'b01001000; // The op code stored in this location is for add
       
        8'b00000011 :
       //sw $s0, 0($s1)
       Instruction_Mem[3] = 8'b10000001; // The op code stored in this location is for sw
       
       endcase       
       data_out <= Instruction_Mem[PC_Address];
       end

endmodule
