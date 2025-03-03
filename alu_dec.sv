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
    input  logic [4:0] op_i,                // opcode is 7 bit, the last 5 bit will be used.
    input  logic [2:0] funct3_i,
    input  logic       funct7b5_i, 
    input  logic       funct7b0_i,
    output logic [4:0] aluctrl_o
    );
    
  logic R_sig;
  logic M_sig;
  assign R_sig = op_i[3] & funct7b5_i;
  assign M_sig = op_i[3] & funct7b0_i;

  always_comb begin
    case(op_i)inside
      5'b0?100: begin
        case(funct3_i)
          3'b000:      aluctrl_o = (R_sig)      ?   5'd0  : 
                                   (M_sig)      ?   5'd21 : 5'd1; // sub -- mul -- add ,  addi
          3'b001:      aluctrl_o = (M_sig)      ?   5'd22 : 5'd2; // mulh -- sll ,  slli
          3'b010:      aluctrl_o = (M_sig)      ?   5'd23 : 5'd3; // mulhsu -- slt ,  slti
          3'b011:      aluctrl_o = (M_sig)      ?   5'd24 : 5'd4; // mulhu -- sltu, sltiu
          3'b100:      aluctrl_o = (M_sig)      ?   5'd25 : 5'd5; // div -- xor ,  xori
          3'b101:      aluctrl_o = (funct7b5_i) ?   5'd6  :
                                   (M_sig)      ?   5'd26 : 5'd7; // sra ,  srai -- divu -- srl ,  srli    
          3'b110:      aluctrl_o = (M_sig)      ?   5'd27 : 5'd8; // rem -- or  ,   ori
          3'b111:      aluctrl_o = (M_sig)      ?   5'd28 : 5'd9; // remu -- and ,  andi
          default:     aluctrl_o = 5'd0;                          // default sub                                  
        endcase 
      end
      5'b0?000:  aluctrl_o = 5'd10; // load-store
      5'b11000: begin
        case(funct3_i)
          3'b000:    aluctrl_o = 5'd11; // beq
          3'b001:    aluctrl_o = 5'd12; // bne
          3'b100:    aluctrl_o = 5'd13; // blt
          3'b101:    aluctrl_o = 5'd14; // bge
          3'b110:    aluctrl_o = 5'd15; // bltu
          3'b111:    aluctrl_o = 5'd16; // bgeu
          default:   aluctrl_o = 5'd0;  // default sub     
        endcase
      end
      5'b11011:  aluctrl_o = 5'd17;                                // jal
      5'b11001:  aluctrl_o = (funct3_i == 3'b000) ? 5'd18 : 5'd0;  // jalr -- default sub  
      5'b01101:  aluctrl_o = 5'd19; // lui
      5'b00101:  aluctrl_o = 5'd20; // auipc
  
      // ecall,ebreak

      default:   aluctrl_o = 5'd0;
    endcase
  end
endmodule
