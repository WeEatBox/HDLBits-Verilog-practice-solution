module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    wire [2:0]q;
    always@(posedge clk) begin
        if(resetn) {out,q} <= {q,in};
        else {q,out} <= 4'b0;
                
    end

endmodule