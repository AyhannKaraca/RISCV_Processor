`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2024 02:34:31
// Design Name: 
// Module Name: mem_mux
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


module mem_mux(
    input  logic [31:0] fromALUData_i,
    input  logic [31:0] fromMemoryData_i,
    input  logic [31:0] fromPcPlusImm_i,
    input  logic [31:0] fromPcPlus4_i,
    input  logic [1:0]  MemtoReg_Signal_i,
    output logic [31:0] result_o
    );
    
    always_comb begin
        case(MemtoReg_Signal_i)
            2'b00:   result_o = fromALUData_i;
            2'b01:   result_o = fromMemoryData_i;
            2'b10:   result_o = fromPcPlusImm_i;
            2'b11:   result_o = fromPcPlus4_i;
            default: result_o = 32'b0; 
        endcase
    end
endmodule
