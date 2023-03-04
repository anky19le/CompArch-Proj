`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2022 08:25:31 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
    input [7:0] address, // This is obtained from alu for only load or store instruction
    input [7:0] write_data, // What data has to be written in case of MemWrite is set to 1
    input mem_write,
    input mem_read, // This is to see if load is requested
    input clk,
    output [7:0] data_out // Only valid output is obtained in case of load instruction
    );

reg [7:0] data_out; // The output that is returned from the data memory
// Initialize a data memory of 255 memory locations each 8 bit wide
reg [7:0] data_memory_array[0:254];
begin
//Initialize all the memory locations to some value, here each memory location is gonna hold its incremented value
initial begin
        for(integer loc = 0 ; loc < 255 ; loc = loc + 1)
            begin
            data_memory_array[loc] <= 8'b00000001 + loc;
            end 
        end
always@(posedge clk) // To change if possible for address change
       begin
       if(mem_write == 1'b1 & mem_read == 1'b0) // This is in case of store instruction
          begin
             data_memory_array[address] <= write_data;
             
          end
       
       
//always@(posedge clk)
//        begin
        else if(mem_read == 1'b1 & mem_write == 1'b0) // This is in case of load instruction
           begin
                data_out <= data_memory_array[address];
           end 
        end
//        else if (mem_read == 1'b0 & mem_write == 1'b0)
//           begin
//                data_out <= 8'b00000000; // This data_out parameter has to hold 0 if in case of any other operation other than load or store instruction.
//           end
//        end
end
endmodule
