`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2024 02:29:38
// Design Name: 
// Module Name: branch_mux
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


module branch_mux(
    input  logic [31:0]      from_pc_plus4_i,
    input  logic [31:0]      from_pc_plusBranch_i,
    input  logic             and_gate_signal_i,  
    output logic [31:0]      result_o
    );

    assign result_o = (and_gate_signal_i) ? from_pc_plusBranch_i : from_pc_plus4_i;
    
endmodule
