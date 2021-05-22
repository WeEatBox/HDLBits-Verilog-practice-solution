module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Modify FSM and datapath from Fsm_serialdata

    // Use FSM from Fsm_serial
parameter START=0, DATA=1, STOP=2, IDLE=3, ERROR=4;
    reg [3:0] state, next;
    reg [3:0] counter;
    reg [8:0] tmp;
    wire odd, res, odd_tmp;
    
    always@(*) begin
        case(state)
            START: next = in? IDLE : DATA; // if two 1's in a row at start, go to idle, otherwise start data receive
            DATA: next = (counter < 9)? DATA : ( in? STOP : ERROR ); // check if alreay 9 bits, otherwise check stop bit 
            STOP: next = in? START : DATA; // output done=1, check start bit 
            IDLE: next = in? IDLE : DATA; // check in==0
            ERROR: next = in? IDLE : ERROR; // wait until a stop bit otherwise wait in error
        endcase
    end
    
    always@(posedge clk) begin
        if(reset) begin
            state <= START;
            counter <= 4'b0;
          //  res <= 1;
        end
        else begin
            state <= next; 
            if(state == DATA) begin
                counter <= counter +1;             
                tmp[counter] <= in;
         //       res <= 0;
           //     odd_tmp <= odd;
            end
            else begin 
                counter <= 4'b0;
            //    res <= 1;
            end
        end
    end
    assign odd_tmp = tmp[0]+tmp[1]+tmp[2]+tmp[3]+tmp[4]+tmp[5]+tmp[6]+tmp[7]+tmp[8];
    assign done = (state == STOP && odd_tmp );

    // New: Datapath to latch input bits.
    assign out_byte = tmp[7:0];
    // New: Add parity checking.
   // parity p1(clk, res, in, odd);
endmodule
