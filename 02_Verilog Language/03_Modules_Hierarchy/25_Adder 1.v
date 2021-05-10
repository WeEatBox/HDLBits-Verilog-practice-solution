module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sum1,sum2;
    wire cout,cout2;
    add16 add1( a[15:0 ], b[15:0 ], 1'b0 , sum1, cout );// cout is carry out for add2
    add16 add2( a[31:16], b[31:16], cout , sum2, 1'bx );// 1'bx for don't care
    assign sum = {sum2,sum1};                           // combine 2 arrays as output

endmodule