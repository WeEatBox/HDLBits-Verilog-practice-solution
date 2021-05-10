module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
   
    genvar i;
    generate // generates 99 full adders
        
        for (i=1; i<100;i++) begin:gn
            fa fad_i(a[i],b[i],cout[i-1],cout[i],sum[i]);          
        end
    endgenerate
    
    fa fad_0 (a[0],b[0],cin,cout[0],sum[0]); // the first case

endmodule

module fa(
    input a, b, cin,
    output cout,sum );
    assign {cout,sum} = a + b + cin;
endmodule
