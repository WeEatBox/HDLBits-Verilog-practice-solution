module top_module ( input clk, input d, output q );

    wire q1,q2;
    my_dff d1(.clk(clk),.d(d) ,.q(q1));
    my_dff d2(.clk(clk),.d(q1),.q(q2));//q1 is the input for d2
    my_dff d3(.clk(clk),.d(q2),.q(q) );//q2 is the input for d3
endmodule
