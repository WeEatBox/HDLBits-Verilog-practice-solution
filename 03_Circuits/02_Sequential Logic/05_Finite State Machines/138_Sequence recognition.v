module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter START=0,BIT1=1,BIT2=2,BIT3=3,BIT4=4,BIT5=5,BIT6=6,DISC=7,FLAG=8,ERROR=9;
    
    reg [3:0]state,next;
    
    
    always@(*) begin
        case(state)
            START: next= in? BIT1: START;
            BIT1 : next= in? BIT2: START;
            BIT2 : next= in? BIT3: START;
            BIT3 : next= in? BIT4: START;
            BIT4 : next= in? BIT5: START;
            BIT5 : next= in? BIT6 : DISC;
            BIT6 : next= in? ERROR: FLAG;
            DISC : next= in? BIT1 : START;
            FLAG : next= in? BIT1 : START;
            ERROR: next= in? ERROR: START;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset) begin 
            state <= START;
        end
        else begin
            state <= next; 
        end
    end
    
    assign disc = (state==DISC);
    assign flag = (state==FLAG);
    assign err  = (state==ERROR);

endmodule