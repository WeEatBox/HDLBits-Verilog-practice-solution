module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0]sum1,sum2,sum3;
    wire cout;
    add16 a1( a[15:0 ] , b[15:0 ], 1'b0, sum1, cout );
    // upper half bits and lower half bits adding at the same time for shorter time taken
    add16 a2( a[31:16] , b[31:16], 1'b0, sum2, 1'bx );// if carry-out from lower bits is 0
    add16 a3( a[31:16] , b[31:16], 1'b1, sum3, 1'bx );// if carry-out from lower bits is 1
    
    assign sum = cout? ({sum3,sum1}):({sum2,sum1});// check carry-out 1 or 0
   
endmodule