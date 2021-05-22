module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A=0,B1=1,B2=2,B3=3;
    reg [1:0]state,next;
    reg [1:0]tmp,tmp2;
    reg flag;
    
    
    always@(*) begin
        case(state)
            A: next= s? B1:A;
            B1: next= B2;
            B2: next= B3;
            B3: next= B1;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset) begin
            state <= A;
            tmp <= 0;
        end
        
        else begin
            if     (state==B1) tmp <= w;//tmp reset
            else if(state==B2) tmp <= tmp + w;
            else if(state==B3) tmp <= tmp + w;
            state <= next;
        end//end else
        
    end//end always
    
    assign z = (state==B1)&(tmp==2);//check when B1

endmodule