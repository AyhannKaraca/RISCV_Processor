`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2024 02:09:43
// Design Name: 
// Module Name: alu
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


module alu(
    input  logic [31:0] a_i, b_i,
    input  logic [4:0]  aluctrl_i, 
    output logic [31:0] result_o,
    output logic        zero_o
    );

  typedef enum logic [4:0] {SUB = 5'd0, ADD = 5'd1, SLL = 5'd2, SLT = 5'd3, SLTU = 5'd4, XOR = 5'd5, SRA = 5'd6, SRL = 5'd7, OR = 5'd8, AND = 5'd9, LOAD_STORE = 5'd10,
                           BEQ = 5'd11, BNE = 5'd12, BLT = 5'd13, BGE = 5'd14, BLTU = 5'd15, BGEU = 5'd16, JAL = 5'd17, JALR = 5'd18, LUI = 5'd19, AUIPC = 5'd20, MUL = 5'd21,
                           MULH = 5'd22, MULHSU = 5'd23, MULHU = 5'd24, DIV = 5'd25, DIVU = 5'd26, REM = 5'd27, REMU = 5'd28} ctrl_t;

  ctrl_t ctrl;
  
  logic [63:0] mulh_result_signed_signed;
  logic [63:0] mulhu_result_unsigned_unsigned;
  logic [63:0] mulhsu_result_signed_unsigned;
  

  assign mulh_result_signed_signed = ($signed(a_i)) * ($signed(b_i));
  assign mulhu_result_unsigned_unsigned = a_i * b_i;
  assign mulhsu_result_signed_unsigned = ($signed(a_i)< 0) ?  -($signed(-a_i) * b_i) : (a_i*b_i);
     
  assign zero_o = (result_o == 0);

  always_comb begin
    ctrl = ctrl_t'(aluctrl_i);

    case (ctrl) 
      SUB :    result_o = a_i - b_i;                                     // sub
      ADD :    result_o = a_i + b_i;                                     // add ,  addi
      SLL :    result_o = a_i << b_i[4:0];                               // sll ,  slli (unsigned) 
      SLT :    result_o = ($signed(a_i) < $signed(b_i)) ? 32'b1 : 32'b0; // slt ,  slti (  signed)
      SLTU:    result_o = (a_i < b_i) ? 32'b1 : 32'b0;                   // sltu, sltiu (unsigned)
      XOR :    result_o = a_i ^ b_i;                                     // xor ,  xori
      SRA :    result_o = $signed(a_i) >>> b_i[4:0];                     // sra ,  srai (  signed)
      SRL :    result_o = a_i >> b_i[4:0];                               // srl ,  srli (unsigned)
      OR  :    result_o = a_i | b_i;                                     // or  ,   ori
      AND :    result_o = a_i & b_i;                                     // and ,  andi
      
      // load-store Instructions
      LOAD_STORE:   result_o = a_i + b_i; //load-store
      
      // branch Instructions
      BEQ :   result_o = (!($signed(a_i) == $signed(b_i)));           // beq 
      BNE :   result_o = (!($signed(a_i) != $signed(b_i)));           // bne 
      BLT :   result_o = (!($signed(a_i) <  $signed(b_i)));           // blt 
      BGE :   result_o = (!($signed(a_i) >= $signed(b_i)));           // bge 
      BLTU:   result_o = (!(a_i < b_i));                              // bltu
      BGEU:   result_o = (!(a_i >= b_i));                             // bgeu

      JAL :   result_o = '0;                                          // jal
      JALR:   result_o =  a_i + b_i;                                  // jalr  
      
      LUI  :   result_o = b_i;                                         // lui
      AUIPC:   result_o = '0;                                          // auipc

      MUL   :   result_o = mulh_result_signed_signed[31:0];             // mul
      MULH  :   result_o = mulh_result_signed_signed[63:32];            // mulh
      MULHSU:   result_o = mulhsu_result_signed_unsigned[63:32];        // mulhsu
      MULHU :   result_o = mulhu_result_unsigned_unsigned[63:32];       // mulhu
      DIV   :   result_o = (b_i) ? ($signed(a_i) / $signed(b_i)) : 32'hFFFFFFFF;     //div
      DIVU  :   result_o = (b_i) ? a_i / b_i : 32'hFFFFFFFF;                         //divu
      REM   :   result_o = (b_i) ? ($signed(a_i) % $signed(b_i)) : $signed(a_i);     //rem
      REMU  :   result_o = (b_i) ? a_i % b_i : a_i;                                  //remu
      default: result_o = 32'b0;                                        
    endcase
  end
endmodule
