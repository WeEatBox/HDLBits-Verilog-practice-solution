module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    reg [2:0] next;
    
    always@(*) begin
        case(y)
            0: next = x? 1:0;
            1: next = x? 4:1;
            2: next = x? 1:2;
            3: next = x? 2:1;
            4: next = x? 4:3;
            default: next = next;
        endcase
    end

    assign z = y==3 | y==4;
    assign Y0 = next[0];

endmodule