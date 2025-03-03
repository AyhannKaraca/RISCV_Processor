`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2024 01:51:32
// Design Name: 
// Module Name: data_mem
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


module data_mem #(
    parameter MEM_SIZE = 16
)(
    input  logic        clk_i,
    input  logic        reset_i,
    input  logic        MemWrite_i,
    input  logic        MemRead_i,
    input  logic [31:0] Read_Address_i,
    input  logic [31:0] WriteData_i,
    output logic [31:0] MemData_o 
    );
    
    logic [31:0] Data_Mem [0:MEM_SIZE-1];

    assign MemData_o = (MemRead_i) ? Data_Mem[Read_Address_i >> 2] : 32'b0;
    
    always_ff @(posedge clk_i) begin        
        if(reset_i)begin
            for(int i = 0; i<MEM_SIZE; i++)begin
                Data_Mem[i] <= 32'b0;
            end
        end
        else if(MemWrite_i) begin
            Data_Mem[Read_Address_i>>2] <= WriteData_i;
        end
    end    
endmodule
