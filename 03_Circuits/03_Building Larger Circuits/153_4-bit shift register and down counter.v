module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    reg [3:0] tmp;
    
    always@(posedge clk) begin
        if(count_ena) tmp <= tmp - 1;
        else if(shift_ena) tmp <= {tmp[2:0],data};
        else tmp <= tmp;
    end
    
    assign q = tmp;

endmodule