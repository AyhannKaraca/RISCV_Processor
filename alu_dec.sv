`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2024 02:08:24
// Design Name: 
// Module Name: alu_dec
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


module alu_dec(
    input  logic [4:0] op_i,// opcode is 7 bit, the last 5 bit will be used.
    input  logic [2:0] funct3_i,
    input  logic       funct7b5_i, 
    output logic [4:0] aluctrl_o
    );
    
    logic R_sub;
    assign R_sub = op_i[3] & funct7b5_i;

  always_comb begin
    case(op_i)inside
      5'b0?100:begin
                case(funct3_i)
                    3'b000:      aluctrl_o = (R_sub) ? 5'b00000 : 5'b00001; // sub -- add ,  addi
                    3'b001:                           aluctrl_o = 5'b00010; // sll ,  slli
                    3'b010:                           aluctrl_o = 5'b00011; // slt ,  slti
                    3'b011:                           aluctrl_o = 5'b00100; // sltu, sltiu
                    3'b100:                           aluctrl_o = 5'b00101; // xor ,  xori
                    3'b101: aluctrl_o = (funct7b5_i) ? 5'b00110 : 5'b00111; // sra ,  srai -- srl ,  srli    
                    3'b110:                           aluctrl_o = 5'b01000; // or  ,   ori
                    3'b111:                           aluctrl_o = 5'b01001; // and ,  andi
                                      default:        aluctrl_o = 5'b00000; // default sub                                  
                                                                     
                endcase 
                end
                
        5'b0?000:  aluctrl_o = 5'b01010; //load-store

                
         5'b11000:begin
                case(funct3_i)
                    3'b000: aluctrl_o = 5'b10010; //beq
                    3'b001: aluctrl_o = 5'b10011; //bne
                    3'b100: aluctrl_o = 5'b10100; //blt
                    3'b101: aluctrl_o = 5'b10101; //bge
                    3'b110: aluctrl_o = 5'b10110; //bltu
                    3'b111: aluctrl_o = 5'b10111; //bgeu
                   default: aluctrl_o = 5'b00000; // default sub     
                endcase
                end
          5'b11011: aluctrl_o = 5'b11000; //jal
          5'b11001: aluctrl_o = (funct3_i == 3'b000) ? 5'b11001 : 5'b00000;//jalr -- default sub
          
          
          5'b01101: aluctrl_o = 5'b11010; //lui
          5'b00101: aluctrl_o = 5'b11011; //auipc
          
          // ecall,ebreak
          
          
          default: aluctrl_o = 5'b00000;
        endcase
        end
endmodule