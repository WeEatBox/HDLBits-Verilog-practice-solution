module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A=0,B=1,C=2,D=3;
    reg [1:0] state,next;
    
    always@(*) begin
        case(state) 
            A: begin
                casez(r)
                    3'b000: next = A;
                    3'bzz1: next = B;
                    3'bz10: next = C;
                    3'b100: next = D;
                endcase
            end
            B: begin
                casez(r)
                    3'bzz1: next = B;
                    3'bzz0: next = A;
                endcase
            end
            C: begin
                casez(r)
                    3'bz0z: next = A;
                    3'bz1z: next = C;
                endcase
            end
            D: begin
                casez(r)
                    3'b0zz: next = A;
                    3'b1zz: next = D;
                endcase
            end
        endcase
    end
    
    always@(posedge clk) begin
        if(~resetn) state <= A;
        else state <= next;
    end
    
    assign g[1] = state==B;
    assign g[2] = state==C;
    assign g[3] = state==D;

endmodule