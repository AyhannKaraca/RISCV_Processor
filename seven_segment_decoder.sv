`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2024 23:57:19
// Design Name: 
// Module Name: seven_segment_decoder
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


module seven_segment_decoder(
    input logic [31:0] data_i,   
    output logic [6:0] seg_o    // 7-segment (a-g) outputs
);

    // take first 4 bits
    logic [3:0] digit;
    assign digit = data_i[3:0];

    // Hexadecimal -> 7-Segment decoder
    always_comb begin
        case (digit)
            4'h0: seg_o = 7'b1000000;
            4'h1: seg_o = 7'b1111001;
            4'h2: seg_o = 7'b0100100;
            4'h3: seg_o = 7'b0110000;
            4'h4: seg_o = 7'b0011001;
            4'h5: seg_o = 7'b0010010;
            4'h6: seg_o = 7'b0000010;
            4'h7: seg_o = 7'b1111000;
            4'h8: seg_o = 7'b0000000;
            4'h9: seg_o = 7'b0010000;
            4'hA: seg_o = 7'b0001000;
            4'hB: seg_o = 7'b0000011;
            4'hC: seg_o = 7'b1000110;
            4'hD: seg_o = 7'b0100001;
            4'hE: seg_o = 7'b0000110;
            4'hF: seg_o = 7'b0001110;
            default: seg_o = 7'b1111111; // All segments are closed
        endcase
    end

endmodule


