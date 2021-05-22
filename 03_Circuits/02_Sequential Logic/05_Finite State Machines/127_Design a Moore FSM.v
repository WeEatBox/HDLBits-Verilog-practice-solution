module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    reg [3:1] prev, now;

    
    parameter A=3'b000,B=3'b001,C=3'b011,D=3'b111;
  

    always@(posedge clk) begin
        if(reset) begin 
            {fr3,fr2,fr1,dfr} <= ~(4'b0);                    // reset
            prev <=4'b0;
        end
        else begin 
            
            {fr3,fr2,fr1} <= ~{s[1],s[2],s[3]};              // update
            
            if(s==0) dfr <= 1;
            else begin
                dfr <= (prev>s)? 1: ( (prev<s)?  0:  dfr  ); // check if dfr
            end
            prev <= s;
        end
    end

endmodule