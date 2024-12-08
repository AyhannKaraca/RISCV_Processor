`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2024 23:43:14
// Design Name: 
// Module Name: rv_top_tb
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


module rv_top_tb;

logic reset;
logic clk;

rv_top rv_top_Inst(
    .reset_top(reset),
    .clk_top(clk)
);


  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end
  


  initial begin
  
    reset = 1;
    
    #20;
    reset = 0;

    #650;

    $stop; 
  end
//    initial begin
//        $monitor("Time=%0t | Reset=%d | clock=%d", $time, reset, clk);
//    end  


endmodule
