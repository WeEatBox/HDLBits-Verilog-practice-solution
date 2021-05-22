module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    
    always@(posedge clk) begin
        if(~reset) begin
            if(slowena) begin
                if(q != 9 ) q <= q+1; 
                else q <= 4'b0;
            end
            
        end
        else q <= 4'b0;
    end

endmodule