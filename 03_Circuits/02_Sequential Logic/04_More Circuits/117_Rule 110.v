module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 

    
    always@(posedge clk) begin
        if(load) q <= data;
        else begin
            for(int i=1;i<511;i++) begin
                q[i] <= ~q[i+1]&q[i] | q[i]&~q[i-1] | ~q[i]&q[i-1];  // K-map
            end
            q[0] <=  ~q[1]&q[0] | q[0]&~(1'b0) | ~q[0]&(1'b0);
            q[511] <=  ~(1'b0)&q[511] | q[511]&~q[510] | ~q[511]&q[510];
                
        end
        
    end

endmodule
