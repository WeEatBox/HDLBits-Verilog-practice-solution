module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
parameter START=0, DATA=1, STOP=2, IDLE=3, ERROR=4;
    reg [2:0] state, next;
    reg [3:0] counter;
    reg [7:0] tmp;
    
    always@(*) begin
        case(state)
            START: next = in? IDLE : DATA; // if two 1's in a row at start, go to idle, otherwise start data receive
            DATA: next = (counter < 8)? DATA : ( in? STOP : ERROR ); // check if alreay 8 bits, otherwise check stop bit
            STOP: next = in? START : DATA; // output done=1, check start bit 0
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
            if(state == DATA) begin
                counter <= counter +1;             
                tmp[counter] <= in;
            end
            else counter <= 4'b0;
        end
    end
    
    assign done = (state == STOP);

    // New: Datapath to latch input bits.
    assign out_byte = tmp;
endmodule
