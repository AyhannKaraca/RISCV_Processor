`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2024 02:38:12
// Design Name: 
// Module Name: branch_and_gate
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


module branch_and_gate(
    input logic Branch_Signal_i,
    input logic Zero_i,
    
    output logic result_o
    );
    
    always_comb begin
        result_o = Branch_Signal_i & Zero_i;
    end
endmodule
