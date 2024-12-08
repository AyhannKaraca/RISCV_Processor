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
    input logic [31:0] fromRegData_i,
    input logic [31:0] fromImmGenData_i,
    input logic        ALUSrc_signal_i,
    
    output logic [31:0] result_o
    
    );
    
    always_comb begin
    
    if(ALUSrc_signal_i)
        result_o = fromImmGenData_i;
        else
        result_o = fromRegData_i;
          
    end
    
endmodule
