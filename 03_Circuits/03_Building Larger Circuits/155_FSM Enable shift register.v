module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    parameter WAIT=0,START=1,SEC=2,TRD=3,FOUR=4;
    reg [2:0]state, next;
    
    always@(*) begin
        case(state)
            WAIT : next = reset? START:WAIT; // wait for reset
            START: next = reset? START:SEC ; // first output=1 sense if the reset is still == 1
            SEC  : next = reset? START:TRD ; // second clk cycle recount if reset is == 1
            TRD  : next = reset? START:FOUR; // third clk cycle recount if reset is == 1
            FOUR : next = reset? START:WAIT; // fourth clk cycle, next state will return to WAIT 
        endcase
    end
    
    always@(posedge clk) begin
        state <= next;
    end
    
    assign shift_ena = (state==START) | (state==SEC) | (state==TRD) | (state==FOUR);

endmodule