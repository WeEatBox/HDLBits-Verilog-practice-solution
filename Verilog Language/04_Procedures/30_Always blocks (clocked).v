module top_module(
    input clk,
    input a,
    input b,
    output wire out_assign,
    output reg out_always_comb,
    output reg out_always_ff   );
    
    assign out_assign = a ^ b; // continuous
    
    always@(*) out_always_comb = a ^ b; // combinational: blocking
    always@(posedge clk) out_always_ff <= a ^ b; // clocked: non-blocking

endmodule