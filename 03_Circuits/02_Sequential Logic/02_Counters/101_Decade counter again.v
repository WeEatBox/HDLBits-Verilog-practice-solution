module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
    
    always@(posedge clk) begin
        if(~reset) begin
            if(q != 10) q <= q+1; 
            else q <= 4'b1;
        end
        else q <= 4'b1;
    end

endmodule