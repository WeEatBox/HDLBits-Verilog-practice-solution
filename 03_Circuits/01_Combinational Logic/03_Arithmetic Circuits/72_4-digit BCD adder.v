module top_module( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [2:0]tmp_cout;
    
    bcd_fadd bcda1(a[ 3: 0], b[ 3: 0],         cin, tmp_cout[0], sum[ 3: 0]);
    bcd_fadd bcda2(a[ 7: 4], b[ 7: 4], tmp_cout[0], tmp_cout[1], sum[ 7: 4]);
    bcd_fadd bcda3(a[11: 8], b[11: 8], tmp_cout[1], tmp_cout[2], sum[11: 8]);
    bcd_fadd bcda4(a[15:12], b[15:12], tmp_cout[2],        cout, sum[15:12]);

endmodule