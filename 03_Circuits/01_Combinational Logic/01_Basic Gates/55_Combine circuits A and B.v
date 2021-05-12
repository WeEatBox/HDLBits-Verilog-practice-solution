module top_module (input x, input y, output z);
    wire z1,z2;
    a a1(x,y,z1); // first level
    b b1(x,y,z2); // first level
    assign z = (z1|z2)^(z1&z2); // second level

endmodule

module a (input x, input y, output z);
    assign z = (x^y) & x;
endmodule

module b ( input x, input y, output z );
    assign z = (~x&~y) | (x&y);
endmodule