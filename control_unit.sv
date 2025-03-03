`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2024 18:45:28
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input  logic [4:0] opcode_i,
    output logic       branch_o, 
    output logic       MemRead_o, 
    output logic [1:0] MemtoReg_o, 
    output logic       MemWrite_o, 
    output logic       ALUSrc_o,
    output logic       jalr_o, 
    output logic       RegWrite_o
    );

    always_comb begin
        case(opcode_i)
            5'b01100 : {jalr_o,ALUSrc_o,MemtoReg_o[1:0],RegWrite_o,MemRead_o,MemWrite_o,branch_o} = 8'b00_00_1000;      //R type control unit signals
            5'b00000 : {jalr_o,ALUSrc_o,MemtoReg_o[1:0],RegWrite_o,MemRead_o,MemWrite_o,branch_o} = 8'b01_01_1_10_0;    //I type load inst's control unit signals
            5'b00100 : {jalr_o,ALUSrc_o,MemtoReg_o[1:0],RegWrite_o,MemRead_o,MemWrite_o,branch_o} = 8'b01_00_1000;      //I type arithmetic op's control unit signals
            5'b01000 : {jalr_o,ALUSrc_o,MemtoReg_o[1:0],RegWrite_o,MemRead_o,MemWrite_o,branch_o} = 8'b01_00_0_01_0;    //S type cnt unit signals
            5'b11000 : {jalr_o,ALUSrc_o,MemtoReg_o[1:0],RegWrite_o,MemRead_o,MemWrite_o,branch_o} = 8'b00_00_0001;      //B type cnt unit signals
            5'b01101 : {jalr_o,ALUSrc_o,MemtoReg_o[1:0],RegWrite_o,MemRead_o,MemWrite_o,branch_o} = 8'b01_00_1000;      //U type cnt unit signals(lui)
            5'b00101 : {jalr_o,ALUSrc_o,MemtoReg_o[1:0],RegWrite_o,MemRead_o,MemWrite_o,branch_o} = 8'b00_10_1000;      //U type cnt unit signals(auipc)
            5'b11011 : {jalr_o,ALUSrc_o,MemtoReg_o[1:0],RegWrite_o,MemRead_o,MemWrite_o,branch_o} = 8'b00_11_1001;      //J type cnt unit signals(jal)
            5'b11001 : {jalr_o,ALUSrc_o,MemtoReg_o[1:0],RegWrite_o,MemRead_o,MemWrite_o,branch_o} = 8'b11_11_1000;      //I type (jalr) 
            default  : {jalr_o,ALUSrc_o,MemtoReg_o[1:0],RegWrite_o,MemRead_o,MemWrite_o,branch_o} = 8'b00_00_0000;
        endcase
    end 
endmodule
