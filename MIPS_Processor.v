`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2022 12:17:47 PM
// Design Name: 
// Module Name: Control_logic
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


module MIPS_Processor(
   input [7:0] cur_add,
   input rst,
   input clk

    );
    
   
    reg [2:0] opcode;
    reg [2:0] offset_val;
    reg writeEnable_1;
    reg is_add;
    reg mem_write_val;
    reg mem_read_val;
    reg [7:0] Register_write_val;
   
    wire [7:0] nxt_ins_add ;
    wire [7:0]data_ins;
 
    wire [7:0] register_data1;
    wire [7:0] register_data2;
    wire [7:0] reg_add_or_signext_val;
    wire [7:0] alu_output;    
    wire [7:0] load_offset;
    wire [7:0] data_memory_output;
    wire [7:0] write_reg_val;
    
    //*********** temporary local variables
    reg [7:0] addressFromPC;
    
  //*************************Calculation of instruction address phase************************  
    begin    
    programCounter pc(.cur_pc(cur_add),.next_ins_add(nxt_ins_add));
    always@(nxt_ins_add)
    begin
     #2 addressFromPC = nxt_ins_add;
    end
  //************************ Instruction Fetching phase**************************************  
    Instruction_memory ins(.PC_Address(addressFromPC),.data_out(data_ins));
  //************************ Instruction Decoding Phase**************************************
    always@(data_ins) // Always when a new instruction is fetched.
    begin
        opcode = data_ins[7:5];
        
        case(opcode) 
    
        3'b001: // For load instruction
             begin
             writeEnable_1 <= 1'b1;
             offset_val <= data_ins[2:0];
             is_add <= 1'b0;
             mem_read_val <= 1'b1;
             mem_write_val <= 1'b0;
             end
        3'b010: // For add instruction
             begin
             writeEnable_1 <= 1'b1;
             is_add <= 1'b1;
             mem_read_val  <= 1'b0;
             mem_write_val <= 1'b0;
             end
        3'b100: // For store instruction
             begin
             writeEnable_1 <= 1'b0;
             is_add <= 1'b0;
             mem_write_val <= 1'b1;
             mem_read_val <= 1'b0;
             end

        endcase
   offset_val <= data_ins[2:0];
   end  

//******************************** Regsiter Memory phase***************************************
//Once the instruction is decoded find the contents stored in source registers and output them    
Register_file rc(.readReg1_add(data_ins[4]),.readReg2_add(data_ins[3]),.writeReg1_add(data_ins[4]),.writeData(Register_write_val),.writeEnable(writeEnable_1),.rst(rst),.clk(clk),.reg_data1(register_data1),.reg_data2(register_data2));

//Find out sign extended address
Sign_extension se(.offset(offset_val) , .sign_extended_val(load_offset));

// Multiplexer to choose between register value and offset value to pass to the alu
two_by_one_mux mux1(.data1(register_data1), .data2(load_offset),.control_signal_mux_2_by_1(~(is_add)),.mux_output(reg_add_or_signext_val));

//******************************** ALU Execution phase******************************************

// In case of add perform sum of two data contents, else calculate the offset value.
ALU_Unit compute(.readData1(reg_add_or_signext_val),.readData2(register_data2),.aluResult(alu_output));   

// ******************************** Data memory unit for load and store isntructions**********************
Data_Memory dm(.address(alu_output),.write_data(register_data2),.mem_write(mem_write_val),.mem_read(mem_read_val),.clk(clk),.data_out(data_memory_output));
//Multiplexer to choose between add operation output and load operation output 

// This mux is called if load instruction value from data memory or add instruction output has to be written into the Register memory.
two_by_one_mux mux2(.data1(alu_output), .data2(data_memory_output),.control_signal_mux_2_by_1(~(is_add)),.clk(clk),.mux_output(write_reg_val));
//This value has to be written back to the register whose instance is called above.
always@(write_reg_val)
    begin 
    Register_write_val <= write_reg_val;
    end


end    


//initial
//begin
//$monitor($time,"nxt_ins_add=% nxt_ins_add,data_ins=% data_ins,register_data1=% register_data1,register_data2=% register_data2,load_offset=% load_offset,alu_output=% alu_output,alu_input_1=% alu_input_1,alu_input_2=% alu_input_2,data_memory_output = %data_memory_output",nxt_ins_add,data_ins,register_data1,register_data2,load_offset,alu_output,alu_input_1,alu_input_2,data_memory_output);


endmodule
