`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2024 02:11:23
// Design Name: 
// Module Name: rv_top
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


module rv_top(
    
    //output logic fake_o_top,
    
    input logic clk_top,
    input logic reset_top
    
     
);

    logic [4:0] aluctrl_top;
    logic [31:0] reg_file_a_top;
    logic [31:0] reg_file_b_top;
    logic [31:0] ALUSrc_mux_out;
    logic [31:0] Imm_Gen_out;
    logic [31:0] alu_result_top;
    
    
    logic [31:0] dataMemOutToLSULoad_data;
    logic [31:0] lsu_out_top;
    
    
    logic [31:0] MemMuxToReg_data;
    logic [31:0] instruction_o_top;
    logic [31:0] fromPC_i_top;
    logic [31:0] branchMux_out;
    logic [31:0] pcplus_branch_out;
    logic [31:0] toPC_o_top;
    logic [31:0] jalr_mux_out_top;
        
    logic MemRead_signal;
    logic [1:0 ]MemtoReg_signal;
    logic MemWrite_signal;
    logic ALUSrc_signal;
    logic RegWrite_signal;
    logic and_gate_out;
    logic Branch_signal;
    logic zero_signal;
    logic jalr_signal;

alu alu_Inst(
    .a_i(reg_file_a_top),
    .b_i(ALUSrc_mux_out),
    .aluctrl_i(aluctrl_top),
    
    //.fake_o(fake_o_top),
    .zero_o(zero_signal),
    .result_o(alu_result_top)
  );

alu_dec alu_dec_Inst (
    .op_i(instruction_o_top[6:2]),
    .funct3_i(instruction_o_top[14:12]),
    .funct7b5_i(instruction_o_top[30]),
    
    .aluctrl_o(aluctrl_top)
  );
  
   reg_file reg_file_Inst(
        .clk_i(clk_top),
        .reset_i(reset_top),      
        .write_en_i(RegWrite_signal), 
        .write_data_i(MemMuxToReg_data),
        .write_addr_i(instruction_o_top[11:7]),     
        .read_addr1_i(instruction_o_top[19:15]),
        .read_addr2_i(instruction_o_top[24:20]),
        
        .read_data1_o(reg_file_a_top),
        .read_data2_o(reg_file_b_top)  
   );
   
   alu_src_mux alu_src_mux_Inst(
        .fromRegData_i      (reg_file_b_top),   
        .fromImmGenData_i   (Imm_Gen_out),
        .ALUSrc_signal_i    (ALUSrc_signal), 
                            
        .result_o           (ALUSrc_mux_out)
   );
   
   imm_gen imm_gen_Inst(
     
        .instruction_i(instruction_o_top),
        
        .imm_ext_o(Imm_Gen_out)    
   );
   
   data_mem data_mem_Inst(
   
        .clk_i         (clk_top),  
        .reset_i       (reset_top),              
        .MemWrite_i    (MemWrite_signal),           
        .MemRead_i     (MemRead_signal),            
        .Read_Address_i(alu_result_top),
        .WriteData_i   (lsu_out_top),   
   
        .MemData_o(dataMemOutToLSULoad_data)
   );
   
   lsu lsu_Inst(
        .load_data_i     (dataMemOutToLSULoad_data),    
        .store_data_i    (reg_file_b_top),   
        .funct3_i        (instruction_o_top[14:12]),       
        .byte_offset_i   (alu_result_top[1:0]),  
        .load_or_store_i (instruction_o_top[5]),
        
        .lsu_o           (lsu_out_top)
   );
   
   
   mem_mux mem_mux_Inst(
        .fromALUData_i      (alu_result_top),    
        .fromMemoryData_i   (lsu_out_top),
        .fromPcPlusImm_i    (pcplus_branch_out),
        .fromPcPlus4_i      (toPC_o_top), 
        .MemtoReg_Signal_i  (MemtoReg_signal),
                  
        .result_o           (MemMuxToReg_data)          
   );
   
   
      instruction_mem instruction_mem_Inst(
               
        .read_address_i(fromPC_i_top),
        
        .instruction_o(instruction_o_top) 
   );
   
    program_counter program_counter_Inst(
        .clk_i(clk_top),
        .reset_i       (reset_top),
        .pc_i(jalr_mux_out_top), 
        
        .pc_o(fromPC_i_top)  
   );

 control_unit control_unit_Inst(
   
        .opcode_i  (instruction_o_top[6:2]),
        
        .branch_o  (Branch_signal), 
        .MemRead_o (MemRead_signal), 
        .MemtoReg_o(MemtoReg_signal), 
        .MemWrite_o(MemWrite_signal), 
        .ALUSrc_o  (ALUSrc_signal),
        .jalr_o  (jalr_signal), 
        .RegWrite_o(RegWrite_signal)
   
   );
   
   pc_plus4 pc_plus4_Inst(
        .fromPC_i(fromPC_i_top),
        
        .toPC_o(toPC_o_top)
   );

    pc_plusBranch pc_plusBranch_Inst(
        .fromPC_i       (fromPC_i_top),       
        .fromImmGen_i   (Imm_Gen_out),   
                        
        .added_result_o (pcplus_branch_out)
   );
   
branch_mux branch_mux_Inst(
        .from_pc_plus4_i        (toPC_o_top),     
        .from_pc_plusBranch_i   (pcplus_branch_out),
        .and_gate_signal_i      (and_gate_out),   
        
        .result_o               (branchMux_out)
   );
   
   jalr_mux jalr_mux_Inst(
        .fromALU_i          (alu_result_top),      
        .fromBrunchMux_i    (branchMux_out),
        .jalr_sig           (jalr_signal),       
        
        .jalr_mux_o         (jalr_mux_out_top)
   );


   branch_and_gate branch_and_gate_Inst(
        .Branch_Signal_i(Branch_signal),
        .Zero_i(zero_signal),   
        
        .result_o(and_gate_out)         
   );

 

endmodule
