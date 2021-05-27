module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    reg start_shifting, shift_done, reset2;
    
    pattern_detect pd( .clk(clk), .reset(reset), .data(data), .start_shifting(start_shifting), .reset2(reset2) );
    // detect pattern 1101
    
    shift_enable   se(.clk(clk), .en(start_shifting), .reset(reset),
                      .shift_ena(shift_ena), .shift_done(shift_done), .reset2(reset2) );
    // shift 4 bits
    
    
    // start of Count and Wait part
    parameter COUNT_EN=0, COUNT=1, WAIT=2;
    reg [1:0] state,next;
    
    always@(*) begin
        case(state)
            COUNT_EN: next = shift_done? (~done_counting? COUNT: WAIT): COUNT_EN; // (~done_counting? COUNT:WAIT)
                                                                                  // in case for 1 clock cycle counting
               COUNT: next = ~done_counting?    COUNT: WAIT;
                WAIT: next = ack?            COUNT_EN: WAIT;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset) state <= COUNT_EN;
        else state <= next;
    end
    
    assign counting = (state == COUNT) | (state == COUNT_EN & shift_done); // COUNT_EN & shift_done for timing match
                                                                           // when output from module: shift_enable
    assign done = state == WAIT;       // wait for ack
    assign  reset2= ack & state==WAIT; // reset2 is for when the whole cycle is done need to initialize everything

endmodule

module pattern_detect (
    input clk,
    input reset,      // Synchronous reset
    input reset2,     // reset2 is for when the whole cycle is done need to initialize everything
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
        if(reset | reset2) state <= START;
        else state <= next;
    end
    
    assign start_shifting = (state==ZERO & data==1) | (state==ONE_3RD); //stick at the final stage
                                                                        // (state==ZERO & data==1) for timing match
                                                                        // to make sure module: shift_enable start to work 
                                                                        // right after pattern detect
endmodule

module shift_enable (
    input clk,
    input en,
    input reset,
    input reset2,    // reset2 is for when the whole cycle is done need to initialize everything
    output shift_done,
    output shift_ena);
    
    parameter WAIT=0,START=1,SEC=2,TRD=3,FOUR=4,DONE=5;
    reg [2:0]state, next;
    
    always@(*) begin
        case(state)
            WAIT : next = START; // wait for enable
            START: next = SEC ; 
            SEC  : next = TRD ; 
            TRD  : next = FOUR; 
            FOUR : next = DONE; 
            DONE : next = DONE;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset | reset2) state <= WAIT;
        else if(en) state <= next;
        else state <= state;
    end
    
    assign shift_ena = (state==START) | (state==SEC) | (state==TRD) | (state==FOUR);
    assign shift_done = state==DONE;

endmodule