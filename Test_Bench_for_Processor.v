`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2022 01:08:19 PM
// Design Name: 
// Module Name: Test_file
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


module Test_Bench_for_Processor(   
    );
    
    reg clock, reset;
    reg [7:0] address;
    
    MIPS_Processor process(.cur_add(address),.rst(reset),.clk(clock));
  
initial begin
clock = 1;  
reset = 1;  // To ensure that the register memory values are stored with initial values.
#2
address <= 8'b00000010; // Calling the store instruction
#2
reset = 0;
#4
reset = 0;
#20
//**************

reset = 0; // Setting to 0 since we dont want the previously updated registers values to be rewritten
#2
address <= 8'b00000000; // Calling the load instruction
#4
reset = 0;
#20
//**************

//reset = 0;
//#2
address <= 8'b00000001;  // Calling the add instruction
#2
reset = 0;
#15 

$finish;
end

always 
#4 clock = ~clock; //Simulating the clock for every four time units.

endmodule
