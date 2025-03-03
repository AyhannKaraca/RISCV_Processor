`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.12.2024 03:22:52
// Design Name: 
// Module Name: jalr_mux
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


module jalr_mux(
    input  logic [31:0] fromALU_i,
    input  logic [31:0] fromBrunchMux_i,
    input  logic        jalr_sig, 
    output logic [31:0] jalr_mux_o
    );

    assign jalr_mux_o = (jalr_sig) ? fromALU_i : fromBrunchMux_i;
        
endmodule
