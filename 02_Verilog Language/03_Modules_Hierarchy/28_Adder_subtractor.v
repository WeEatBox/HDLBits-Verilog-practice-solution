module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [15:0]wire1,wire2;
    wire [31:0]xorb;
    wire cout;
    add16 ad1( a[15:0 ], xorb[15:0 ],  sub, wire1, cout );
    add16 ad2( a[31:16], xorb[31:16], cout, wire2, 1'bx );
    assign xorb= b^{32{sub}}; //  invert the b input whenever sub is 1
    assign sum = {wire2,wire1};

endmodule
