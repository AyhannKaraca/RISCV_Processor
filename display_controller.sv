`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2024 23:53:17
// Design Name: 
// Module Name: display_controller
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


module display_controller(

    input logic         switch_i,             // Switch state
    input logic [31:0]  reg_data_i,           // Register values (from register file)
    input logic [31:0]  mem_data_i,           // Memory values (from data memory)
    input logic [4:0]   reg_addr_i,           // Register address
    input logic [15:0]  mem_addr_i,           // Memory address
    output logic [15:0] led_o,                // LED output
    output logic [31:0] display_data_o
    
);

    always_comb begin
        if (switch_i) begin
            led_o = mem_addr_i;              
            display_data_o = mem_data_i;     
        end else begin
            led_o = {11'b0, reg_addr_i};     
            display_data_o = reg_data_i;     
        end
    end


endmodule

