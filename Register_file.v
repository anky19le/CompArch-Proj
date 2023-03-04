`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/14/2022 01:31:19 PM
// Design Name: 
// Module Name: Register_file
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


module Register_file(
       input readReg1_add, // 1- bit value to determine the source register // This is 4th bit or destination cum source bit
       input readReg2_add, // 1- bit value to determine the source register // This is 3rd bit or source bit
       input writeReg1_add, // Destination register either 0 or 1 to determine if output is expected to be in s0 or s1
       input [7:0] writeData, // The content to be written in address specified with writeReg1(only for load or add data)
       input writeEnable, // This should be turned on when some data is expected to be written into writeData.
       input rst,
       input clk, 
       
       output [7:0] reg_data1, // To fetch the value from src1 , this would mostly be destination address i.e. bit no.4 in instruction
       output [7:0] reg_data2  // Fetches the value from src2, this would mostly be src address i.e. bit no. 3 in instruction
       );

//Create a register bank which holds two registers s0 and s1, each 8-bits wide
reg [7:0] registerFile [0:1];
reg [7:0] reg_data1;
reg [7:0] reg_data2;

// Initialize the register contents to zero
always@(*)
if (rst == 1'b1)
begin

registerFile[0] <= 8'b00000100; // Initialize s0 content to 4;
registerFile[1] <= 8'b00000011; // Initialize s1 content to 3;
end




always@(posedge clk) begin


// In case of add or load instruction put the computed or fetched output data in to the destination register

if(writeEnable == 1'b1 & rst == 1'b0) 
    begin
       #1 registerFile[writeReg1_add] <= writeData; // Giving delays assuming to write or read only after certain propaagation delays
       #1 reg_data1 <= registerFile[readReg1_add];
       #1 reg_data2 <= registerFile[readReg2_add];
    end
else if(writeEnable == 1'b0) begin

       #1 assign  reg_data1 = registerFile[readReg1_add];
       #1 assign reg_data2 = registerFile[readReg2_add];
end

end


endmodule