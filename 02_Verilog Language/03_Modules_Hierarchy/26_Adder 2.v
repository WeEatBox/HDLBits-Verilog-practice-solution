module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
    wire [15:0]wire1, wire2;
    wire cout;
    add16 a16_1( a[15:0 ], b[15:0 ], 1'b0, wire1, cout );
    add16 a16_2( a[31:16], b[31:16], cout, wire2, 1'bx );
    assign sum = {wire2,wire1};

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );// module for a FA

// Full adder module here
    assign {cout,sum} = a + b + cin;

endmodule