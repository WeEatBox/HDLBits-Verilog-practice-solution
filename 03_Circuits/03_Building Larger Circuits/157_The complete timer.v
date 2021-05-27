module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,    
    output counting,
    output done,
    input ack );
    
    reg start_shifting, shift_done, reset2; // reset2 for reset everything after a completer cycle
    
    reg shift_ena; // new, from output to an internal reg
    //input done_counting,
    reg [3:0]delay; // replace done_counting input
    reg [31:0] internal_counter;
    reg done_counting;
    
    // detect pattern 1101
    pattern_detect pd( .clk(clk), .reset(reset), .data(data), .start_shifting(start_shifting), .reset2(reset2) );
   
    // shift 4 bits
    shift_enable   se(.clk(clk), .en(start_shifting), .reset(reset),
                      .shift_ena(shift_ena), .shift_done(shift_done), .reset2(reset2),
                      .data(data), .delay(delay) );// new input data and output delay
        
    // start of Count and Wait part
    parameter COUNT_EN=0, COUNT=1, WAIT=2;
    reg [1:0] state,next;
    
    always@(*) begin // determine done_counting
        if(internal_counter == (delay + 1)*1000-2) done_counting = 1; // start from 0, so -1; end at X999, another -1;
        else done_counting = 0;
    end
    
    always@(*) begin
        case(state)
            COUNT_EN: next = shift_done? (~done_counting? COUNT: WAIT): COUNT_EN; // (~done_counting? COUNT:WAIT)
                                                                                  // in case for 1 clock cycle counting
               COUNT: next = ~done_counting?    COUNT: WAIT;
                WAIT: next = ack?            COUNT_EN: WAIT;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset) begin 
            state <= COUNT_EN;
            internal_counter <= 0;
        end
        else begin
            state <= next;
            if(state == COUNT) internal_counter <= internal_counter + 1; // counter
            else internal_counter <= 0;
        end
    end
    
    assign counting = (state == COUNT) | (state == COUNT_EN & shift_done); // COUNT_EN & shift_done for timing match
                                                                           // when output from module: shift_enable
    assign count = ( ( ((delay + 1)*1000-2)-internal_counter )/1000 );     // start from 0, so -1; end at X999, another -1;
    
    assign done = state == WAIT;      // wait for ack
    assign reset2= ack & state==WAIT; // reset2 is for when the whole cycle is done need to initialize everything

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
    output shift_ena,
    input data,
    output [3:0]delay);
    
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
        
        if(state==START) delay[3] = data;
        if(state==SEC  ) delay[2] = data;
        if(state==TRD  ) delay[1] = data;
        if(state==FOUR ) delay[0] = data;
        
    end
    
    assign shift_ena = (state==START) | (state==SEC) | (state==TRD) | (state==FOUR);
    assign shift_done = state==DONE;

endmodule