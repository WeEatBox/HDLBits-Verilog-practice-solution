module top_module( 
    input a, 
    input b, 
    output out );

    assign out = a&b | (~a&~b);// output=1 when a == b
endmodule