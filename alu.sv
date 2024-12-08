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
    
    
    //output logic fake_o,
    output logic [31:0] result_o,
    output logic zero_o
    );
    
    assign zero_o = (result_o == 0);
    //assign fake_o = 1'b1;
    
    always_comb begin
    case (aluctrl_i) 
      5'b00000:  result_o = a_i - b_i;                                     // sub
      5'b00001:  result_o = a_i + b_i;                                     // add ,  addi
      5'b00010:  result_o = a_i << b_i[4:0];                               // sll ,  slli (unsigned) 
      5'b00011:  result_o = (signed'(a_i) < signed'(b_i)) ? 32'b1 : 32'b0; // slt ,  slti (  signed)
      5'b00100:  result_o = (a_i < b_i) ? 32'b1 : 32'b0;                   // sltu, sltiu (unsigned)
      5'b00101:  result_o = a_i ^ b_i;                                     // xor ,  xori
      5'b00110:  result_o = signed'(a_i) >>> b_i[4:0];                     // sra ,  srai (  signed)
      5'b00111:  result_o = a_i >> b_i[4:0];                               // srl ,  srli (unsigned)
      5'b01000:  result_o = a_i | b_i;                                     // or  ,   ori
      5'b01001:  result_o = a_i & b_i;                                     // and ,  andi
      
      //load-store Instructions
      5'b01010:  result_o = a_i + b_i; //load-store
      
      //branch Instructions
      5'b10010:   result_o = (!(signed'(a_i) == signed'(b_i)));        //beq 
      5'b10011:   result_o = (!(signed'(a_i) != signed'(b_i)));         //bne 
      5'b10100:   result_o = (!(signed'(a_i) <  signed'(b_i)));          //blt 
      5'b10101:   result_o = (!(signed'(a_i) >= signed'(b_i)));         //bge 
      5'b10110:   result_o = (!(a_i < b_i));                            //bltu
      5'b10111:   result_o = (!(a_i >= b_i));                           //bgeu
      
      
      5'b11000:   result_o = '0;            //jal
      5'b11001:   result_o =  a_i + b_i;    //jalr
      
      
      5'b11010:  result_o = b_i; //lui
      5'b11011:  result_o = '0;  //auipc
        
        
        
        
      
      
      
      default:  result_o = 32'b0;                                        
    endcase
  end
  
  
  
endmodule
