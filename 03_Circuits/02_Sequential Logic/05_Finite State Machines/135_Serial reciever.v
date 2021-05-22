module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter START=0, DATA=1, STOP=2, IDLE=3, ERROR=4;
    reg [2:0] state, next;
    reg [3:0] counter;
    
    always@(*) begin
        case(state)
            START: next = in? IDLE : DATA; // if two 1's in a low at start, go to idle, otherwise start data receive
            DATA: next = (counter < 8)? DATA : ( in? STOP : ERROR ); // check if alreay 8 bits, otherwise check stop bit
            STOP: next = in? START : DATA; // output done=1, check start bit 
            IDLE: next = in? IDLE : DATA; // check in==0
            ERROR: next = in? IDLE : ERROR; // wait until a stop bit otherwise wait in error
        endcase
    end
    
    always@(posedge clk) begin
        if(reset) begin
            state <= START;
            counter <= 4'b0;
        end
        else begin
            state <= next; 
            if(state == DATA) counter <= counter +1;                     
            else counter <= 4'b0;
        end
    end
    
    assign done = (state == STOP);

endmodule
