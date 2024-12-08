`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2024 22:44:21
// Design Name: 
// Module Name: lsu
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


module lsu (
    input logic [31:0]  load_data_i,        //from data mem. Read_Data
    input logic [31:0]  store_data_i,       //from register file. rs2
    input logic [2:0]   funct3_i,           //inst[14:12]
    input logic [1:0]   byte_offset_i,      //data momory address input or alu_result[1:0]
    input logic         load_or_store_i,    //opcode[5]--- 0: load  1:store
    output logic [31:0] lsu_o               // the data that will be load or store.
);

    always_comb begin
        if(load_or_store_i)begin
         case (funct3_i)
                3'b000: begin // SB (Store Byte)
                    case (byte_offset_i)
                        2'b00: lsu_o = {load_data_i[31:8], store_data_i[7:0]};
                        2'b01: lsu_o = {load_data_i[31:16], store_data_i[7:0], load_data_i[7:0]};
                        2'b10: lsu_o = {load_data_i[31:24], store_data_i[7:0], load_data_i[15:0]};
                        2'b11: lsu_o = {store_data_i[7:0], load_data_i[23:0]};
                        default : lsu_o = '0;
                    endcase
                end
                3'b001: begin // SH (Store Halfword)
                    case (byte_offset_i)
                        2'b00: lsu_o = {load_data_i[31:16], store_data_i[15:0]};
                        2'b10: lsu_o = {store_data_i[15:0], load_data_i[15:0]};
                        default : lsu_o = '0;
                    endcase
                end
                3'b010: lsu_o = store_data_i; // SW (Store Word)
                default : lsu_o = '0;                                 
            endcase
          end else begin
                case (funct3_i)
                3'b000: begin // LB (Load Byte)
                    case (byte_offset_i)
                        2'b00: lsu_o = {{24{load_data_i[7]}}, load_data_i[7:0]};
                        2'b01: lsu_o = {{24{load_data_i[15]}}, load_data_i[15:8]};
                        2'b10: lsu_o = {{24{load_data_i[23]}}, load_data_i[23:16]};
                        2'b11: lsu_o = {{24{load_data_i[31]}}, load_data_i[31:24]};
                        default : lsu_o = '0;
                    endcase
                end
                3'b001: begin // LH (Load Halfword)
                    case (byte_offset_i)
                        2'b00: lsu_o = {{16{load_data_i[15]}}, load_data_i[15:0]};
                        2'b10: lsu_o = {{16{load_data_i[31]}}, load_data_i[31:16]};
                        default : lsu_o = '0;
                    endcase
                end
                3'b010: lsu_o = load_data_i;  // LW (Load Word)
      
                3'b100: begin // LBU (Load Byte Unsigned)
                    case (byte_offset_i)
                        2'b00: lsu_o = {24'b0, load_data_i[7:0]};
                        2'b01: lsu_o = {24'b0, load_data_i[15:8]};
                        2'b10: lsu_o = {24'b0, load_data_i[23:16]};
                        2'b11: lsu_o = {24'b0, load_data_i[31:24]};
                        default : lsu_o = '0;
                    endcase
                end
                3'b101: begin // LHU (Load Halfword Unsigned)
                    case (byte_offset_i)
                        2'b00: lsu_o = {16'b0, load_data_i[15:0]};
                        2'b10: lsu_o = {16'b0, load_data_i[31:16]};
                        default : lsu_o = '0;
                    endcase
                end
                default : lsu_o = '0;
            endcase
          end       
    end 


    

endmodule


