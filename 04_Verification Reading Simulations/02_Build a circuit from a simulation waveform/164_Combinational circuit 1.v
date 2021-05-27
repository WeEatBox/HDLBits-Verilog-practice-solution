module top_module (
    input a,
    input b,
    output q );//

    assign q = a & b; // output == 1 only when a=1 and b=1

endmodule