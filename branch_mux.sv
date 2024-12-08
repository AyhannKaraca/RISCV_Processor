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
    input logic [31:0]      from_pc_plus4_i,
    input logic [31:0]      from_pc_plusBranch_i,
    input logic             and_gate_signal_i,
        
    output logic [31:0]     result_o
    );
    
    always_comb begin
    
    if(and_gate_signal_i)
        result_o = from_pc_plusBranch_i;
        else
        result_o = from_pc_plus4_i;
          
    end
endmodule
