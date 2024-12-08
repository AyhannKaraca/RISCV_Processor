`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2024 18:11:52
// Design Name: 
// Module Name: instruction_mem
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


module instruction_mem #(
    parameter MEM_SIZE = 64
)(
    
    input logic  [31:0] read_address_i,
    output logic [31:0] instruction_o
    );
    
    logic [31:0] i_mem [0:MEM_SIZE-1];
    
        
        initial begin
      
        i_mem[0] = 32'h00518193; // addi x3, x3, 5 --> x3=5
        i_mem[1] = 32'h00a20213; // addi x4, x4, 10 --> x4=10
        i_mem[2] = 32'h003202b3; // add x5, x4, x3 --> x5=15
        i_mem[3] = 32'h00428333; // add x6, x5, x4 --> x6=25
        i_mem[4] = 32'h404303b3; // sub x7, x6, x4 --> x7=15
        i_mem[5] = 32'h40628433; // sub x8, x5, x6 --> x8=-10
        i_mem[6] = 32'h0062c4b3; // xor x9, x5, x6 --> x9=22
        i_mem[7] = 32'h00d4c513; // xori x10, x9, 13 --> x10=27
        i_mem[8] = 32'h009565b3; // or x11, x10, x9 --> x11=31
        i_mem[9] = 32'h0055e613; // ori x12, x11, 5 --> x12=31
        i_mem[10] = 32'h0075f6b3; // and x13, x11, x7 --> x13=15
        i_mem[11] = 32'h09e5f713; // andi x14, x11, 158 -->x14=30
        i_mem[12] = 32'h003717b3; // sll x15, x14, x3 -->x15=960
        i_mem[13] = 32'h00379813; // slli x16, x15, 3 -->x16=7680
        i_mem[14] = 32'h003858b3; // srl x17, x16, x3 -->x17=240
        i_mem[15] = 32'h0028d913; // srli x18, x17, 2 -->x18=60
        i_mem[16] = 32'h410309b3; // sub x19, x6, x16 -->x19=-7665
        i_mem[17] = 32'h4039da33; // sra x20, x19, x3 -->x20=-240
        i_mem[18] = 32'h401a5a93; // srai x21, x20, 1 -->x21=-120
        i_mem[19] = 32'h0107ab33; // slt x22, x15, x16 -->x22=1
        i_mem[20] = 32'h12c7ab93; // slti x23, x15, 300 -->x23=0
        i_mem[21] = 32'h0129ac33; // slt x24, x19, x18 -->x24=1
        i_mem[22] = 32'h0129bcb3; // sltu x25, x19, x18-->x25=0
        i_mem[23] = 32'h096a3d13; // sltiu x26, x20, 150 -->x26=0
        i_mem[24] = 32'h0f1a3d93; // sltiu x27, x20, 241 -->x27=0
        i_mem[25] = 32'h0f0a8d93; // addi x27, x21, 240 -->x27 = 120
        i_mem[26] = 32'h00ae0e13; // addi x28, x28, 10 --> x28=10
        i_mem[27] = 32'h00ae0e13; // addi x28, x28, 10-->x28+10
        i_mem[28] = 32'h019d0463; // beq x26, x25, 8 --> pc = pc+8
        i_mem[29] = 32'h4819ee93; // ori x29, x19, 1153 -->x29=-6503
        i_mem[30] = 32'h409382b3; // sub x5, x7, x9 10-->x5=-7
        i_mem[31] = 32'h00b34433; // xor x8, x6, x11-->x8=6
        i_mem[32] = 32'h00f40493; // addi x9, x8, 15-->x9=21
        i_mem[33] = 32'h028007ef; // jal x15, 40 --> x15=136--PC=43 
        i_mem[34] = 32'h00878463; // beq x15,x8,8 --> nop,PC=PC+1
        i_mem[35] = 32'h00879463; // bne x15,x8,8--> PC=37
        i_mem[36] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[37] = 32'h018b1463; // bne x22,x24,8-->nop,PC=PC+1
        i_mem[38] = 32'h028d8567; // jalr x10, 40(x27)--> x10=156--PC=40(pc=160) 
        i_mem[39] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[40] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[41] = 32'h0137c463; // blt x15,x19,8 -->nop,PC=PC+1
        i_mem[42] = 32'h0137d463; // bge x15,x19,8 -->PC=44
        i_mem[43] = 32'hfdbbcee3; // blt x23,x27,-36 -->PC=34
        i_mem[44] = 32'h0062e463; // bltu x5,x6,8 -->nop,PC=PC+1
        i_mem[45] = 32'h0062f463; // bgeu x5,x6,8 -->PC=47
        i_mem[46] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[47] = 32'h00096a37; // lui x20, 150--> x20=614400
        i_mem[48] = 32'h00008a97; // auipc x21,8 --> x21=32768+192=32960
        i_mem[49] = 32'h123452b7; // lui x5, 74565 --> x5=305418240
        i_mem[50] = 32'h0051a1a3; // sw x5, 3(x3) --> M[2] = m[8] = 305418240 
        i_mem[51] = 32'h005194a3; // sh x5, 9(x3) --> M[3] = 1342177280(m[14])
        i_mem[52] = 32'h0071a403; // lw x8, 7(x3) --> x8 = M[3] = 1342177280
        i_mem[53] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[54] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[55] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[56] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[57] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[58] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[59] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[60] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[61] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[62] = 32'h00ae0e13; // addi x28, x28, 10
        i_mem[63] = 32'h00ae0e13; // addi x28, x28, 10
      
        
    end

//    for debugging...
   
    logic [31:0] sub_sig;
    assign sub_sig = read_address_i >>2;
    
    
    
    always_comb begin
            instruction_o = i_mem[read_address_i >> 2];
    end

endmodule