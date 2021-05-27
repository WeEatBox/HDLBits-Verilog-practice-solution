module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
    
    reg state_tmp,next;
    parameter ZERO=0,ONE=1; // first state: ONE go
    
    always@(*) begin
        case(state_tmp)
            ZERO: next = ({a,b}==2'b11)?  ONE:ZERO; //  first state: ZERO goes to state: ONE  when {a,b}==2'b11
            ONE : next = ({a,b}==2'b00)? ZERO: ONE; // second state: ONE  goes to state: ZERO when {a,b}==2'b00
        endcase
    end
    
    always@(posedge clk) begin
        state_tmp <= next;
    end
    
    assign state = state_tmp;
    assign     q = ( ~state&(a!=b) ) | ( state&(a==b) ); // according to K-map

endmodule