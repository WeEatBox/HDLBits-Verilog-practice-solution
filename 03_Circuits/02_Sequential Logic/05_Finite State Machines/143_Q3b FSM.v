module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    reg [2:0] state,next;
    
    always@(*) begin
        case(state)
            0: next = x? 1:0;
            1: next = x? 4:1;
            2: next = x? 1:2;
            3: next = x? 2:1;
            4: next = x? 4:3;
            default: next = 0;
        endcase   
    end
    
    always@(posedge clk) begin
        if(reset) state <= 0;
        else state <= next;
    end
    
    assign z = (state==3)|(state==4);

endmodule