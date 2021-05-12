module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire cin;
    wire cout[3:0];
    
   
    genvar i;
    generate
        for(i=1;i<$bits(x);i++) begin:gn
            fa fa_i(x[i],y[i],cout[i-1],cout[i],sum[i]);
        end
    endgenerate
    
    fa fa_0(x[0],y[0],cin,cout[0],sum[0]);
    assign sum[4]=cout[3];

endmodule


module fa( input a, input b, input cin, output cout, output sum);
    assign {cout,sum} = a+b+cin;
endmodule