`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2024 00:14:09
// Design Name: 
// Module Name: imm_gen
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


module imm_gen(
    input logic [31:0] instruction_i,
    output logic [31:0] imm_ext_o
    );
    
    always_comb begin
        case(instruction_i[6:2])inside
            5'b00?00 : imm_ext_o = {{20{instruction_i[31]}}, instruction_i[31:20]};//I type
            5'b11001 : imm_ext_o = {{20{instruction_i[31]}}, instruction_i[31:20]};//I type(for jalr)
            5'b01000 : imm_ext_o = {{20{instruction_i[31]}}, instruction_i[31:25],instruction_i[11:7]};//S type
            5'b11000 : imm_ext_o = {{20{instruction_i[31]}}, instruction_i[7],instruction_i[30:25],instruction_i[11:8],1'b0};//B type
            5'b0?101 : imm_ext_o = {instruction_i[31:12],12'b0};//U type
            5'b11011 : imm_ext_o = {{12{instruction_i[31]}}, instruction_i[19:12],instruction_i[20],instruction_i[30:21],1'b0};//J type
            
            default    : imm_ext_o = 32'b0;
        endcase
        
    end
endmodule
