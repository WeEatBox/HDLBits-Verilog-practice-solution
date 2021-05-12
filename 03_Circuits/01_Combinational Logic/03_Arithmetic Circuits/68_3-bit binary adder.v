module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    genvar i;
    generate
        for(i=1;i<$bits(sum);i++) begin:gn
            fa fa_i(a[i],b[i],cout[i-1],cout[i],sum[i]);
        end
    endgenerate
    
    fa fa_0(a[0],b[0],cin,cout[0],sum[0]);

endmodule

module fa( input a, input b, input cin, output cout, output sum);
    assign {cout,sum} = a+b+cin;
endmodule