module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0] q0,q1,q2,q3;
    assign q0=d;
    my_dff8 d1(.clk(clk),.d(d) ,.q(q1));
    my_dff8 d2(.clk(clk),.d(q1),.q(q2));
    my_dff8 d3(.clk(clk),.d(q2),.q(q3));
    assign q=(sel==2'b00)?q0 : (  (sel==2'b01)?q1: ((sel==2'b10)?q2: q3)    );// if sel=0, q=q0
                                                                              // if sel=1, q=q1
                                                                              // if sel=2, q=q2
                                                                              // if sel=3, q=q3
endmodule