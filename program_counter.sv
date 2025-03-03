`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2024 17:50:53
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input  logic         clk_i,
    input  logic         reset_i,
    input  logic  [31:0] pc_i,
    output logic  [31:0] pc_o
    );

    always_ff @(posedge clk_i) begin
        if(reset_i)begin
            pc_o <= 32'b0;
        end
        else begin
            pc_o <= pc_i;
        end
    end
    
endmodule
