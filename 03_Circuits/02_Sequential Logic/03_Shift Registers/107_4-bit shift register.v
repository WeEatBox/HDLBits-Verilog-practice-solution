module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
    
    //assign q = (~areset)? q: 4'b0;
    
    always@(posedge clk, posedge areset) begin
        if(areset) q <= 4'b0;
        else if(load) q <= data;
        else if(ena) q <= q>>1;
        else q <= q;
    end
    
   

endmodule