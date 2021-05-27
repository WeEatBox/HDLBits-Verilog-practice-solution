module top_module ( );
    reg clk;
    
    dut u_dut(.clk(clk));

    initial clk =0;
    
    always begin
        
        #5
        clk = ~clk;
    end

endmodule