module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    
    wire and1, and2, or1;
    assign and1  = a & b;       //first stage
    assign and2  = c & d;       //first stage
    assign or1   = and1|and2;   //second stage
    assign out   = or1;         //output stage
    assign out_n = ~or1;        //output stage

    
endmodule