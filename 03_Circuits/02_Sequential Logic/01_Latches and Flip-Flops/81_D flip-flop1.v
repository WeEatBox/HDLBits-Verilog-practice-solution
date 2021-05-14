module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q );//

    // Use a clocked always block
    //   copy d to q at every positive edge of clk
    //   Clocked always blocks should use non-blocking assignments
    
    always@(posedge clk) begin // assign d to q when clk from 0 to 1
        q<=d;
    end

endmodule