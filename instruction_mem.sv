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
    parameter MEM_SIZE = 80
)(
    input  logic [31:0] read_address_i,
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
        i_mem[39] = 32'h00418033; // add x0, x3, x4; --> x0 = 0
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
        i_mem[53] = 32'h0000fb37; // lui x22,15 --> x22 = 61440
        i_mem[54] = 32'h00011bb7; // lui x23,17 --> x23 = 69632
        i_mem[55] = 32'h416b8bb3; // sub x23, x23, x22 --> x23 = 8192
        i_mem[56] = 32'h811b8b93; // addi x23, x23, -2031 --> x23 = 6161
        i_mem[57] = 32'h01748623; // sb x23, 12(x9) --> M[8] = 4352(m[33])
        i_mem[58] = 32'h00c48e83; // lb x29, 12(x9) --> x29 = 17
        i_mem[59] = 32'h007c1f03; // lh x30, 7(x24) --> x30 = 20480
        i_mem[60] = 32'h01fc2f83; // lw x31, 31(x24) --> x31 = 4352
        i_mem[61] = 32'h417b0bb3; // sub x23, x22, x23 --> x23 = 55279    -8192
        i_mem[62] = 32'h80800b93; // addi x23, x0, -2040 --> x23 = -2040
        i_mem[63] = 32'h808b8b93; // addi x23, x23, -2040 --> x23 = -4080  
        i_mem[64] = 32'h808b8b93; // addi x23, x23, -2040 --> x23 = -6120 
        i_mem[65] = 32'h808b8b93; // addi x23, x23, -2040 --> x23 = -8160
        i_mem[66] = 32'hfe0b8b93; // addi x23, x23, -32 --> x23 = -8192
        i_mem[67] = 32'hbf9b8c13; // addi x24, x23, -1031 --> x24 = -9223
        i_mem[68] = 32'h01702023; // sw x23, 0(x0) --> M[0] = -8192 
        i_mem[69] = 32'h01802223; // sw x24, 4(x0) --> M[1] = -9223
        i_mem[70] = 32'h00404883; // lbu x17, 4(x0) --> x17 = 249 
        i_mem[71] = 32'h017c0cb3; // add x25, x24, x23; --> x25 = -17415
        i_mem[72] = 32'h019c8cb3; // add x25, x25, x25; --> x25 = -34830
        i_mem[73] = 32'h019c8cb3; // add x25, x25, x25; --> x25 = -69660
        i_mem[74] = 32'h01902823; // sw x25, 16(x0) --> M[4] = -69660
        i_mem[75] = 32'h01205903; // lhu x18, 18(x0) --> x18 = 65534
        i_mem[76] = 32'h808b8b93; // addi x23, x23, -2040 --> x23 = x23-2040
        i_mem[77] = 32'h808b8b93; // addi x23, x23, -2040 --> x23 = x23-2040
        i_mem[78] = 32'h00418033; // add x0, x3, x4 --> x0 = 15, when read 0
        i_mem[79] = 32'h5dc00093; // addi x1, x0, 1500 --> x1 = 1500         
    end

//--- sub_sig is signal for debugging...
    logic [31:0] sub_sig;
    assign sub_sig = (read_address_i >> 2);
//---   

    assign instruction_o = i_mem[read_address_i >> 2];

endmodule
    
    
    
    always_comb begin
            instruction_o = i_mem[read_address_i >> 2];
    end

endmodule
