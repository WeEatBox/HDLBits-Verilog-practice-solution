module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    reg [1:0]state,next;
    parameter zero=0,one=1,two=2;
    
    always@(negedge aresetn, posedge clk) begin
        if(~aresetn) state <= zero;
        else state <= next;
       
    end
    
    always@(*) begin
        case(state)
            zero: next <= x? one :zero;//start if x==1 one match, if x==0, zero match
            one : next <= x? one :two ;// 1X if x==1, 11 one match, if x==0, 10, two match
            two : next <= x? one :zero;// 10X if x==1 output z=1,101 one match  , if x==0  100=zero match
        endcase
    end

    assign z = (state==two)&x;
endmodule
