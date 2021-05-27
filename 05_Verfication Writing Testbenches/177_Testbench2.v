module top_module();
    reg clk;
    reg in;
    reg [2:0] s;
    wire out;
    
    q7 m_q7(.clk(clk), .in(in), .s(s), .out(out) );
    
    initial begin
        // time = 0;
        clk = 1'b0;
        in  = 1'b0;
        s   = 3'h2;
        
        #10 // time = 10
        in  = 1'b0;
        s   = 3'h6;
        
        #10 // time = 20
        in  = 1'b1;
        s   = 3'h2;
        
        #10 // time = 30
        in  = 1'b0;
        s   = 3'h7;
        
        #10 // time = 40
        in  = 1'b1;
        s   = 3'h0;
        
        #30 // time = 70
        in  = 1'b0;

    end

    always begin
        #5
        clk = ~clk;
    end
    
    
endmodule
