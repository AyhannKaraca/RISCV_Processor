`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2024 02:47:05
// Design Name: 
// Module Name: reg_file
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


module reg_file#(
    parameter MEM_SIZE = 32
)(
    input  logic        clk_i,
    input  logic        reset_i, 

    input  logic        write_en_i,
    input  logic [31:0] write_data_i,  
    input  logic [ 4:0] write_addr_i,

    input  logic [ 4:0] read_addr1_i, 
    input  logic [ 4:0] read_addr2_i,  
    output logic [31:0] read_data1_o, 
    output logic [31:0] read_data2_o
    );

  logic [31:0] regs [0:MEM_SIZE-1];
 
  
  always_ff @(posedge clk_i) begin
    
    if(reset_i) begin
        for(int i = 0; i<MEM_SIZE; i++)begin
            regs[i] <= 32'b0;
        end
    end    
    else if (write_en_i) begin 
      regs[write_addr_i] <= write_data_i;
    end
  end	

  assign read_data1_o = (read_addr1_i != 5'b0) ? regs[read_addr1_i] : 32'b0;
  assign read_data2_o = (read_addr2_i != 5'b0) ? regs[read_addr2_i] : 32'b0;

endmodule

