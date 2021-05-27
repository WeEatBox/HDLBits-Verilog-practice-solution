module top_module ( output reg A, output reg B );//

    // generate input patterns here
    initial begin
        // time=0;
        A = 1'b0;
        B = 1'b0;
        
        #10; // time=10
        A = 1'b1;
        B = 1'b0;
        
        #5; // time=15
        A = 1'b1;
        B = 1'b1;
  
        #5; // time=20
        A = 1'b0;
        B = 1'b1;
        
        #20; // time=40
        A = 1'b0;
        B = 1'b0;

    end

endmodule
