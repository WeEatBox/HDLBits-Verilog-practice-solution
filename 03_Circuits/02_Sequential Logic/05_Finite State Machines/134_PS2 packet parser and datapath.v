module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
parameter B1=0,B2=1,B3=2,DONE=3;
    // FSM from fsm_ps2
  reg [1:0] state, next;
    reg [23:0]out_bytes_tmp;
    // State transition logic (combinational)
    always@(*) begin
        case(state)
            B1: next = in[3]? B2 : B1;
            B2: next = B3;
            B3: next = DONE;
            DONE: next = in[3]? B2 : B1;
        endcase
    end
    // State flip-flops (sequential)
    always@(posedge clk) begin
        if(reset)  begin
            state <= B1;
    
        end
        else begin 
            state <= next;
            out_bytes_tmp[23:16] <= ( (state==B1 & in[3]==1) | (state==DONE & in[3]==1) )? in : out_bytes_tmp[23:16];
            out_bytes_tmp[15:8] <= (state==B2)? in : out_bytes_tmp[15:8];
            out_bytes_tmp[7:0] <= (state==B3)? in : out_bytes_tmp[7:0];
        end
    end
    // Output logic
    assign done = (state==DONE);
    // New: Datapath to store incoming bytes.

    assign out_bytes = (state==DONE) ? out_bytes_tmp : out_bytes;
endmodule