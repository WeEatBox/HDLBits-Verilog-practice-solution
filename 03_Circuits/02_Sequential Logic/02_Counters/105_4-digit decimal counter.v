module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    wire [3:0]q0,q1,q2,q3;
    

    assign ena[1] = (q0==4'd9)?1:0; 
    assign ena[2] = (q1==4'd9&q0==4'd9)?1:0; 
    assign ena[3] =  (q2==4'd9&q1==4'd9&q0==4'd9)?1:0; 
    assign q = {q3,q2,q1,q0};

    bcdcount counter0 (clk, reset,   1'b1, q0);
    bcdcount counter1 (clk, reset, ena[1], q1);
    bcdcount counter2 (clk, reset, ena[2], q2);
    bcdcount counter3 (clk, reset, ena[3], q3);

endmodule

module bcdcount ( // decimal counter
    input clk,
    input reset,
    input enable,
    output [3:0]Q);
    
    
    
    always@(posedge clk) begin
        if(reset) Q <= 4'b0;
        else begin
            if(enable) begin
                if(Q!=4'd9) Q <= Q + 1;
                else Q <= 4'b0;
            end
            else Q <= Q;
        end
        
    end
    
endmodule