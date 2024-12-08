`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2024 02:23:22
// Design Name: 
// Module Name: pc_plusBranch
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


module pc_plusBranch(
    input logic [31:0] fromPC_i,
    input logic [31:0] fromImmGen_i,
    
    output logic [31:0] added_result_o
    
    );
    
    always_comb begin
        added_result_o = fromPC_i + fromImmGen_i;
    end
endmodule
