module clock_divider(
    input logic     clk_i,       
    input logic     rst_i,       
    output logic    slow_clk_o  
);
    logic [31:0] counter;

    always_ff @(posedge clk_i) begin
        if (rst_i) begin
            counter <= 32'b0;
            slow_clk_o <= 1'b0;
        end else if (counter == 125_000_000 - 1) begin  // 100 MHz / 0.4 Hz = 250M
            counter <= 32'b0;
            slow_clk_o <= ~slow_clk_o;
        end else begin
            counter <= counter + 1;
        end
    end
    
endmodule
