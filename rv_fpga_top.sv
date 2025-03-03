`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.12.2024 01:10:41
// Design Name: 
// Module Name: rv_fpga_top
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


module rv_fpga_top(
        input logic main_clk,
        input logic main_reset,
        input logic main_switch,
        output logic [15:0] led_o,
        output logic [6:0] seg_o
    );
    
    
    logic slow_clk;
    logic [31:0] reg_data_top;
    logic [31:0] mem_data_top;
    logic [4:0] reg_address_top;
    logic [15:0] mem_address_top;
    logic [31:0] display_data_top;
    

    
    
    clock_divider clock_divider_Inst(
        .clk_i      (main_clk),    
        .rst_i      (main_reset),
            
        .slow_clk_o (slow_clk)
    );
    
    
    display_controller display_controller_Inst(
        .switch_i       (main_switch),   
        .reg_data_i       (reg_data_top),   
        .mem_data_i       (mem_data_top),   
        .reg_addr_i       (reg_address_top),   
        .mem_addr_i       (mem_address_top),
           
        .led_o            (led_o),      
        .display_data_o   (display_data_top)
    );
    
        
    seven_segment_decoder seven_segment_decoder_Inst(
    
        .data_i(display_data_top),
        
        .seg_o(seg_o)
    );
    
    rv_top rv_top_Inst(
        .clk_top(slow_clk),  
        .reset_top(main_reset),
        
       .reg_address_o   (reg_address_top), 
       .mem_address_o   (mem_address_top),
       .reg_data_o      (reg_data_top),   
       .mem_data_o      (mem_data_top)  
    );
    
    
endmodule
