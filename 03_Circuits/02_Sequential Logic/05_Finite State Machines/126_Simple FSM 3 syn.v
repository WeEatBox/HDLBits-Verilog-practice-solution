module top_module(
    input clk,
    input in,
    input reset,
    output out); //
    
    wire [3:0]state, next_state;
    
    parameter A=0, B=1, C=2, D=3;

    // State transition logic
    assign next_state[A] = state[0]&(~in) | state[2]&(~in);
    assign next_state[B] = state[0]&(in) | state[1]&(in) | state[3]&in;
    assign next_state[C] = state[1]&(~in) | state[3]&(~in);
    assign next_state[D] = state[2]&(in);

    // State flip-flops with synchronous reset
    always@(posedge clk) begin
        if(reset) state <= 4'b0001;
        else state <= next_state;
    end

    // Output logic
     assign out = (state[D]==1);

endmodule