module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter START=0,ONE=1,ONE_2ND=2,ZERO=3,ONE_3RD=4;
    reg[2:0] state,next;
    
    always@(*) begin
        case(state)
              START: next = data?     ONE:START;
                ONE: next = data? ONE_2ND:START;
            ONE_2ND: next = data? ONE_2ND: ZERO;
               ZERO: next = data? ONE_3RD:START;
            ONE_3RD: next = ONE_3RD;
        endcase
    end
    always@(posedge clk) begin
        if(reset) state <= START;
        else state <= next;
    end
    
    assign start_shifting = state==ONE_3RD; //stick at the final stage

endmodule