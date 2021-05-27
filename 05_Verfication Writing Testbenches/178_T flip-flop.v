module top_module ();
    reg clk;
    reg reset;
    reg t;
    wire q;
    
    tff m_tff( .clk(clk), .reset(reset), .t(t), .q(q) );
    
    initial begin
        // time = 0;
        clk = 1'b0;
        forever
            #5
            clk = ~clk;
    end
    
    initial begin
        reset = 1'b0;
        #7
        reset = 1'b1;
        #10
        reset = 1'b0;
    end
    
    always@(posedge clk) begin
        if(reset) t <= 1'b0;
        else t <= 1'b1;
    end

endmodule
