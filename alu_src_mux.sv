`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2024 02:07:43
// Design Name: 
// Module Name: alu_src_mux
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


module alu_src_mux(
    input  logic [31:0] fromRegData_i,
    input  logic [31:0] fromImmGenData_i,
    input  logic        ALUSrc_signal_i,
    output logic [31:0] result_o  
    );

    assign result_o = (ALUSrc_signal_i) ? fromImmGenData_i : fromRegData_i;
    
endmodule
